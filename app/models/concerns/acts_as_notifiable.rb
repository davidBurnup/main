#encoding: utf-8
module ActsAsNotifiable
  extend ActiveSupport::Concern

  included do

    has_many :notifications, as: :notifiable, dependent: :destroy

    def notify_user!(user)
      if existing_notification(user).blank? and user
        notification = Notification.create({
          notifiable_type: self.class.to_s,
          notifiable_id: self.id,
          notifier: self.notifier,
          notified_id: user.id
        })

      elsif n = existing_notification(user)
        n.update({
          updated_at: Time.now,
          is_seen: false
        })
        # TODO :
        # Gather notifications for the same entity in one notification, for example " Marcus and Michel both commented on your Suivi "
      end
    end

    def notify!
      if (usrs_to_notify = self.notifiable_option(:notifieds)).present? and (notifier = self.notifiable_option(:notifier)).present?
        usrs_to_notify.each do |u|
          if (u != notifier or notifiable_option(:enable_self_notification))
            notify_user!(u)
          end
        end
      end
    end

    def existing_notification(user)
      Notification.where(:notifiable_type => self.class.name, :notifiable_id => self.id, :notified_id => user.id, notifier_id: self.notifier.id).first
    end

    def notification_label_params
      p = {}
      if label_params_lambda = notifiable_option(:label_params)
        p = label_params_lambda
      end
      p
    end

    def notification_icon
      notifiable_option(:icon)
    end

    def notification_locale_key
      notifiable_option(:locale_key)
    end

    def notifieds
      usrs_to_notify = self.notifiable_option(:notifieds)
    end

    def notifier
      self.notifiable_option(:notifier)
    end

    def notifiable_option(key)
      notifiable_option_key = self.class.notifiable_options[key.to_sym]
      if notifiable_option_key
        if notifiable_option_key.is_a? Proc
          option = notifiable_option_key.(self)
        else
          # Check for static options (like icon)
          if self.class.static_options.include?(key.to_sym)
            option = notifiable_option_key
          else
            option = send(notifiable_option_key)
          end
        end
      end
      option
    end

    def notifiable_content
      notifiable_option(:content)
    end

    def notifier
      notifiable_option(:notifier)
    end

    def destroy_notifications
      notifications.destroy_all
    end

  end

  module ClassMethods

    @@default_notifiable_options = {
      content: nil,
      notifier: nil,
      notifieds: nil,
      icon: 'bolt',
      locale_key: nil,
      trigger: nil, # Defines if notify! method should be triggered on callbacks
      enable_self_notification: false # Allows user to notify himself about a task
    }

    # Defines options that will not be sent to instance using ruby send method but used as static variable
    @@static_options = [:icon, :locale_key]

    @@required_options = [:notifier, :notifieds]

    def notifiable(options = {})

      # create a reader on the class to access the options from the notifiable instance
      class << self; attr_reader :notifiable_options; end

      if missing_options = (@@required_options - options.keys) and missing_options.present?
        raise "Missing Options #{missing_options} ! Please define those options to use this concern !"
      end

      @notifiable_options = @@default_notifiable_options.merge options

      if @notifiable_options[:trigger]
        send(@notifiable_options[:trigger], :notify!)
      end
    end

    def static_options
      @@static_options
    end
  end
end
