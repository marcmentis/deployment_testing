class Patient < ActiveRecord::Base
	has_many :weekly_notes, dependent: :destroy
end
