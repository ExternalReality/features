require 'spec_helper'

RSpec.describe "The sign on process", :type => :feature do
  context "when a user enters a valid login and password" do
    it "logs a user in" do
      visit('/')
      fill_in 'login', :with => 'default'
      fill_in 'password', :with => 'default'
    end
  end
end
