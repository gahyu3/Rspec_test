FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { "Aaron" }
    last_name { "Sumner" }
    sequence(:email) { |n| "tester#{n}@example.com" } 
    password { "dottle-nouveau-pavilion-tights-furze" }

    trait :with_projects do
      after(:create) { |user| create_list(:project, 5, owner: user) }
    end

    trait :other_user do
      first_name { "Joe" }
      last_name { "Aester" }  
    end

    trait :first_name_nil do
      first_name { "" }
    end

    trait :last_name_nil do
      last_name { "" }
    end

    trait :email_nil do
      email { "" }
    end

    trait :email_one do
      email { "test@example.com" }
    end

    trait :full_name do
      first_name { "John" }
      last_name { "Doe" }
    end

  end
end
