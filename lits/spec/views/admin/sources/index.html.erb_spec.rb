require 'rails_helper'

RSpec.describe "admin/sources/index", type: :view do
  before(:each) do
    assign(:sources, [
      Source.create!(),
      Source.create!()
    ])
  end

  it "renders a list of admin/sources" do
    render
  end
end
