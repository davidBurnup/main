module LikesHelper
  def likers_label(likable)
    label = ""


    is_liked = current_user.likes?(likable)
    likers = User.where(id: (likable.likers(User).collect(&:id) - [current_user.id]))

    if is_liked
      label = "Vous "
    end

    likers.each_with_index do |user, i|
      if user.full_name and user != current_user
        label += "#{is_liked ? 'et ' : ''}#{user.full_name} "
      end

      if i < (likers.count - 1) and i < 2
        label += ", "
      elsif i >= 2
        label += "et #{likers.count - 2} autres personnes "
      end
    end

    if likers.count > 0 or is_liked
      label += "brul#{is_liked ? 'ez' : (likers.count > 1 ? "ent" : "e")} pour ceci."
    else
      label += "Ça fait bruler mon coeur !"
    end

    label
  end
end
