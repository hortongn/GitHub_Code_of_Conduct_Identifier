class RepositoryLoadersController < ApplicationController
  before_action :set_repository_loader, only: [:show, :edit, :update, :destroy]

  # GET /repository_loaders
  # GET /repository_loaders.json
  def index
    @repository_loaders = RepositoryLoader.all
  end

  # GET /repository_loaders/1
  # GET /repository_loaders/1.json
  def show
  end

  # GET /repository_loaders/new
  def new
    @repository_loader = RepositoryLoader.new
  end

  # GET /repository_loaders/1/edit
  def edit
  end

  # POST /repository_loaders
  # POST /repository_loaders.json
  def create
    repository_set = RepositorySet.create(name: params['repository_loader']['set_name'])

    repos = params['repository_loader']['repository_list']
    repo_list = repos.split(/\r\n/)
    repo_list.each do |repo|
      login_and_name = repo.split(/\//)
      Repository.create(login: login_and_name[0], name: login_and_name[1], repository_set_id: repository_set.id)
    end

    redirect_to repository_set_path(repository_set.id)
  end

  # PATCH/PUT /repository_loaders/1
  # PATCH/PUT /repository_loaders/1.json
  def update
    respond_to do |format|
      if @repository_loader.update(repository_loader_params)
        format.html { redirect_to @repository_loader, notice: 'Repository loader was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository_loader }
      else
        format.html { render :edit }
        format.json { render json: @repository_loader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repository_loaders/1
  # DELETE /repository_loaders/1.json
  def destroy
    @repository_loader.destroy
    respond_to do |format|
      format.html { redirect_to repository_loaders_url, notice: 'Repository loader was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository_loader
      @repository_loader = RepositoryLoader.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repository_loader_params
      params.require(:repository_loader).permit(:repository_list)
    end
end
