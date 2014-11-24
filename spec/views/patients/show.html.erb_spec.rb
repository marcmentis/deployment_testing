require 'spec_helper'

describe "patients/show" do
  before(:each) do
    @patient = assign(:patient, stub_model(Patient,
      :firstname => "Firstname",
      :lastname => "Lastname",
      :number => "Number",
      :facility => "Facility",
      :ward => "Ward",
      :updated_by => "Updated By"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Firstname/)
    rendered.should match(/Lastname/)
    rendered.should match(/Number/)
    rendered.should match(/Facility/)
    rendered.should match(/Ward/)
    rendered.should match(/Updated By/)
  end
end
