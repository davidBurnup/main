module NotificationsHelper

  def build_notification_header(notification, any_current_user = nil)

    current_user ||= any_current_user
    header_label = ""

    if notification and notification.notifiable_type and current_user
      header_label += I18n.t("notification.verbs.#{notification.notifiable_type.underscore}.header", default: "vous notifie de :")

      if notification.notifiable and notification.notifiable.respond_to? :notifiable_through and nt = notification.notifiable.notifiable_through

        if nt.notification_editor == current_user
          header_label += " votre"
        else
          gender = I18n.t("activerecord.models.#{nt.class.name.underscore}.gender", :default => "M")
          if gender == "F"
            header_label += " cette"
          else
            header_label += " ce"
          end
        end
        header_label += " #{nt.class.model_name.human.downcase}"
      end
    end

    header_label
  end

  def build_notification_full_content(notification)
    c = ""

    if h = build_notification_header(notification, notification.notifier)
      c = h
      c += " #{notification.notifiable.notifiable_content}"
    end


    c
  end
end
