require "rails_helper"

RSpec.describe Admin::SourcesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/sources").to route_to("admin/sources#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/sources/new").to route_to("admin/sources#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/sources/1").to route_to("admin/sources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/sources/1/edit").to route_to("admin/sources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/sources").to route_to("admin/sources#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/sources/1").to route_to("admin/sources#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/sources/1").to route_to("admin/sources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/sources/1").to route_to("admin/sources#destroy", :id => "1")
    end

  end
end
