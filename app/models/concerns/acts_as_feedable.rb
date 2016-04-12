
#encoding: utf-8
module ActsAsFeedable
  extend ActiveSupport::Concern

  included do

    include PublicActivity::Common

    # tracked owner: Proc.new{ |controller, model| controller.current_user }, only: [:create, :update]
    stampable

    after_create :create_feed_activity
    before_destroy :destroy_activities

    def activity
      any_activity = nil

      if activities.count > 0 and a = activities.where(key: "#{self.class.name.underscore}.create").first
        any_activity = a
      end

      any_activity
    end

    def is_showable?
      activity_date.present?
    end

    def activity_recipient_type
      "User"
    end

    def activity_recipient_id

    end

    def activity_date
      if self.class.respond_to? :activity_date
        self.send(self.class.activity_date)
      else
        self.created_at
      end
    end

    def is_destroyable?
      if self.class.respond_to? :activity_destroyable?
        self.class.activity_destroyable?
      end
    end

    def create_feed_activity
     activity = self.create_activity key: "#{self.class.to_s.underscore}.create", owner: creator#, recipient: activity_recipient

     activity.recipient_type = activity_recipient_type
     activity.recipient_id = activity_recipient_id
     activity.save!
   end

   def destroy_activities
     activities.destroy_all
   end

  end
end
