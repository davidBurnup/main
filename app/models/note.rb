class Note < ApplicationRecord

  belongs_to :song

  validates :note, :line, :offset, :song, :presence => true


  def transpose_to(new_note)
    # Calculate index difference between old and new note ...
    transposed_note = song.transpose_to(self.note, new_note)
    transposed_note
  end

  def transpose_and_capose(prefered_key, prefered_capo)

    transposed_note = transpose_to(prefered_key)

    transposed_and_caposed_note = song.capose(transposed_note, prefered_capo)

    transposed_and_caposed_note

  end

end
