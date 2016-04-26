require 'rails_helper'

feature 'Creating Cars' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:car) { FactoryGirl.create(:car) }

  context 'for a non-logged in user' do
    it 'should not show a destroy link' do
      visit root_path

      expect(page).to_not have_link('Destroy')
    end

    it 'should prevent destruction' do
      # Anthony, figure out how to delete a car manually
    end
  end
  context 'for a logged in user' do
    context 'for a non-admin user' do
      before do
        signin_as(user)
      end

      it 'should not show a destroy link' do
        visit root_path

        expect(page).to_not have_link('Destroy')
      end

      it 'should prevent destruction' do
        visit root_path

        expect{ page.driver.delete(car_path(car)) }.to_not change(Car, :count)

        # expect(page.current_path).to eq(root_path)
        # expect(page).to have_current_path(root_path)
        # expect(page).to have_text('Access not allowed')
      end
    end
    context 'for an admin user' do
      before do
        signin_as(admin)
      end

      it 'should show a destroy link' do
        visit root_path

        page.driver.delete(car_path(car))

        expect(page).to_not have_link('Destroy')
      end

      it 'should allow destruction' do
        visit root_path
        click_link 'Destroy'

        expect(page).to_not have_selector("#car_#{car.id}")
      end

    end
  end
end
