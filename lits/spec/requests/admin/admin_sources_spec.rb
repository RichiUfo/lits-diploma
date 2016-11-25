require 'rails_helper'

RSpec.describe 'Admin::Sources', type: :request do
  describe 'GET /topsecret/sources' do
    it 'Get list of admin sources' do
      get admin_sources_path
      expect(response).to have_http_status(200)
    end
  end
end
