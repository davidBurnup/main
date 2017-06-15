
#encoding: utf-8
module ActsAsFeedable
  extend ActiveSupport::Concern

  included do

    include PublicActivity::Common
    attr_accessor :skip_activity_callbacks

    # tracked owner: Proc.new{ |controller, model| controller.current_user }, only: [:create, :update]

    after_create :create_burn_activity, :unless => :skip_activity_callbacks
    after_update :update_burn_activity, :unless => :skip_activity_callbacks
    before_destroy :destroy_activities

    # This allows the use of "before_feeded / after_feeded model callback"
    define_model_callbacks :feeded, only: [:before, :after]

    define_model_callbacks :unfeeded, only: [:before, :after]

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
      r = feedable_option(:recipient)
      r ? r.class.to_s : 'User'
    end

    def activity_recipient_id
      r = feedable_option(:recipient)
      r ? r.id : nil
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

    # def create_feed_activity
    #   activity = self.create_activity key: "#{self.class.to_s.underscore}.create", owner: creator#, recipient: activity_recipient
    #
    #   activity.recipient_type = activity_recipient_type
    #   activity.recipient_id = activity_recipient_id
    #   activity.save!
    # end

    def save_with_activity(recipient = nil, options = {})
      @skip_activity_callbacks = true
      if options[:with_raise]
        save!
      else
        save
      end
      a = update_burn_activity(recipient)
      @skip_activity_callbacks = false
      a
    end

    def save_with_activity!(recipient = nil)
      save_with_activity(recipient, with_raise: true)
    end

    def update_burn_activity(recipient = nil)
      if self.activity
        save_activity(self.activity, recipient)
      else
        create_burn_activity(recipient)
      end
    end

    def create_burn_activity(recipient = nil)
      unless self.new_record? and !self.activity
        activity = self.create_activity key: "#{self.class.to_s.underscore}.create", trackable: self
        save_activity(activity, recipient)
      end
    end

    def save_activity(activity, recipient = nil)

      if recipient
        activity.recipient_type = recipient.class.name
        activity.recipient_id = recipient.id
      else
        activity.recipient_type = activity_recipient_type
        activity.recipient_id = activity_recipient_id
      end

      run_callbacks(:feeded) do
        activity.save!
      end

      activity
   end

   def destroy_activities
     activities.destroy_all
   end

   def feedable_option(key)
     feedable_option_key = self.class.feedable_options[key.to_sym]
     if feedable_option_key
       if feedable_option_key.is_a? Proc
         option = feedable_option_key.(self)
       else
         # Check for static options (like icon)
         if self.class.feedable_static_options.include?(key.to_sym)
           option = feedable_option_key
         else
           option = send(feedable_option_key)
         end
       end
     end
     option
   end

  end

  module ClassMethods

    @@default_feedable_options = {
      title: nil,
      content: nil, # Defines the body of the activity
      image: nil,
      image_link: nil,
      activity_link: nil,
      recipient: nil
    }

    # Defines options that will not be sent to instance using ruby send method but used as static variable
    @@feedable_static_options = []

    @@feedable_required_options = [:title, :image]

    def feedable(options = {})

      # create a reader on the class to access the options from the feedable instance
      class << self; attr_reader :feedable_options; end

      if missing_options = (@@feedable_required_options - options.keys) and missing_options.present?
        raise "Missing Options #{missing_options} ! Please define those options to use this concern !"
      end

      @feedable_options = @@default_feedable_options.merge options

    end

    def feedable_static_options
      @@feedable_static_options
    end
  end
end
