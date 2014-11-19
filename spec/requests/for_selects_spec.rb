require 'spec_helper'

describe "ForSelects" do
  describe "GET /for_selects" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get for_selects_path
      response.status.should be(200)
    end
  end
end
