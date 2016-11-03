require 'rails_helper'

RSpec.describe Components::EventsReceiver::ReceiverFactory do
  describe 'ReceiverFactory' do
    it 'Has to throw error if source type id doesnt exists' do
      expect{ Components::EventsReceiver::ReceiverFactory.source_receiver(:pinterest) }.to raise_error(ArgumentError)
    end

    it 'Has to return right receivers' do
      expect(Components::EventsReceiver::ReceiverFactory.source_receiver(:vk)).to(
        be_an_instance_of(Components::EventsReceiver::VkReceiver)
      )

      skip 'not implemented yet' do
        expect(Components::EventsReceiver::ReceiverFactory.source_receiver(:fb)).to(
          be_an_instance_of(Components::EventsReceiver::FbReceiver)
        )

        expect(Components::EventsReceiver::ReceiverFactory.source_receiver(:dou)).to(
          be_an_instance_of(Components::EventsReceiver::DouReceiver)
        )
      end

    end
  end
end
