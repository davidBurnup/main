class Like < Socialization::ActiveRecordStores::Like

  def like!(liker, likeable)
    unless likes?(liker, likeable)
      self.create! do |like|
        like.liker = liker
        like.likeable_type = likeable.class.table_name.classify
        like.likeable_id = likeable.id
      end
      call_after_create_hooks(liker, likeable)
      true
    else
      false
    end
  end

end
