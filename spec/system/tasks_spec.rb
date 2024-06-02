require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  # ユーザーがタスクの状態を切り替える
  scenario "user toggles a task", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,name: "RSpec tutorial",owner: user)
    task = project.tasks.create!(name: "Finish RSpec tutorial")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "RSpec tutorial"
    check "Finish RSpec tutorial"

    expect(page).to have_css "label#task_#{task.id}.completed"
    expect(task.reload).to be_completed

    uncheck "Finish RSpec tutorial"
    expect(page).to_not have_css "label#task_#{task.id}.completed"
    expect(task.reload).to_not be_completed
  end

  #タスクを追加する
  scenario "add task", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,name: "RSpec tutorial",owner: user)

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "RSpec tutorial"

    click_link "Add Task"
    fill_in "Name", with: "ゴミ出し"
    click_button "Create Task"

    expect(page).to have_content "Task was successfully created."
    expect(page).to have_content "ゴミ出し"
  end
  #タスクを編集
  scenario "edit task", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,name: "RSpec tutorial",owner: user)
    task = project.tasks.create!(name: "Finish RSpec tutorial")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "RSpec tutorial"

    all('.bi.bi-pencil-fill')[1].click
    fill_in "Name", with: "ゴミ出し"
    click_button "Update Task"
    expect(page).to have_content "Task was successfully updated."
    expect(page).to have_content "ゴミ出し"
  end


  #タスクを削除
  scenario "delete task", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,name: "RSpec tutorial",owner: user)
    task = project.tasks.create!(name: "Finish RSpec tutorial")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "RSpec tutorial"

    click_link "Delete"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "Task was successfully destroyed."
    expect(page).to_not have_content "Finish RSpec tutorial"
  end
end
