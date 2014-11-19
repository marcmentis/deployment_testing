require 'spec_helper'

describe "for_selects/edit" do
  before(:each) do
    @for_select = assign(:for_select, stub_model(ForSelect,
      :code => "MyString",
      :value => "MyString",
      :text => "MyString",
      :grouper => "MyString",
      :option_order => 1,
      :facility => "MyString"
    ))
  end

  it "renders the edit for_select form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", for_select_path(@for_select), "post" do
      assert_select "input#for_select_code[name=?]", "for_select[code]"
      assert_select "input#for_select_value[name=?]", "for_select[value]"
      assert_select "input#for_select_text[name=?]", "for_select[text]"
      assert_select "input#for_select_grouper[name=?]", "for_select[grouper]"
      assert_select "input#for_select_option_order[name=?]", "for_select[option_order]"
      assert_select "input#for_select_facility[name=?]", "for_select[facility]"
    end
  end
end
