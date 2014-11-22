class UserPolicy < ApplicationPolicy

	def index?
		user.admin2? || user.admin1?
	end

	def show?
		user.admin2? || user.admin1?
	end

	def create?
		user.admin2? || user.admin1?
	end

	def update?
		user.admin2? || user.admin1?
	end

	def destroy?
		user.admin2?
	end

end