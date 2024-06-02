require 'rails_helper'

RSpec.describe "Projects", type: :system do

  # ユーザーは新しいプロジェクトを作成する
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
      visit root_path
      click_link "Sign in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"

    expect {
            click_link "New Project"
            fill_in "Name", with: "Test Project"
            fill_in "Description", with: "Trying out Capybara"
            click_button "Create Project"

            expect(page).to have_content "Project was successfully created"
            expect(page).to have_content "Test Project"
            expect(page).to have_content "Owner: #{user.name}"
            }.to change(user.projects, :count).by(1)
  end

  # ユーザーはプロジェクトを編集する
  scenario "user edit project" do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, name: 'edit project', owner: user)
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "edit project"
    click_link "Edit"
    fill_in "Name", with: "edited project"
    click_button "Update Project"
    expect(page).to have_content "Project was successfully updated."
    expect(page).to have_content "edited project"
  end

  # プロジェクトの編集が失敗する
  scenario "user edit project" do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, name: 'edit project', owner: user)
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "edit project"
    click_link "Edit"
    fill_in "Name", with: ""
    click_button "Update Project"
    expect(page).to have_content "Name can't be blank"
  end

end
