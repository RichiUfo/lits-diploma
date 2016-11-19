require 'rails_helper'

RSpec.describe "admin/sources/show", type: :view do
  before(:each) do
    @admin_source = assign(:admin_source, Source.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
