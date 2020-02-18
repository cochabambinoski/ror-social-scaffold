require 'rails_helper'

RSpec.feature 'Create new User', type: :feature do
  scenario 'Sign up 2 new Users and create friendship between them' do
    visit '/users/sign_up'

    fill_in 'user_email', with: 'benito@dunno.com'
    fill_in 'user_password', with: 'foobar'
    fill_in 'user_password_confirmation', with: 'foobar'
    click_button 'commit'
    expect(page).to have_text('benito@dunno.com')

    click_on 'Sign out'
    expect(page).to have_text('Sign in')

    visit '/users/sign_up'

    fill_in 'user_email', with: 'bobito@dunno.com'
    fill_in 'user_password', with: 'foobar2'
    fill_in 'user_password_confirmation', with: 'foobar2'
    click_button 'commit'
    expect(page).to have_text('bobito@dunno.com')
    user_id = User.find_by(email: 'benito@dunno.com').id
    click_on 'Users'
    expect(page).to have_text('Request friendship with')
    click_on "user-#{user_id}"
    expect(page).to have_text('1 Pending friends ')
  end
end
