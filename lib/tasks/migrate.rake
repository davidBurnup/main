namespace :migrate do
  task :set_old_activities_recipients => :environment do

    # Migrate song activities
    song_linked_post_ids = Post.select("id").where('posts.song_id IS NOT NULL').collect(&:id)
    song_linked_activities = PublicActivity::Activity.where('activities.trackable_type = "Post" AND activities.trackable_id IN (?)', song_linked_post_ids)

    if song_linked_activities.present?
      song_linked_activities.each do |activity|
        activity.update({
          recipient_type: 'Song',
          recipient_id: activity.trackable.song_id
          })
      end
    end

    unrecipiented_activities = PublicActivity::Activity.where('activities.recipient_type IS NULL AND activities.recipient_id IS NULL')

    if unrecipiented_activities.present?
      unrecipiented_activities.each do |activity|
        activity.update({
          recipient_type: 'Church',
          recipient_id: activity.owner.church_id
          })
      end
    end

    PublicActivity::Activity.where('activities.recipient_type = "User"').each do |activity|
      activity.update({
        recipient_type: 'Church',
        recipient_id: activity.owner.church_id
        })
    end
  end
end
