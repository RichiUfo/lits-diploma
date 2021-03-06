require 'rails_helper'

RSpec.describe Admin::SourcesController, type: :controller do
  let(:valid_attributes) {
    skip('Add a hash of attributes valid for your model')
  }

  let(:invalid_attributes) {
    skip('Add a hash of attributes invalid for your model')
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all sources as @sources' do
      source = Source.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:sources)).to eq([source])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested admin_source as @admin_source' do
      source = Source.create! valid_attributes
      get :show, params: { id: source.to_param }, session: valid_session
      expect(assigns(:admin_source)).to eq(source)
    end
  end

  describe 'GET #new' do
    it 'assigns a new admin_source as @admin_source' do
      get :new, params: {}, session: valid_session
      expect(assigns(:admin_source)).to be_a_new(Source)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested admin_source as @admin_source' do
      source = Source.create! valid_attributes
      get :edit, params: { id: source.to_param }, session: valid_session
      expect(assigns(:admin_source)).to eq(source)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Source' do
        expect {
          post :create, params: { admin_source: valid_attributes }, session: valid_session
        }.to change(Source, :count).by(1)
      end

      it 'assigns a newly created admin_source as @admin_source' do
        post :create, params: { admin_source: valid_attributes }, session: valid_session
        expect(assigns(:admin_source)).to be_a(Source)
        expect(assigns(:admin_source)).to be_persisted
      end

      it 'redirects to the created admin_source' do
        post :create, params: { admin_source: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Source.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved admin_source as @admin_source' do
        post :create, params: { admin_source: invalid_attributes }, session: valid_session
        expect(assigns(:admin_source)).to be_a_new(Source)
      end

      it 're-renders the "new" template' do
        post :create, params: { admin_source: invalid_attributes }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested admin_source' do
        source = Source.create! valid_attributes
        put :update,
            params: { id: source.to_param, admin_source: new_attributes },
            session: valid_session
        source.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested admin_source as @admin_source' do
        source = Source.create! valid_attributes
        put :update,
            params: { id: source.to_param, admin_source: valid_attributes },
            session: valid_session
        expect(assigns(:admin_source)).to eq(source)
      end

      it 'redirects to the admin_source' do
        source = Source.create! valid_attributes
        put :update,
            params: { id: source.to_param, admin_source: valid_attributes },
            session: valid_session
        expect(response).to redirect_to(source)
      end
    end

    context 'with invalid params' do
      it 'assigns the admin_source as @admin_source' do
        source = Source.create! valid_attributes
        put :update,
            params: { id: source.to_param, admin_source: invalid_attributes },
            session: valid_session
        expect(assigns(:admin_source)).to eq(source)
      end

      it 're-renders the "edit" template' do
        source = Source.create! valid_attributes
        put :update,
            params: { id: source.to_param, admin_source: invalid_attributes },
            session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested admin_source' do
      source = Source.create! valid_attributes
      expect {
        delete :destroy, params: { id: source.to_param }, session: valid_session
      }.to change(Source, :count).by(-1)
    end

    it 'redirects to the sources list' do
      source = Source.create! valid_attributes
      delete :destroy, params: { id: source.to_param }, session: valid_session
      expect(response).to redirect_to(sources_url)
    end
  end
end
