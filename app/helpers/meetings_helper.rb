module MeetingsHelper

	def duration_in_words(meeting)
		"#{meeting.duration_in_hours} heure#{meeting.duration_in_hours > 1 ? "s" : ""}"
	end

end
