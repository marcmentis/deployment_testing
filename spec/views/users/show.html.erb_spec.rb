require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :firstname => "Firstname",
      :lastname => "Lastname",
      :authen => "Authen",
      :facility => "Facility",
      :role => "Role",
      :email => "Email",
      :firstinitial => "Firstinitial",
      :middleinitial => "Middleinitial",
      :updated_by => "Updated By"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Firstname/)
    rendered.should match(/Lastname/)
    rendered.should match(/Authen/)
    rendered.should match(/Facility/)
    rendered.should match(/Role/)
    rendered.should match(/Email/)
    rendered.should match(/Firstinitial/)
    rendered.should match(/Middleinitial/)
    rendered.should match(/Updated By/)
  end
end
