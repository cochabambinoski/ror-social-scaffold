require 'rails_helper'

RSpec.feature 'Create new User', type: :feature do
  scenario 'Sign up 2 new Users and create friendship between them' do
    visit '/users/sign_up'

    fill_in 'user_name', with: 'Benito'
    fill_in 'user_email', with: 'benito@dunno.com'
    fill_in 'user_password', with: 'foobar'
    fill_in 'user_password_confirmation', with: 'foobar'
    click_button 'commit'
    expect(page).to have_text('Welcome! You have signed up successfully.')

    click_on 'Sign out'
    expect(page).to have_text('You need to sign in or sign up before continuing.')

    visit '/users/sign_up'

    fill_in 'user_name', with: 'Bobito'
    fill_in 'user_email', with: 'bobito@dunno.com'
    fill_in 'user_password', with: 'foobar2'
    fill_in 'user_password_confirmation', with: 'foobar2'
    click_button 'commit'
    expect(page).to have_text('Welcome! You have signed up successfully.')
    user_id = User.find_by(email: 'benito@dunno.com').id
    click_on 'All users'
    expect(page).to have_text('Request friendship with')
    click_on "user-#{user_id}"
  end
end
