class CodeOfConductTypesController < ApplicationController
  before_action :set_code_of_conduct_type, only: [:show, :edit, :update, :destroy]

  # GET /code_of_conduct_types
  # GET /code_of_conduct_types.json
  def index
    @code_of_conduct_types = CodeOfConductType.all
  end

  # GET /code_of_conduct_types/1
  # GET /code_of_conduct_types/1.json
  def show
  end

  # GET /code_of_conduct_types/new
  def new
    @code_of_conduct_type = CodeOfConductType.new
  end

  # GET /code_of_conduct_types/1/edit
  def edit
  end

  # POST /code_of_conduct_types
  # POST /code_of_conduct_types.json
  def create
    @code_of_conduct_type = CodeOfConductType.new(code_of_conduct_type_params)

    respond_to do |format|
      if @code_of_conduct_type.save
        format.html { redirect_to @code_of_conduct_type, notice: 'Code of conduct type was successfully created.' }
        format.json { render :show, status: :created, location: @code_of_conduct_type }
      else
        format.html { render :new }
        format.json { render json: @code_of_conduct_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_of_conduct_types/1
  # PATCH/PUT /code_of_conduct_types/1.json
  def update
    respond_to do |format|
      if @code_of_conduct_type.update(code_of_conduct_type_params)
        format.html { redirect_to @code_of_conduct_type, notice: 'Code of conduct type was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_of_conduct_type }
      else
        format.html { render :edit }
        format.json { render json: @code_of_conduct_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /code_of_conduct_types/1
  # DELETE /code_of_conduct_types/1.json
  def destroy
    @code_of_conduct_type.destroy
    respond_to do |format|
      format.html { redirect_to code_of_conduct_types_url, notice: 'Code of conduct type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_of_conduct_type
      @code_of_conduct_type = CodeOfConductType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def code_of_conduct_type_params
      params.require(:code_of_conduct_type).permit(:name, :url)
    end
end
