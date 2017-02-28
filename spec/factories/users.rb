# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    factory :david do
      first_name "David"
      last_name "Fabreguette"
      email "david@appliserv.fr"
      password "qsdfqsdf"
      confirmed_at Date.yesterday.to_time
    end

    initialize_with { User.find_or_create_by(email: email)}

  end
end
