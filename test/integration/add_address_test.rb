require_relative '../test_helper'
class ActionDispatch::IntegrationTest
    include Capybara::DSL
     describe " Map " do
         it "allows users to add an addresses" , js: true, type: :feature do
             visit "https://group-meet-app.herokuapp.com/"
             find('#sidebar').click
             click_button ("Add Address")
             expect(find('#sidebar')).to have_content('Address 3', wait: 10)
         end

     end
end