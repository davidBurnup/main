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
          recipient_type: 'Page',
          recipient_id: activity.owner.page_id
          })
      end
    end

    PublicActivity::Activity.where('activities.recipient_type = "User"').each do |activity|
      activity.update({
        recipient_type: 'Page',
        recipient_id: activity.owner.page_id
        })
    end
  end


  task :set_all_song_to_acac => :environment do
    acac_page = Page.where(slug: "assemblee-chretienne-ales").first
    Song.all.each do |song|
      song.origin_page = acac_page
      song.save
    end
  end

  desc "Migrate old medias linked to post to mediatisable"
  # WE DO NOT SUPPORT DATA MIGRATION PREVIOUS TO V1
  task :old_medias_from_posts_to_mediatisable => :environment do
    Media.where.not(post_id: nil).each do |media|
      media.update_attributes(mediatisable_id: media.post_id, mediatisable_type: 'Post')
    end
  end

end
