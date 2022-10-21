module ApplicationHelper
	def format_time(seconds)
		Time.at(seconds).utc.strftime("%H:%M:%S")
	end

	def format_date_time(seconds)
		Time.at(seconds).utc.strftime("%D %r")
	end
end