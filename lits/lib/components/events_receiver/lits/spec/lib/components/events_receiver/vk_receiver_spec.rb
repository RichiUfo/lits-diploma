require 'rails_helper'

RSpec.describe Components::EventsReceiver::VkReceiver do
  describe 'VkReceiver' do

    let(:receiver) do
      Components::EventsReceiver::VkReceiver.instance
    end

    let(:event_id) { 123251774 }

    let(:source_id) { 74120822 } 

    it 'Has to return API result with type "Hashie::Mash"' do
      api_result = receiver.get_raw_event(event_id)
      expect(api_result).to be_an_instance_of(Hashie::Mash)
    end

    it 'Has to format event into hash for creation a model' do
      api_result = receiver.get_event(event_id)
      event = Event.new api_result
      expect(event).to be_valid
    end

    it "Has to replace a pattern with a source vk id" do
      expect(receiver.source_event_url(11111)).to include('11111')
    end

    it 'Has to get a list of events for source' do 
      list = receiver.source_events_ids source_id
      expect(list.all?{ |id| id.to_i > 0 }).to be_truthy
    end 
  end
end
