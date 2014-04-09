require 'spec_helper'

describe "visiting the site" do
  describe "a new user visits the hompage" do

    it "display logo" do
      visit root_path
      expect(current_path).to eq root_path
      expect( page.has_css?('img[alt="Comic Authority"]')).to be_true
    end

    it "has a signup link" do
      visit root_path
      click_link "Sign Up"
      expect(current_path).to eq new_user_path
      expect(page).to have_content "Sign Up"
    end

  end

  describe "creating a user" do

    describe "signing up with valid credentials" do

      it "takes us to the homepage, signed in & says thanks" do
        visit root_path
        click_link "Sign Up"
        fill_in('user_email', with: "john@john.com")
        fill_in('user_nick', with: "john")
        fill_in('user_password', with: "password")
        fill_in('user_password_confirmation', with: "password")
        click_button("Create User")
        expect(current_path).to eq root_path
        expect(page).to have_content "Thanks for signing up!"
        expect(page).to have_content "john"
      end

    end

    describe "signing up with invalid credentials" do

      it "says Invalid Credentials in user new form" do
        visit root_path
        click_link "Sign Up"
        click_button("Create User")
        expect(current_path).to eq users_path
        expect(page).to have_content "Invalid Credentials"
      end
    end

  end


end