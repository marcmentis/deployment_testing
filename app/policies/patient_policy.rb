class PatientPolicy < ApplicationPolicy
	def index?
		user.admin2? || user.admin1? || user.psych1? || 
		user.psych2? || user.med1? || user.med2?
	end

	def create?
		user.admin2? || user.admin1? || user.psych1? || 
		user.psych2? || user.med1? || user.med2?
	end

	def update?
		user.admin2? || user.admin1? || user.psych1? || 
		user.psych2? || user.med1? || user.med2?
	end
end