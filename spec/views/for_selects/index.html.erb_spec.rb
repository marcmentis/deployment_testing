require 'spec_helper'

describe "for_selects/index" do
  before(:each) do
    assign(:for_selects, [
      stub_model(ForSelect,
        :code => "Code",
        :value => "Value",
        :text => "Text",
        :grouper => "Grouper",
        :option_order => 1,
        :facility => "Facility"
      ),
      stub_model(ForSelect,
        :code => "Code",
        :value => "Value",
        :text => "Text",
        :grouper => "Grouper",
        :option_order => 1,
        :facility => "Facility"
      )
    ])
  end

  it "renders a list of for_selects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => "Grouper".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Facility".to_s, :count => 2
  end
end
