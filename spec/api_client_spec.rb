require_relative './spec_helper'
require_relative '../lib/teachable-api-client/api_client'
require_relative '../lib/teachable-api-client/errors/record_invalid_error'

describe 'API Client' do
  let(:token) { 'active-token' }
  let(:client) { TeachableApiClient::ApiClient.from_token(token) }

  context 'Creating lists' do
    it 'should create list with specified name', :vcr do
      result = client.lists.create(name: 'my list')
      expect(result.name).to eql('my list')
      expect(result.id).not_to be_nil
      expect(result.src).to include(result.id)
    end

    it 'should show newly created lists in index results', :vcr do
      list1 = client.lists.create(name: 'list 1')
      list2 = client.lists.create(name: 'list 2')
      list_index = client.lists.index
      expect(list_index.map(&:id)).to include(list1.id)
      expect(list_index.map(&:id)).to include(list2.id)
    end

    it 'should raise error when list with same name already exists', :vcr do
      client.lists.create(name: 'list 6')
      expect { client.lists.create(name: 'list 6') }.to raise_error do |error|
        expect(error).to be_a(TeachableApiClient::Errors::RecordInvalidError)
        expect(error.validation_errors).to eql('name' => ['has already been taken'])
      end
    end

    it 'should update list when patch method is called', :vcr do
      list = client.lists.create(name: 'list 3')
      expect(client.lists.update(list.id, name: 'my new list!')).to be_truthy
      expect(client.lists.show(list.id).name).to eql('my new list!')
    end

    it 'should raise 404 when list is not found with given id', :vcr do
      expect { client.lists.show('some-id-that-does-not-exist') }.to raise_error(RestClient::ResourceNotFound)
    end

    it 'should destroy list when delete method is called', :vcr do
      list = client.lists.create(name: 'list 4')
      expect(client.lists.delete(list.id)).to be_truthy
      expect(client.lists.index.map(&:id)).not_to include(list.id)
    end
  end

  context 'List items' do
    it 'should return new list item when it is added', :vcr do
      list = client.lists.create(name: 'list with items')
      expect(list.items).to be_nil
      list_item = client.list_items(list.id).create(name: 'my item')
      expect(list_item.name).to eql('my item')
      expect(list_item.finished_at).to be_nil
      expect(client.lists.show(list.id).items).to include(list_item)
    end

    it 'should allow adding multiple list items with the same name', :vcr do
      list = client.lists.create(name: 'list with duplicate items')
      list_item1 = client.list_items(list.id).create(name: 'item')
      list_item2 = client.list_items(list.id).create(name: 'item')
      resulting_items = client.lists.show(list.id).items
      expect(resulting_items).to include(list_item1, list_item2)
    end

    it 'should remove item when marking it finished', :vcr do
      list = client.lists.create(name: 'list with items2')
      list_item1 = client.list_items(list.id).create(name: 'item1')
      list_item2 = client.list_items(list.id).create(name: 'item2')
      expect(client.list_items(list.id).finish(list_item1.id)).to be_truthy
      resulting_items = client.lists.show(list.id).items
      expect(resulting_items).to include(list_item2)
      expect(resulting_items).not_to include(list_item1)
    end
  end
end
