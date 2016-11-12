require 'rails_helper'

RSpec.describe Components::Link do
  describe 'Parsing google forms links' do
    let(:short_link) { 'http://goo.gl/forms/Q6WzkWwOYN?dd=34' }
    let(:full_link) { 'https://docs.google.com/forms/d/e/1FAIpQLSfn4iYiIIHDhUuTb642v-xBkwdTkl7khI8iqWjzLbTxhRLnTA/viewform' }

    let(:short_link_ipsum) do
      Faker::Lorem.sentence + ' ' + short_link + ' ' + Faker::Hipster.sentence
    end

    let(:full_link_ipsum) do
      Faker::Lorem.sentence + ' ' + full_link + ' ' + Faker::Hipster.sentence
    end

    it "Has to find short link" do
      found_link = Components::Link.parse_registration_link(short_link_ipsum)
      expect(found_link).to eq(short_link)
    end

    it "Has to find full link" do
      found_link = Components::Link.parse_registration_link(full_link_ipsum) 
      expect(found_link).to eq(full_link)
    end

    it 'Has to generate right vk event link' do
      vk_source_type = SourceType.find_by(name: :vk)

      original_link = Components::Link.original_event_url vk_source_type, 11111
      expect(original_link).to eq('https://vk.com/event11111')
    end

    it 'Has to generate right fb event link' do
      fb_source_type = SourceType.find_by(name: :fb)

      original_link = Components::Link.original_event_url fb_source_type, 11111
      expect(original_link).to eq('https://facebook.com/11111')
    end

    it 'Has to generate right dou event link' do
      dou_source_type = SourceType.find_by(name: :dou)

      original_link = Components::Link.original_event_url dou_source_type, 11111
      expect(original_link).to eq('https://dou.ua/calendar/11111/')
    end
  end
end
