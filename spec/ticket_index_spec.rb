require 'spec_helper'

RSpec.describe "Ticket index page", driver: :webkit do
  before(:each) do
    login_as_a_feature_requester
  end

  it "displays a button allow feature requester to create a new ticket" do
    Given "I am on the ticket index page" do
      expect(current_path).to eq '/tickets/index'
    end

    Then "I should see a 'New Ticket' button" do
      expect(page).to have_content('New Ticket')
    end
  end
end

def login_as_a_feature_requester
    visit('/')
    fill_in 'login', :with => 'default'
    fill_in 'password', :with => 'default'
    click_button 'Sign in'
end
