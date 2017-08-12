class Media < ActiveRecord::Base

  self.table_name = "medias"

  def self.accepted_content_types(attachment_filter = nil)
    accepted_c_types = {
      audio:  ["audio/mp3","audio/wav"],
      image:  ["image/jpeg", "image/gif", "image/png", "image/svg+xml", "image/jpg"],
      pdf: ["application/pdf", "application/x-pdf"],
      word: ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"],
      excel: ["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.oasis.opendocument.spreadsheet"]
    }
    if attachment_filter
      accepted_c_types[attachment_filter]
    else
      accepted_c_types
    end
  end

  has_attached_file :image, {
    :styles => {
      :large =>  ["600x600>", [:jpeg,:png,:gif]],
      # :cover =>  ["345x130#", [:jpeg,:png,:gif]],
      :medium_uncropped => ["400x300>", [:jpeg,:png,:gif]],
      :medium => ["533x400#", [:jpeg,:png,:gif]],
      :thumb =>  ["200x200#", [:jpeg,:png,:gif]],
      :mini =>  ["120x65>", [:jpeg,:png,:gif]],
      :micro => "35x35#"
    },
    :convert_options => {
      :all => '-background white -flatten +matte'
    }
  }
  validates_attachment :image, content_type: {content_type: Media.accepted_content_types([:image])}, size: { in: 0..50.megabytes }

  has_attached_file :pdf, {
    processors: nil,
    default_url: "/images/pdf.svg"
  }
  validates_attachment :pdf, content_type: {content_type: Media.accepted_content_types([:pdf])}, size: { in: 0..50.megabytes }

  has_attached_file :word, {
    processors: nil,
    default_url: "/images/word.svg"
  }
  validates_attachment :word, content_type: {content_type: Media.accepted_content_types([:word])}, size: { in: 0..50.megabytes }

  has_attached_file :excel, {
    processors: nil,
    default_url: "/images/excel.svg"
  }
  validates_attachment :excel, content_type: {content_type: Media.accepted_content_types([:excel])}, size: { in: 0..50.megabytes }

  has_attached_file :audio, {
    processors: nil,
    default_url: "/images/audio.svg"
  }
  validates_attachment :audio, content_type: {content_type: Media.accepted_content_types([:audio])}, size: { in: 0..50.megabytes }

  belongs_to :post

  before_validation :unset_previous_attachment_if_needed, :check_for_attachment_presence

  def attachment_types
    Media.accepted_content_types.keys
  end

  def attachment_type
    present_attachment = attachment_types.map do |att_type|
      att = self.send(att_type)
      att_type if att.present?
    end
    present_attachment.compact.first
  end

  def attachment_file_name
    if t = attachment_type
      send("#{t}_file_name")
    end
  end

  def attachment
    if t = attachment_type
      self.send(t)
    end
  end

  def attachment_thumb
    att_thumb = nil
    if attachment_type == :image
      att_thumb = attachment.url(:mini)
    else
      att_thumb = "/images/#{attachment_type}.svg"
    end
  end

  def changed_attachments
    changed_att = []
    attachment_types.each do |att|
      if self.send("#{att}_file_name_changed?")
        changed_att << att
      end
    end
    changed_att
  end

  def has_multiple_attachments?
    attachments_count = 0
    attachment_types.each do |attachment|
      if self.send(attachment).present?
        attachments_count += 1
      end
      if attachments_count > 1
        break
      end
    end
    attachments_count > 1
  end

  def unset_previous_attachment_if_needed
    if has_multiple_attachments?
      # Unset all previous attachment
      changed_atts = changed_attachments
      attachment_types.each do |attachment|
        unless changed_atts.include? attachment
          self.send(attachment).destroy
        end
      end
    end
  end

  def check_for_attachment_presence
    unless attachment
      self.errors[:image] << "Ajoutez au moins une pièce jointe pour continuer !"
    end
  end


  def self.valid_content_type?(content_type)
    Media.accepted_content_types.values.flatten.include? content_type
  end

  def self.detect_attachment_type(content_type)
    detected_att_type = nil

    if Media.valid_content_type?(content_type)
      accepted_content_types.each do |att_type, content_types|
        if content_types.include? content_type
          detected_att_type = att_type
          break
        end
      end
    end

    detected_att_type
  end

  def self.reprocess_attachments
    Media.all.collect(&:reprocess_attachment)
  end

  def reprocess_attachment
    self.attachment.reprocess!
    self.save
  end

end
