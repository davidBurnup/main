
#encoding: utf-8
module ActsAsFeedOwner
  extend ActiveSupport::Concern

  included do

    include PublicActivity::Common
    attr_accessor :skip_activity_callbacks

    # tracked owner: Proc.new{ |controller, model| controller.current_user }, only: [:create, :update]

    

   def feed_owner_option(key, options = {})
     feed_owner_option_key = self.class.feed_owner_options[key.to_sym]
     if feed_owner_option_key
       if feed_owner_option_key.is_a? Proc
         p = [self]
         if options[:extra_proc_params]
           p += options[:extra_proc_params]
         end
         option = feed_owner_option_key.(*p)
       else
         # Check for static options (like icon)
         if self.class.feed_owner_static_options.include?(key.to_sym)
           option = feed_owner_option_key
         else
           option = send(feed_owner_option_key)
         end
       end
     end
     option
   end

  end

  module ClassMethods

    @@default_feed_owner_options = {
      title: nil
    }

    # Defines options that will not be sent to instance using ruby send method but used as static variable
    @@feed_owner_static_options = []

    @@feed_owner_required_options = [:title]

    def feed_owner(options = {})

      # create a reader on the class to access the options from the feed_owner instance
      class << self; attr_reader :feed_owner_options; end

      if missing_options = (@@feed_owner_required_options - options.keys) and missing_options.present?
        raise "Missing Options #{missing_options} ! Please define those options to use this concern !"
      end

      @feed_owner_options = @@default_feed_owner_options.merge options

    end

    def feed_owner_static_options
      @@feed_owner_static_options
    end
  end
end
