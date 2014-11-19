class ForSelect < ActiveRecord::Base

	# Create a 2d array to be used in "grouped_options_for_select" in "select-tag"
	# "db_model" is the name of the model containing all the select information
	# "code" is the value in the code field in the db_model that identifies
		# which group of values will appear in the grouped select
	# "grouped_options" is my gem which generates the 2d array
		# gem 'grouped_options', git: 'git@github.com:marcmentis/grouped_options.git'
	def self.GroupedSelect(facility, code, db_model)
		@forSelect = db_model.all
					  .where(facility: facility)
                      .where(code: code)
                      .order(option_order: :asc)  
	    # @grouped_options = ForSelect.grouped_options(@forSelect)
	    @grouped_options = GroupedOptions.grouped_options(@forSelect)
		
	end

	def self.CollectionForSelect(code, db_model)
		select_collection = db_model.where(code: code)
									.order(option_order: :asc)
	end
end
