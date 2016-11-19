require 'rails_helper'

RSpec.describe "admin/sources/new", type: :view do
  before(:each) do
    assign(:admin_source, Source.new())
  end

  it "renders new admin_source form" do
    render

    assert_select "form[action=?][method=?]", sources_path, "post" do
    end
  end
end
