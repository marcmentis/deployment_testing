class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /patients
  # GET /patients.json
  def index
    # @patients = Patient.all
    #Admin 2 can see all facility patients. All others only their own facility
    if session[:role] == 'admin2'
      @q = Patient.search(params[:q])  
      @patients = @q.result.page(params[:page]).per(15)

      @totNumber = Patient.all.count
      @searchNumber = @q.result.count
  
    else 
      # Get patients for ransack
      fac_patients = Patient.where('facility = ?', session[:facility])
      @q = fac_patients.search(params[:q]) 
      @patients = @q.result.page(params[:page]).per(15)

      # @totNumber = Patient.all.count
      @totNumber = fac_patients.count
      @searchNumber = @q.result.count  

    end
   
    # Generate the 2d array needed for grouped select in view
    @grouped_options = ForSelect.GroupedSelect(session[:facility],'ward', ForSelect) 
    @grouped_options2 = ForSelect.GroupedSelect('9999','facility', ForSelect)

    authorize @patients
    respond_to do |format|
      format.html { render action: 'index' }
      format.js {}
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    authorize @patient

    # Generate the 2d array needed for grouped select in view
    @grouped_options = ForSelect.GroupedSelect(session[:facility],'ward', ForSelect) 
    @grouped_options2 = ForSelect.GroupedSelect('9999','facility', ForSelect)

    respond_to do |format|
      format.html { render action: 'new' }
      format.js { render "new_edit" }
    end
  end

  # GET /patients/1/edit
  def edit
    # Generate the 2d array needed for grouped select in view
    @grouped_options = ForSelect.GroupedSelect(session[:facility],'ward', ForSelect) 
    @grouped_options2 = ForSelect.GroupedSelect('9999','facility', ForSelect)
    
    respond_to do |format|
      format.html { render action: 'edit' }
      format.js { render "new_edit" }
    end
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    authorize @patient

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Pat was successfully created.' }
        format.js {render "update_create"}
        format.json { render action: 'show', status: :created, location: @pat }
      else
        format.html { render action: 'new' }
        format.json { render json: @pat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
      authorize @patient
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:firstname, :lastname, :number, :facility, :ward, :doa, :dob, :dod, :updated_by)
    end
end
