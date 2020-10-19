class RepositorySetsController < ApplicationController
  before_action :set_repository_set, only: [:show, :edit, :update, :destroy]

  # GET /repository_sets
  # GET /repository_sets.json
  def index
    @repository_sets = RepositorySet.all
  end

  # GET /repository_sets/1
  # GET /repository_sets/1.json
  def show
  end

  # GET /repository_sets/new
  def new
    @repository_set = RepositorySet.new
  end

  # GET /repository_sets/1/edit
  def edit
  end

  # POST /repository_sets
  # POST /repository_sets.json
  def create
    @repository_set = RepositorySet.new(repository_set_params)

    respond_to do |format|
      if @repository_set.save
        format.html { redirect_to @repository_set, notice: 'Repository set was successfully created.' }
        format.json { render :show, status: :created, location: @repository_set }
      else
        format.html { render :new }
        format.json { render json: @repository_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repository_sets/1
  # PATCH/PUT /repository_sets/1.json
  def update
    respond_to do |format|
      if @repository_set.update(repository_set_params)
        format.html { redirect_to @repository_set, notice: 'Repository set was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository_set }
      else
        format.html { render :edit }
        format.json { render json: @repository_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repository_sets/1
  # DELETE /repository_sets/1.json
  def destroy
    @repository_set.destroy
    respond_to do |format|
      format.html { redirect_to repository_sets_url, notice: 'Repository set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find_codes_of_conduct
    delete_codes_of_conduct_for_set(params['repository_set_id'].to_i)
    FindCodesOfConductJob.perform_later params['repository_set_id']
    total_time = CodeOfConductType.all.count * RepositorySet.find(params['repository_set_id']).repositories.count
    flash[:notice] = "Codes of conduct are being found in the backgroud and will take approximately #{total_time} minutes to complete.  Reload this page later to see them."
    redirect_to code_of_conduct_sets_path(params['repository_set_id'])
  end

  private

    def delete_codes_of_conduct_for_set(repository_set_id)
      CodeOfConduct.all.each do |code_of_conduct|
        if Repository.find(code_of_conduct.repository_id).repository_set_id == repository_set_id
          code_of_conduct.destroy
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_repository_set
      @repository_set = RepositorySet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repository_set_params
      params.require(:repository_set).permit(:name)
    end
end
