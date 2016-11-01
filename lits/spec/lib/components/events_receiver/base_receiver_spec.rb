require 'rails_helper'

RSpec.describe Components::EventsReceiver::BaseReceiver do
  describe 'Implementation of abstract class' do
    let(:receiver) do
      Object.const_set(:Receiver, Components::EventsReceiver::BaseReceiver).new
    end

    it 'Has to throw errors on methods needed to be implemented' do
      raised_error = Components::EventsReceiver::MethodNotImplementedError

      expect{ receiver.source_events_ids(1) }.to raise_error(raised_error)
      expect{ receiver.get_raw_event(1) }.to raise_error(raised_error)
      expect{ receiver.get_event(1) }.to raise_error(raised_error)
      expect{ receiver.format_event({date: Time.now}) }.to raise_error(raised_error)
    end
  end
end
