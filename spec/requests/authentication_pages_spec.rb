require 'spec_helper'

describe "Authentication" do
  include Capybara::RSpecMatchers
    describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
end 
end