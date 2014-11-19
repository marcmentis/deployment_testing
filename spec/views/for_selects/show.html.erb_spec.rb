require 'spec_helper'

describe "for_selects/show" do
  before(:each) do
    @for_select = assign(:for_select, stub_model(ForSelect,
      :code => "Code",
      :value => "Value",
      :text => "Text",
      :grouper => "Grouper",
      :option_order => 1,
      :facility => "Facility"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    rendered.should match(/Value/)
    rendered.should match(/Text/)
    rendered.should match(/Grouper/)
    rendered.should match(/1/)
    rendered.should match(/Facility/)
  end
end
