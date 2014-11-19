require 'spec_helper'

describe "for_selects/new" do
  before(:each) do
    assign(:for_select, stub_model(ForSelect,
      :code => "MyString",
      :value => "MyString",
      :text => "MyString",
      :grouper => "MyString",
      :option_order => 1,
      :facility => "MyString"
    ).as_new_record)
  end

  it "renders new for_select form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", for_selects_path, "post" do
      assert_select "input#for_select_code[name=?]", "for_select[code]"
      assert_select "input#for_select_value[name=?]", "for_select[value]"
      assert_select "input#for_select_text[name=?]", "for_select[text]"
      assert_select "input#for_select_grouper[name=?]", "for_select[grouper]"
      assert_select "input#for_select_option_order[name=?]", "for_select[option_order]"
      assert_select "input#for_select_facility[name=?]", "for_select[facility]"
    end
  end
end
