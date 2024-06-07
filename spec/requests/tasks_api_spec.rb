require 'rails_helper'

RSpec.describe "Tasks Api", type: :request do
  let(:user) { FactoryBot.create(:user, email: "unique_email@example.com" ) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:task) { FactoryBot.create(:task, project: project) }

  before do
    sign_in user
  end

  #タスクが作成できること
  describe "POST #create" do
    it "creates  task" do
      task_params = FactoryBot.attributes_for(:task)
      expect {
        post api_project_tasks_path(project.id), params: {
          project_id: project.id,
          task: task_params }
      }.to change(Task, :count).by(1)
      expect(response).to have_http_status(:success)
    end
  end

end
