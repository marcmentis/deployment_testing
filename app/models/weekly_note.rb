class WeeklyNote < ActiveRecord::Base
	belongs_to :patient

	def self.latest_note_array(facility)
		# Get latest note for each patient
		# latestNoteRelation = WeeklyNote.group(:pat_id)
  #                                      .having(WeeklyNote.maximum(:meeting_date))

  		# GETS RELATION FOR LATEST NOTES ACROSS ALL FACILITIES
        # latestNoteRelation = WeeklyNote.find_by_sql("SELECT * 
        # 											FROM weekly_notes w1 
        # 	                                        WHERE w1.meeting_date IN (SELECT max(w2.meeting_date) max_meeting_date 
        # 	                                        	FROM weekly_notes w2 
        # 	                                        	WHERE w2.patient_id = w1.patient_id 
        # 	                                        	GROUP BY w2.patient_id) ")

		# GETS RELATION FOR LATEST NOTES AT GIVEN FACILITY
       latestNoteRelation = WeeklyNote.find_by_sql("SELECT * 
        											FROM weekly_notes w1 
        	                                        WHERE w1.meeting_date IN (SELECT max(w2.meeting_date) max_meeting_date 
        	                                        	FROM weekly_notes w2, patients p1
        	                                        	WHERE w2.patient_id = p1.id 
        	                                        	AND p1.facility = '"+facility+"'
        	                                        	AND w2.patient_id = w1.patient_id 
        	                                        	GROUP BY w2.patient_id) ")

       



        # Extract id's from Relation into an array (can be used like IN clause)                               
        latestNoteArray = latestNoteRelation.map(&:id)
	end

	def self.filter_notes(params)
 # byebug
		notes = Patient.joins(:weekly_notes)
						.order(lastname: :asc)
					# .where(pats: {ward: params[:q][:ward_cont]})
					# .where(weekly_notes: {danger_yn: params[:q][:danger_yn_cont]}) if params[:q][:danger_yn_cont].present?
					# .where(weekly_notes: {doa: params[:doa]}) if params[:doa].present?
			
	end

	def self.get_pat_lists (params, facility)
		# byebug
		# Create @all_done an @all_to_do dependent upon what date should be used:
	    if params[:sPreviousMeetings] != ""
	      chosen_date = params[:sPreviousMeetings]
	      # Get all the Patients who have weekly notes from a given ward and date
	      all_done = WeeklyNote.pat_all_done(params, chosen_date, facility)

	      # Get all Patients who do NOT have weekly notes from a given ward and date
	      all_to_do = WeeklyNote.pat_all_to_do(params, all_done, facility)
	    elsif params[:meeting_date] != ""
	      chosen_date = params[:meeting_date]
	      # Get all the Patients who have weekly notes from a given ward and date
	      all_done = WeeklyNote.pat_all_done(params, chosen_date, facility)

	      # Get all Patients who do NOT have weekly notes from a given ward and date
	      all_to_do = WeeklyNote.pat_all_to_do(params, all_done, facility)
	    else
	      all_done = []
	      all_to_do = []
	      chosen_date = ""
	    end

	    return {pat_all_done: all_done, pat_all_to_do: all_to_do, meeting_date: chosen_date}
		
	end
    



		# Get all the Patients who have weekly notes from a given ward and date
		def self.pat_all_done(params, chosen_date, facility)
			# byebug
		    all_done = Patient.joins(:weekly_notes)
		    					.where(patients: {facility: facility})
		                  		.where(patients: {ward: params[:t_ward]})
		                 		.where(weekly_notes: {meeting_date: chosen_date})
		                		.order(lastname: :asc)
		end

		# Get all Patients who do NOT have weekly notes from a given ward and date
		def self.pat_all_to_do(params, all_done, facility)
			# Create an array of Pat.id to use in .where IN in @all_to_do
		    not_these_ids = all_done.each.map{|p| p.id}

		    # Passing .where.not an empty array results in a nil result. 
		       # An empty string will give all those patients in the ward not in the array
		    not_these_ids.empty? ? not_these_ids = [""] : not_these_ids

			all_to_do = Patient.where(patients: {ward: params[:t_ward]})
								.where(patients: {facility: facility})
	                  			.where.not(id: not_these_ids)
	                  			.order(lastname: :asc)	
		end

end
