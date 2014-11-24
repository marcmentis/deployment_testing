require 'spec_helper'

describe "weekly_notes/edit" do
  before(:each) do
    @weekly_note = assign(:weekly_note, stub_model(WeeklyNote,
      :danger_yn => "MyString",
      :drugs_last_changed => "MyString",
      :drugs_not_why => "MyString",
      :drugs_change_why => "MyString",
      :patient_id => 1,
      :pre_date_yesno => "MyString",
      :pre_date_no_why => "MyString",
      :pre_date => "MyString"
    ))
  end

  it "renders the edit weekly_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", weekly_note_path(@weekly_note), "post" do
      assert_select "input#weekly_note_danger_yn[name=?]", "weekly_note[danger_yn]"
      assert_select "input#weekly_note_drugs_last_changed[name=?]", "weekly_note[drugs_last_changed]"
      assert_select "input#weekly_note_drugs_not_why[name=?]", "weekly_note[drugs_not_why]"
      assert_select "input#weekly_note_drugs_change_why[name=?]", "weekly_note[drugs_change_why]"
      assert_select "input#weekly_note_patient_id[name=?]", "weekly_note[patient_id]"
      assert_select "input#weekly_note_pre_date_yesno[name=?]", "weekly_note[pre_date_yesno]"
      assert_select "input#weekly_note_pre_date_no_why[name=?]", "weekly_note[pre_date_no_why]"
      assert_select "input#weekly_note_pre_date[name=?]", "weekly_note[pre_date]"
    end
  end
end
