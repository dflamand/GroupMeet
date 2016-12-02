require_relative '../test_helper'
class ActionDispatch::IntegrationTest
    include Capybara::DSL
    
     describe " Map " do
         it "allows guests to add an addresses" , js: true, type: :feature do
             visit "/"
             find('#sidebar').click
             click_button ("Add Address")
             expect(find('#sidebar')).to have_xpath("//div[3]/input")
         end
         
         it "shows mid point on map when 2 addresses entered and checked", js: true, type: :feature do
             visit"/"
             find('#sidebar').click
             fill_in 'Address 1', with: 'Burnaby, BC, Canada'
             fill_in 'Address 2', with: 'Vancouver, BC, Canada'
             click_button ("Submit")
         end
         
         it "doesn't show mid point when no or 1 address entered and checked", js: true, type: :feature do
             visit"/"
             find('#sidebar').click
             fill_in 'Address 1', with: 'Burnaby, BC, Canada'
             click_button ("Submit")
             expect(page).to have_no_content("Calculated")
             fill_in 'Address 2', with: 'Vancouver, BC, Canada'
             first("input[type='checkbox']").set(false)
             click_button ("Submit")
             expect(page).to have_no_content("Calculated")
             find(:xpath, "(//input[@type='checkbox'])[2]").set(false)
             click_button ("Submit")
             expect(page).to have_no_content("Calculated")
         end
         
         it "select location type", js: true, type: :feature do
             visit"/"
             find('#sidebar').click
             fill_in 'Address 1', with: 'Burnaby, BC, Canada'
             fill_in 'Address 2', with: 'Vancouver, BC, Canada'
             find('#locList').find(:xpath, 'option[2]').select_option
             click_button ("Submit")
             find('#locList').find(:xpath, 'option[3]').select_option
             click_button ("Submit")
             find('#locList').find(:xpath, 'option[4]').select_option
             click_button ("Submit")
         end
         
         it "select optional location type", js: true, type: :feature do
             visit"/"
             find('#sidebar').click
             fill_in 'Address 1', with: 'Burnaby, BC, Canada'
             fill_in 'Address 2', with: 'Vancouver, BC, Canada'
             find('#locList').find(:xpath, 'option[5]').select_option
             fill_in 'optionModalInput', with: 'Cinema'
             click_button ("Add Location")
             click_button ("Submit")
         end
     end
end