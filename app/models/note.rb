class Note < ActiveRecord::Base

  belongs_to :song

  validates :note, :line, :offset, :song, :presence => true


  def transpose_to(new_note)

    # Calculate index difference between old and new note ...
    transposed_note = Song.transpose(self.note, 3)
    transposed_note
  end
end
