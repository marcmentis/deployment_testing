require 'spec_helper'

describe "patients/new" do
  before(:each) do
    assign(:patient, stub_model(Patient,
      :firstname => "MyString",
      :lastname => "MyString",
      :number => "MyString",
      :facility => "MyString",
      :ward => "MyString",
      :updated_by => "MyString"
    ).as_new_record)
  end

  it "renders new patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", patients_path, "post" do
      assert_select "input#patient_firstname[name=?]", "patient[firstname]"
      assert_select "input#patient_lastname[name=?]", "patient[lastname]"
      assert_select "input#patient_number[name=?]", "patient[number]"
      assert_select "input#patient_facility[name=?]", "patient[facility]"
      assert_select "input#patient_ward[name=?]", "patient[ward]"
      assert_select "input#patient_updated_by[name=?]", "patient[updated_by]"
    end
  end
end
