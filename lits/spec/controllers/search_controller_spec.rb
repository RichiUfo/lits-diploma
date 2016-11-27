require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    it 'Has to redirect to root if there is no "q" param' do
      get :index
      expect(response).to redirect_to(root_path)
    end

    it 'Has to redirect to root if "q" param is empty ' do
      get :index, params: { q: nil }
      expect(response).to redirect_to(root_path)
    end

    it 'Has to redirect page with pretty url' do
      get :index, params: { q: :lil }
      p response.body_parts
      expect(response).to redirect_to(action: :search, q: :lil)
    end
  end

  describe 'GET #search' do
    it 'Has to redirect to root if "q" param is empty ' do
      get :search
      expect(response).to redirect_to(root_path)
    end
  end
end
