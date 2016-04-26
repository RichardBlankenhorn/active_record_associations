require 'rails_helper'

feature 'Editing Cars' do
  let(:user) { FactoryGirl.create(:user) }
  scenario 'can edit a car' do
    signin_as(user)

    visit '/'

    click_link 'New Car'

    fill_in 'Make', with: 'Ford'
    fill_in 'Model', with: 'Mustang'
    fill_in 'Year', with: '1969'
    fill_in 'Price', with: '2300'

    click_button 'Create Car'

    expect(page).to have_content("1969 Ford Mustang created")
    expect(page).to have_content("$2,300.00")

    click_link 'Edit'

    fill_in 'Price', with: '46000'

    click_button 'Update Car'

    expect(page).to have_content("1969 Ford Mustang updated")
    expect(page).to have_content("$46,000.00")
  end

  scenario 'is not allowed for non-logged in users' do
    car = FactoryGirl.create(:car)

    visit edit_car_path(car)

    expect(page).to have_text('Access not allowed')
    expect(page.current_path).to eq(root_path)
  end
end
