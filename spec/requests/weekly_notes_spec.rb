require 'spec_helper'

describe "WeeklyNotes" do
  describe "GET /weekly_notes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get weekly_notes_path
      response.status.should be(200)
    end
  end
end
