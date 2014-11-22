class User < ActiveRecord::Base

	# Define instance methods to check for roles
	def admin2?
		role == "admin2"
	end

	def admin1?
		role == "admin1"
	end

	def developer?
		role == "developer"
	end

	def staff?
		role == "staff"
	end

	def psych1?
		role == "psych1"
	end

	def psych2?
		role == "psych1"
	end

	def med1?
		role == "med1"
	end

	def med2?
		role == "med2"
	end

	def teamleader?
		role == "teamleader"
	end
end
