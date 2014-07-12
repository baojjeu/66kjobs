class JobsController < ApplicationController


#  before_action :login_required, :only => [:create, :new, :update, :edit, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    if params[:token].present?
      @job = Job.where(:token => params[:token]).first

      if @job.blank?
        @job = Job.new
      end

    else
      @job = Job.new
    end
  end

  # GET /jobs/1/edit
  def edit
  end


  def preview

    if params[:job][:token].present?
      @job = Job.find_by_token(params[:job][:token])
      if @job.update(job_params)
        render :preview
      else
        render :new
      end
    else

      @job = Job.new(job_params)

      if !@job.save
        render :new
      end
    end
    
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @job = Job.find_by_token(params[:id])
    if @job.update(job_params)
      render :preview
    else
      render :new
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :location , :company_name, :category_id , :apply_instruction, :url, :email)
    end
  end
