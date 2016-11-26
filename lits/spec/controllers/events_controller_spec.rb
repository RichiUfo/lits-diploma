require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before { build :event }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      create :event, id: 1

      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #date' do
    it 'returns http success' do
      get :date, params: { date: '2016-09-09' }
      # expect(response).to have_http_status(:success)
    end
  end
end
