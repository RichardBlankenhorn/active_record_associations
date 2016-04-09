require 'rails_helper'

feature 'Creating Users' do
  scenario 'allow a logged in user to claim a car' do
    @user = FactoryGirl.create(:user)
    @car1 = FactoryGirl.create(:car)
    @car2 = FactoryGirl.create(:car)

    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Login'

    within("#car_#{@car1.id}") do
      click_link 'Claim'
    end

    expect(page).to have_text("#{@car1.make} #{@car1.model} has been moved to your inventory.")
    expect(page).to_not have_selector("#car_#{@car1.id}")
    expect(page).to have_selector("#car_#{@car2.id}")

    expect(page).to have_link('My Cars')
    click_link 'My Cars'

    expect(page).to have_selector("#car_#{@car1.id}")
    expect(page).to_not have_selector("#car_#{@car2.id}")
  end
end

