require 'spec_helper'

describe "weekly_notes/show" do
  before(:each) do
    @weekly_note = assign(:weekly_note, stub_model(WeeklyNote,
      :danger_yn => "Danger Yn",
      :drugs_last_changed => "Drugs Last Changed",
      :drugs_not_why => "Drugs Not Why",
      :drugs_change_why => "Drugs Change Why",
      :patient_id => 1,
      :pre_date_yesno => "Pre Date Yesno",
      :pre_date_no_why => "Pre Date No Why",
      :pre_date => "Pre Date"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Danger Yn/)
    rendered.should match(/Drugs Last Changed/)
    rendered.should match(/Drugs Not Why/)
    rendered.should match(/Drugs Change Why/)
    rendered.should match(/1/)
    rendered.should match(/Pre Date Yesno/)
    rendered.should match(/Pre Date No Why/)
    rendered.should match(/Pre Date/)
  end
end
