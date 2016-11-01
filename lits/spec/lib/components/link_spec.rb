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
  end
end
