# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do

    content "<p>my super post</p>"
    association :user, factory: :david
    initialize_with { Post.find_or_create_by(content: content)}

  end
end
