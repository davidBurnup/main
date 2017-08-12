# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do

    title "Super Comment"
    comment "My comment .... rock on !"
    association :creator, factory: :david
    initialize_with { Comment.find_or_create_by(title: title)}

    before(:create) do |comment|
      comment.commentable = create(:post).activity
    end
  end
end
