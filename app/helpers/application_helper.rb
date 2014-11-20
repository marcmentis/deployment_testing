module ApplicationHelper
	# Create a 'current_user' method
	def current_user
		# User.find(session[:current_user_id])
		# Needs to be an array not an ActiveRecord Relation
		User.where('authen == ?', session[:authen]).first
	end
end
