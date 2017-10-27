require 'streamio-ffmpeg'
module Paperclip
  class StreamioTranscoder < Processor
    def initialize file, options = {}, attachment = nil
      super
      @file = file
      @format = options[:format] || 'mp4'
      @basename = File.basename(@file.path, 'mp4')
      @params = options[:params]
      @attachment = attachment
    end

    def make
      basename = File.basename(@file.path, File.extname(@file.path))
      dst_format = options[:format] ? ".\#{options[:format]}" : 'mp4'

      # dst = Tempfile.new([basename, dst_format])
      # dst.binmode
      #
      # convert(':src -type Grayscale :dst',
      #         src: File.expand_path(file.path),
      #         dst: File.expand_path(dst.path))
      #
      # puts ")))))) - #{@file.path}"
      movie = FFMPEG::Movie.new(@file.path)
      # raise file.inspect
      movie.transcode("tmp/#{basename}.mp4") { |progress|
        if @attachment and i = @attachment.instance
          puts progress
          # @attachment.instance.update(transcoding_progress: progress)
          redis = Redis.new
          puts "#{i.id}-video-progress"
          redis.set("#{i.id}-video-progress", "#{progress}")
          ActionCable.server.broadcast "video-progress-#{i.id}", "#{progress}"
        end
      }
      dst = File.open("tmp/#{basename}.mp4")
      # file.binmode
      # puts "saving to #{file.path}"
      unless File.exist?("tmp/#{basename}.mp4")
        raise "noooooooo"
      end
      @file = dst
      dst
    end
  end
end
