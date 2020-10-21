class CodeOfConductsController < ApplicationController
  before_action :set_code_of_conduct, only: [:show, :edit, :update, :destroy]

  # GET /code_of_conducts
  # GET /code_of_conducts.json
  def index
    @code_of_conducts = CodeOfConduct.all
  end

  # GET /code_of_conducts/1
  # GET /code_of_conducts/1.json
  def show
  end

  # GET /code_of_conducts/new
  def new
    @code_of_conduct = CodeOfConduct.new
  end

  # GET /code_of_conducts/1/edit
  def edit
  end

  # POST /code_of_conducts
  # POST /code_of_conducts.json
  def create
    @code_of_conduct = CodeOfConduct.new(code_of_conduct_params)

    respond_to do |format|
      if @code_of_conduct.save
        format.html { redirect_to @code_of_conduct, notice: 'Code of conduct was successfully created.' }
        format.json { render :show, status: :created, location: @code_of_conduct }
      else
        format.html { render :new }
        format.json { render json: @code_of_conduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_of_conducts/1
  # PATCH/PUT /code_of_conducts/1.json
  def update
    respond_to do |format|
      if @code_of_conduct.update(code_of_conduct_params)
        format.html { redirect_to @code_of_conduct, notice: 'Code of conduct was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_of_conduct }
      else
        format.html { render :edit }
        format.json { render json: @code_of_conduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /code_of_conducts/1
  # DELETE /code_of_conducts/1.json
  def destroy
    @code_of_conduct.destroy
    respond_to do |format|
      format.html { redirect_to code_of_conducts_url, notice: 'Code of conduct was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set
    @code_of_conducts = []
    repository_array = []
    code_of_conducts_repo_array = []
    CodeOfConduct.all.each do |code_of_conduct|
      if code_of_conduct.repository.repository_set_id.to_s == params['repository_set_id']
        @code_of_conducts << code_of_conduct
        code_of_conducts_repo_array << code_of_conduct.repository.login + '/' + code_of_conduct.repository.name
      end
    end
    RepositorySet.find(params['repository_set_id']).repositories.each do |repo|
      repository_array << repo.login + '/' + repo.name
    end
    @unmatched_repositories = repository_array - code_of_conducts_repo_array.uniq
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_of_conduct
      @code_of_conduct = CodeOfConduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def code_of_conduct_params
      params.require(:code_of_conduct).permit(:path, :code_of_conduct_type_id, :repository_id)
    end
end
