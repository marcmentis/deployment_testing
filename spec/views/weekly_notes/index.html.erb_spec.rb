require 'spec_helper'

describe "weekly_notes/index" do
  before(:each) do
    assign(:weekly_notes, [
      stub_model(WeeklyNote,
        :danger_yn => "Danger Yn",
        :drugs_last_changed => "Drugs Last Changed",
        :drugs_not_why => "Drugs Not Why",
        :drugs_change_why => "Drugs Change Why",
        :patient_id => 1,
        :pre_date_yesno => "Pre Date Yesno",
        :pre_date_no_why => "Pre Date No Why",
        :pre_date => "Pre Date"
      ),
      stub_model(WeeklyNote,
        :danger_yn => "Danger Yn",
        :drugs_last_changed => "Drugs Last Changed",
        :drugs_not_why => "Drugs Not Why",
        :drugs_change_why => "Drugs Change Why",
        :patient_id => 1,
        :pre_date_yesno => "Pre Date Yesno",
        :pre_date_no_why => "Pre Date No Why",
        :pre_date => "Pre Date"
      )
    ])
  end

  it "renders a list of weekly_notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Danger Yn".to_s, :count => 2
    assert_select "tr>td", :text => "Drugs Last Changed".to_s, :count => 2
    assert_select "tr>td", :text => "Drugs Not Why".to_s, :count => 2
    assert_select "tr>td", :text => "Drugs Change Why".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Pre Date Yesno".to_s, :count => 2
    assert_select "tr>td", :text => "Pre Date No Why".to_s, :count => 2
    assert_select "tr>td", :text => "Pre Date".to_s, :count => 2
  end
end
