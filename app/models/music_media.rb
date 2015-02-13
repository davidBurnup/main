class MusicMedia < Media

  has_attached_file :attachment
  # validates_attachment_content_type :attachment, :content_type => { :content_type => ["audio/mp3", "audio/mpeg"] }
  validates_attachment :attachment,
                      :presence => true,
                      :content_type => {
                        :content_type => ["audio/mp3", "audio/mpeg"]
                      },
                      :size => { :in => 0..30000.kilobytes }

end
