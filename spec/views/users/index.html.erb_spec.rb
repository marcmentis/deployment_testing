require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :firstname => "Firstname",
        :lastname => "Lastname",
        :authen => "Authen",
        :facility => "Facility",
        :role => "Role",
        :email => "Email",
        :firstinitial => "Firstinitial",
        :middleinitial => "Middleinitial",
        :updated_by => "Updated By"
      ),
      stub_model(User,
        :firstname => "Firstname",
        :lastname => "Lastname",
        :authen => "Authen",
        :facility => "Facility",
        :role => "Role",
        :email => "Email",
        :firstinitial => "Firstinitial",
        :middleinitial => "Middleinitial",
        :updated_by => "Updated By"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Authen".to_s, :count => 2
    assert_select "tr>td", :text => "Facility".to_s, :count => 2
    assert_select "tr>td", :text => "Role".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Firstinitial".to_s, :count => 2
    assert_select "tr>td", :text => "Middleinitial".to_s, :count => 2
    assert_select "tr>td", :text => "Updated By".to_s, :count => 2
  end
end
