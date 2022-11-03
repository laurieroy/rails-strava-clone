module ApplicationHelper
	include Pagy::Frontend
	
	def format_date(seconds)
		Time.at(seconds).utc.strftime("%D")
	end

	def format_clock_time(seconds)
		Time.at(seconds).utc.strftime("%I:%M%p")
	end
	
	def format_time(seconds)
		Time.at(seconds).utc.strftime("%H:%M:%S")
	end

	def format_time_hm(seconds)
		Time.at(seconds).utc.strftime("%H:%M")
	end

	def format_date_time(seconds)
		Time.at(seconds).utc.strftime("%D %r")
	end
end