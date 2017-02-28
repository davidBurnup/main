require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "#toggle_like!" do
    context "when likes a post activity" do
      let(:david) {
        create(:david)
      }

      let(:post) {
        create(:post)
      }
      it "should really like it !" do
        david.toggle_like!(post.activity)
        expect(david.likes?(post.activity)).to eq(true)
      end
    end
  end
end
