FactoryBot.define do
  factory :task do
    name { "Task name" }
    association :project
  end
end
