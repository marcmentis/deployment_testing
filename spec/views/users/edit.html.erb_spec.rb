require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :firstname => "MyString",
      :lastname => "MyString",
      :authen => "MyString",
      :facility => "MyString",
      :role => "MyString",
      :email => "MyString",
      :firstinitial => "MyString",
      :middleinitial => "MyString",
      :updated_by => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_firstname[name=?]", "user[firstname]"
      assert_select "input#user_lastname[name=?]", "user[lastname]"
      assert_select "input#user_authen[name=?]", "user[authen]"
      assert_select "input#user_facility[name=?]", "user[facility]"
      assert_select "input#user_role[name=?]", "user[role]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_firstinitial[name=?]", "user[firstinitial]"
      assert_select "input#user_middleinitial[name=?]", "user[middleinitial]"
      assert_select "input#user_updated_by[name=?]", "user[updated_by]"
    end
  end
end
