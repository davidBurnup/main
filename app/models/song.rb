class Song < ActiveRecord::Base

  after_save :parse_notes


  has_many :notes
  has_many :user_song_preferences


  def Song.match_note
    match_note = /\[([A-Za-z].*?)\]/
  end

  def user_song_preference(user)
    if user
      any_song_preference = self.user_song_preferences.where(:user => user).first

      unless any_song_preference
        any_song_preference = UserSongPreference.create({
            :user_id => user.id,
            :prefered_key => self.key,
            :song_id => self.id
                                                        })
      end

      any_song_preference
    end
  end

  def prefered_key(user)
    prefered_key = key
    usp = user_song_preference(user)
    if usp
      prefered_key = usp.prefered_key
    end

    prefered_key
  end

  def parse_notes

    unless @disable_callback
      rows = self.content.split(/\r?\n/)



      notes = []


      rows.each_with_index do |row, row_index|

        notes[row_index] = {}

        previous_to_remove_caracters_length = 0

        row.scan(Song.match_note) do
          if $1

            positions = $~.offset(1)[0] - previous_to_remove_caracters_length
            notes[row_index][positions] = $1
            previous_to_remove_caracters_length += $1.size + 2
          end
        end
      end


      # Destroy previous notes
      self.notes.destroy_all

      notes.each_with_index do |row_notes, row_index|
        row_notes.each do |note_offset, note|
          Note.create({
                          :song_id => self.id,
                          :note => note,
                          :offset => note_offset,
                          :line => (row_index + 1)
                      })
        end
      end

      @disable_callback = true
      self.update_attribute('clean_content', self.content.gsub(Song.match_note,''))
      @disable_callback = false
    end
  end

  def clean_html_content
    html_content = content.gsub("\n","<br/><br/>")

    html_content = html_content.gsub(Song.match_note,'<span class="content-note" data-note="\1">&nbsp;</span>')
    html_content
  end

  def self.notes
    [
        "C",
        "C#",
        "Db",
        "D",
        "D#",
        "Eb",
        "E",
        "F",
        "F#",
        "Gb",
        "G",
        "G#",
        "Ab",
        "A",
        "A#",
        "Bb",
        "B"
    #"Cb" # N'existe pas !!
    ]
  end

  def self.base_notes
    ["A", "B", "C", "D", "E", "F", "G"]
  end

  def self.chords
    [
        ["C"],
        ["B"],
        ["A#", "Bb"],
        ["A"],
        ["G#", "Ab"],
        ["G"],
        ["F#", "Gb"],
        ["F"],
        ["E"],
        ["D#", "Eb"],
        ["D"],
        ["C#", "Db"]
    ]
  end

  def self.sharp_notes
    self.base_notes - ["E", "B"]
  end

  def self.flat_notes
    self.base_notes - ["C", "F"]
  end


  def self.chord_index(chord)
    chord_index = 0

    chords.each_with_index do |c, i|
      chord_index = i
      break if c.include? chord
    end

    chord_index
  end

  def self.chord_value(chord_index, key)
    chord_value = ""
    pitch = Song.pitch(key)

    if Song.chords[chord_index]
      chord_value = Song.chords[chord_index][0]
      if chord_value.size > 1 && pitch == "flat"
        chord_value = Song.chords[chord_index][1]
      end
    end

    chord_value
  end

  def capose(chord, offset)

    base_chord, extra_chord = Song.clean(chord)

    new_key = Song.transpose(self.key, offset)

    final_chord = nil

    # Find current chord index
    chord_index = Song.chord_index(base_chord)

    if offset == 0
      return Song.chords[chord_index]
    elsif offset > 0
      chord_index += 1
    else
      chord_index -= 1
    end

    initial_index = chord_index
    full_index = initial_index

    while (full_index != (initial_index + offset)) do
      if final_chord = Song.chord_value(chord_index, new_key) and final_chord.present?
      else
        if chord_index > (self.chords.size - 1)
          chord_index -= self.chords.size
        else
          chord_index -= self.chords.size
        end
        final_chord = Song.chord_value(chord_index, new_key)
      end

      if offset > 0
        chord_index += 1
        full_index += 1

      else
        chord_index -= 1
        full_index -= 1
      end
    end

    final_chord += extra_chord

    final_chord
  end

  def self.clean(note)
    pitch = Song.pitch(note)

    base_note = note[0]

    if pitch == "flat"
      base_note += "b"
    elsif pitch == "sharp"
      base_note += "#"
    end

    extra_note = note[1..note.size]

    # Remove extra sharp or flat
    extra_note = extra_note.gsub("b", "")
    extra_note = extra_note.gsub("#", "")

    [base_note, extra_note]
  end

  def self.pitch(note)

    base_note = note[0]

    is_flat = note[/b/].present? and (Song.flat_notes.include?(base_note))
    is_sharp = note[/#/].present? and (Song.sharp_notes.include?(base_note))

    if is_flat and !is_sharp
      pitch = "flat"
    elsif is_sharp and !is_flat
      pitch = "sharp"
    else
      pitch = ""
    end

    pitch
  end

  def self.transpose(note, offset)

    final_note = nil

    # Find current note index
    note_index = self.notes.index(note) || 0


    if offset == 0
      return self.notes[note_index]
    elsif offset > 0
      note_index += 1
    else
      note_index -= 1
    end

    initial_index = note_index
    full_index = initial_index

    while (full_index != (initial_index + offset)) do
      if self.notes[note_index]
        final_note = self.notes[note_index]
      else
        if note_index > (self.notes.size - 1)
          note_index = note_index - self.notes.size
        else
          note_index = note_index + self.notes.size
        end
        final_note = self.notes[note_index]
      end

      if offset > 0
        note_index += 1
        full_index += 1

      else
        note_index -= 1
        full_index -= 1
      end
    end

    final_note

  end
end
