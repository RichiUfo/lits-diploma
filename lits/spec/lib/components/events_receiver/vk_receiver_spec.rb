require 'rails_helper'

RSpec.describe Components::EventsReceiver::VkReceiver do
  describe 'VkReceiver' do

    let(:receiver) do
      Components::EventsReceiver::VkReceiver.new
    end

    let(:event_id) do
      123251774
    end

    it 'Has to return API result with type "Hashie::Mash"' do
      api_result = receiver.get_raw_event(event_id)
      expect(api_result).to be_an_instance_of(Hashie::Mash)
    end

    it 'Has to format event into hash for creation a model' do
      api_result = receiver.get_event(event_id)
      event = Event.new api_result
      expect(event).to be_valid
    end
  end
end
