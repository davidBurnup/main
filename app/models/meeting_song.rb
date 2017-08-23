# encoding: utf-8
class MeetingSong < ApplicationRecord

  belongs_to :song
  belongs_to :leader, :class_name => "User", :foreign_key => :leader_id

  before_save :set_key

  def set_key
    if self.song and self.leader
      self.key = self.song.prefered_key(self.leader)
    end
  end
end
