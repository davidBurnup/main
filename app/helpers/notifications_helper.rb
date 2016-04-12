module NotificationsHelper

  def build_notification_header(notification)
    header_label = ""

    if notification and notification.notifiable_type
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
end