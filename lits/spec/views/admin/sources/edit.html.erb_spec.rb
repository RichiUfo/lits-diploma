require 'rails_helper'

RSpec.describe "admin/sources/edit", type: :view do
  before(:each) do
    @admin_source = assign(:admin_source, Source.create!())
  end

  it "renders the edit admin_source form" do
    render

    assert_select "form[action=?][method=?]", admin_source_path(@admin_source), "post" do
    end
  end
end
