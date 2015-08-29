class Song < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, only: :create

  after_save :parse_notes
  before_save :set_creator

  has_many :notes
  has_many :posts
  has_many :user_song_preferences
  belongs_to :origin_church, :class_name => "Church", :foreign_key => "origin_church_id"
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"


  validates :key, :title, :content, :presence => true

  def Song.match_note
    match_note = /\[([A-Za-z].*?)\]/
  end

  def set_creator
    self.creator ||= User.current
    if u = User.current and u.church.present?
      self.origin_church ||= u.church
    end
  end

  def user_song_preference(user)
    if user
      any_song_preference = self.user_song_preferences.where(:user_id => user.id).first

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

  def prefered_capo(user)
    prefered_capo = 0
    usp = user_song_preference(user)
    if usp and usp.prefered_capo
      prefered_capo = usp.prefered_capo
    end

    prefered_capo
  end

  def parse_notes

    unless @disable_callback
      theContent = self.content

      rows = theContent.split("\n")
      rows = rows.map{|line| line.gsub(/\r\n|\r|\n/, '')}.reject{|line| line.blank?}.compact

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
      Song.public_activity_off
      self.update_attribute('clean_content', self.content.gsub(Song.match_note,''))
      Song.public_activity_on
      @disable_callback = false
    end
  end

  def onsong_clean_content(usp=nil)
    onsong_content = "{t:#{self.title}}\n"
    onsong_content += "{a:#{self.author} | extrait de burnup.fr}\n"
    if usp
      onsong_content += "{k:#{usp.prefered_key}}\n"
      onsong_content += "{capo:#{usp.prefered_capo}}\n"
    else
      onsong_content += "{k:#{self.key}}\n"
    end
    onsong_content += "{tempo:#{self.bpm}}\n"
    onsong_content += content
    #onsong_content = onsong_content.gsub(/^(\s)*\n/,'')
    onsong_content = onsong_content.gsub(" ","&nbsp;")
    onsong_content = onsong_content.gsub(/(Couplet&nbsp;[1-9]:)/,'{c:\1}')
    onsong_content = onsong_content.gsub(/(Refrain:)/,'{c:\1}')
    onsong_content = onsong_content.gsub(/(Pre-refrain:)/,'{c:\1}')
    onsong_content = onsong_content.gsub(/(Pre-Refrain:)/,'{c:\1}')
    onsong_content = onsong_content.gsub(/(Choeur:)/,'{c:\1}')
    onsong_content = onsong_content.gsub(/(Pont:)/,'{c:\1}')
    #onsong_content = onsong_content.gsub(/^(\s)*\n/,'<span class="section-padder">&nbsp;</span><br/>')

    # # Remove empty lines
    # onsong_content = onsong_content.split("\n")
    # onsong_content = onsong_content.map{|line| line.gsub(/\r\n|\r|\n/, '')}.reject{|line| line.blank?}.compact
    #
    # onsong_content = onsong_content.map{|line| "<div class=\'song-line\'>#{line}</div>"}.join("")
    # # onsong_content = onsong_content.gsub("\n","<br/><br/>")
    #
    # onsong_content = onsong_content.gsub(Song.match_note,'<span class="content-note" data-note="\1">&nbsp;</span>')
    onsong_content
  end

  def clean_html_content
    html_content = content
    #html_content = html_content.gsub(/^(\s)*\n/,'')
    html_content = html_content.gsub(" ","&nbsp;")
    html_content = html_content.gsub(/(Couplet&nbsp;[1-9]:)/,'<span class="song-section-title">\1</span>')
    html_content = html_content.gsub(/(Refrain:)/,'<span class="song-section-title">\1</span>')
    html_content = html_content.gsub(/(Pre-refrain:)/,'<span class="song-section-title">\1</span>')
    html_content = html_content.gsub(/(Pre-Refrain:)/,'<span class="song-section-title">\1</span>')
    html_content = html_content.gsub(/(Choeur:)/,'<span class="song-section-title">\1</span>')
    html_content = html_content.gsub(/(Pont:)/,'<span class="song-section-title">\1</span>')
    #html_content = html_content.gsub(/^(\s)*\n/,'<span class="section-padder">&nbsp;</span><br/>')

    # Remove empty lines
    html_content = html_content.split("\n")
    html_content = html_content.map{|line| line.gsub(/\r\n|\r|\n/, '')}.reject{|line| line.blank?}.compact

    html_content = html_content.map{|line| "<div class=\'song-line\'>#{line}</div>"}.join("")
    # html_content = html_content.gsub("\n","<br/><br/>")

    html_content = html_content.gsub(Song.match_note,'<span class="content-note" data-note="\1">&nbsp;</span>')
    html_content
  end

  def self.notes
    [
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
        ["C#", "Db"],
        ["C"]
    ].reverse
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

  def available_keys
    first_key = self.key.present? ? self.key : "C"
    available_keys = [first_key]
    initial_key_index = Song.reverse_chord_index(first_key)
    key_index = initial_key_index + 1

    while key_index != initial_key_index
      key_value = Song.chord_value(key_index,first_key, {:reverse => true})
      available_keys << key_value

      if key_index < (Song.chords.size - 1)
        key_index += 1
      else
        key_index = 0
      end
    end

    available_keys
  end


  def self.chord_index(chord)
    chord_index = 0

    chords.each_with_index do |c, i|
      chord_index = i
      break if c.include? chord
    end

    chord_index
  end
  def self.reverse_chord_index(chord)
    chord_index = 0

    self.notes.each_with_index do |c, i|
      chord_index = i
      break if c.include? chord
    end

    chord_index
  end

  def self.chord_value(chord_index, key, options = {})
    chord_value = ""
    pitch = Song.pitch(key)

    chords = Song.chords

    if options[:reverse].present? and options[:reverse]
      chords = notes
    end

    if chords[chord_index]
      chord_value = chords[chord_index][0]
      if chord_value.size > 1 && pitch == "flat"
        chord_value = chords[chord_index][1]
      end
    end

    chord_value
  end

  def self.note_offsets(from_note, to_note)
    offset = 0

    from_note_index = Song.reverse_chord_index(from_note)

    to_note_index = Song.reverse_chord_index(to_note)

    # Direct distance
    direct_offset = to_note_index - from_note_index

    # Indirect distance
    top_offset = Song.chords.size - to_note_index
    bottom_offset = from_note_index

    indirect_offset = top_offset + bottom_offset

    offset = direct_offset

    if indirect_offset < direct_offset
      #offset = indirect_offset
    end

    offset
  end

  def transpose_to(chord, aimed_chord)

    offset = Song.note_offsets(self.key, aimed_chord)
    transpose(chord, offset)

  end

  def capose(chord, offset)

    base_chord, extra_chord = Song.clean(chord)


    final_chord = nil

    # Find current chord index
    chord_index = Song.chord_index(base_chord)
    current_key_index = Song.chord_index(self.key)

    if offset == 0
      return chord
    elsif offset > 0
      chord_index += 1
      current_key_index += 1
    else
      chord_index -= 1
      current_key_index -= 1
    end


    initial_index = chord_index
    full_index = initial_index

    while (full_index != (initial_index + offset)) do

      new_key = Song.chord_value(current_key_index, self.key)
      if final_chord = Song.chord_value(chord_index, new_key) and final_chord.present?
      else
        if chord_index > (Song.chords.size - 1)
          chord_index -= Song.chords.size
        else
          chord_index -= Song.chords.size
        end
        final_chord = Song.chord_value(chord_index, new_key)
      end

      if offset > 0
        chord_index += 1
        full_index += 1
        current_key_index += 1

      else
        chord_index -= 1
        full_index -= 1
        current_key_index -= 1
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

  def transpose(chord, offset)
    capose(chord, offset * -1)
  end


  # RIGHTS

  def can_be_updated_by?(user)

  end
end
