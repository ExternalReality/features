require 'spec_helper'

RSpec.describe "The sign on process", :type => :feature do
  it "Feature requester can log into the application" do
    Given 'I am on the login page' do
      visit('/')
    end

    When 'I fill in valid credentials' do
      fill_in 'login', :with => 'default'
      fill_in 'password', :with => 'default'
      click_button 'Sign in'
    end

    Then 'I should be redirected to the tickets index page' do
      expect(current_path).to eq '/tickets/index'
    end
  end
end
