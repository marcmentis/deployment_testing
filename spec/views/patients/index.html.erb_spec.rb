require 'spec_helper'

describe "patients/index" do
  before(:each) do
    assign(:patients, [
      stub_model(Patient,
        :firstname => "Firstname",
        :lastname => "Lastname",
        :number => "Number",
        :facility => "Facility",
        :ward => "Ward",
        :updated_by => "Updated By"
      ),
      stub_model(Patient,
        :firstname => "Firstname",
        :lastname => "Lastname",
        :number => "Number",
        :facility => "Facility",
        :ward => "Ward",
        :updated_by => "Updated By"
      )
    ])
  end

  it "renders a list of patients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => "Facility".to_s, :count => 2
    assert_select "tr>td", :text => "Ward".to_s, :count => 2
    assert_select "tr>td", :text => "Updated By".to_s, :count => 2
  end
end
