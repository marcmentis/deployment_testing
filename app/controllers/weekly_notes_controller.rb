class WeeklyNotesController < ApplicationController
  # before_action :set_weekly_note, only: [:show, :edit, :update, :destroy]
  before_action :set_weekly_note, only: [:show, :update, :destroy]
  before_action :set_new_for_authorize, only: [:presentation, :meetings, :new_with_pat]
  after_action :verify_authorized

# WEEKLY NOTE

  # GET/POST /weekly_notes/presentation(.:format) 
    # From Navigation WeeklyClinical _header.html.erb, presentation.html.erb 
  def presentation
    if params[:s_weekly_ward].nil?
      # Generate the 2d array needed for grouped select in view
      @grouped_options = ForSelect.GroupedSelect(session[:facility], 'ward', ForSelect)
    end

    @all_done = []
    @all_to_do = []
    @meeting_date = WeeklyNote.select(:meeting_date).distinct.joins(:patient)
                              .where(patients: {facility: session[:facility]})
                              .where(patients: {ward: params[:s_weekly_ward]})
                              .order(meeting_date: :desc)

    # Need to convert the ActiveRecord Relation to an array
      # Oracle doesn't present meeting_date as a formatted string
      # Need to format meeting_date (can't do that in the @meeting_date relation)
      # Creating an @meeting_date ARRAY can use "options_for_select(@meeting_date)"
      # in presentation.js.erb for the previous meeting date select.
      # ( The ActiveRecord Relation uses "options_from_collection_for_select")
    @meeting_date.to_a.map! {|meeting| meeting.meeting_date.strftime('%F')}
    
    respond_to do |format|
      format.html {}
      format.js {}
    end   
  end

  # GET weekly_notes/meetings(.:format)
    # From New Meeting Date Input,  presentation.html.erb
  def meetings
    # byebug
    facility = session[:facility]
    all_lists = WeeklyNote.get_pat_lists(params, facility)
    @all_done = all_lists[:pat_all_done]
    @all_to_do = all_lists[:pat_all_to_do]
    @chosen_date = all_lists[:meeting_date]

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  # /weekly_notes/:id/new(.:format)
    # From WeeklyNote To Do list new link
      # presentation.html.erb, _to_do.html.erb
  def new_with_pat
    # byebug
    # 
    @pat = Patient.find(params[:id])
    # Get all meeting notes for patient
    @pat_notes = WeeklyNote.joins(:patient)
                          .where(weekly_notes: {patient_id: @pat[:id]})
                          .order(meeting_date: :desc)

    # Get CollectionsForSelect for drug and group selects
    @drug_collection = ForSelect.CollectionForSelect('9999', 'drugs_changed', ForSelect)


    respond_to do |format|
      format.html {render action: 'new'}
      format.js { render "new_edit"}
    end
  end

  # GET /weekly_notes/1/edit
  def edit
    @pat = Patient.find(params[:id])
    # Need to add .first to convert ActionRecord Relation to object
      # _form needs an object passed to it
    @weekly_note = WeeklyNote.joins(:patient)
                              .where(patients: {id: params[:id]})
                              .where(weekly_notes: {meeting_date: params[:chosen_date]})
                              .first
    # Get all meeting notes for patient
    @pat_notes = WeeklyNote.joins(:patient)
                          .where(weekly_notes: {patient_id: @pat[:id]})
                          .order(meeting_date: :desc)

    # Get CollectionsForSelect for drug and group selects
    @drug_collection = ForSelect.CollectionForSelect('9999','drugs_changed', ForSelect)

    # Doesn't need WeeklyNote.new as can only be reached AFTER a weekly note created
    authorize @weekly_note
    respond_to do |format|
      format.html {render action: 'new'}
      format.js { render "new_edit"}
    end
  end

  # POST /weekly_notes
  # POST /weekly_notes.json
  def create
   @weekly_note = WeeklyNote.new(weekly_note_params)
    # byebug
    authorize @weekly_note
    respond_to do |format|
      if @weekly_note.save
        format.html { redirect_to @weekly_note, notice: 'Weekly note was successfully created.' }
        # Added params to .js redirect. 
          # Made meeting_date = to sPreviousMeetings as that is first condition tested in action 'meetings'
        format.js { redirect_to action: 'meetings', t_ward: params[:th_ward], sPreviousMeetings: weekly_note_params[:meeting_date]}
        format.json { render action: 'show', status: :created, location: @weekly_note }
      else
        format.html { render action: 'new' }
        format.js { render plain: "Create error"}
        format.json { render json: @weekly_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_notes/1
  # PATCH/PUT /weekly_notes/1.json
  def update
    respond_to do |format|
      if @weekly_note.update(weekly_note_params)
        format.html { redirect_to @weekly_note, notice: 'Weekly note was successfully updated.' }
        format.js { redirect_to action: 'meetings', t_ward: params[:th_ward], sPreviousMeetings: weekly_note_params[:meeting_date]}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weekly_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_notes/1
  # DELETE /weekly_notes/1.json
  def destroy
    @weekly_note.destroy
    respond_to do |format|
      format.html { redirect_to weekly_notes_url }
      format.json { head :no_content }
    end
  end




# MEETING TRACKER

    # GET weekly_notes/meetingtracker(.:format)
    # From Navigation Meeting Tracker,  _header.html.erb, meetingtracker.html.erb
  def meetingtracker
    # byebug
    latestNoteArray = WeeklyNote.latest_note_array(session[:facility])
    # Passing in array to WeeklyNote is a SQL IN clause (for latest notes)
    latestNote = WeeklyNote.where(id: latestNoteArray)


    @q = latestNote.search(params[:q])
    @weeklyNotes = @q.result.includes(:patient).page(params[:page]).per(15)

    @totNumber = latestNote.all.count
    @searchNumber = @q.result.all.count

    # Generate the 2d array needed for grouped select in view
    @grouped_options = ForSelect.GroupedSelect(session[:facility], 'ward', ForSelect)
    @drug_collection = ForSelect.CollectionForSelect('9999','drugs_changed', ForSelect)

    authorize @weeklyNotes
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end


# EITHER
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_note
      @weekly_note = WeeklyNote.find(params[:id])
      authorize @weekly_note
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_note_params
      params.require(:weekly_note).permit(:patient_id, :danger_yn, :drugs_last_changed, :drugs_not_why, 
        :drugs_change_why, :meeting_date, :pre_date_yesno, :pre_date_no_why, :date_pre)
    end

    def set_new_for_authorize
      # Needed before first weekly note created, and in actions with no WeeklyNote db call
      @weekly_note = WeeklyNote.new
      authorize @weekly_note
    end
end
