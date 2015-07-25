class WordDefsController < ApplicationController
  before_action :set_word_def, only: [:show, :edit, :update, :destroy]

  # GET /word_defs
  # GET /word_defs.json
  def index
    @word_defs = WordDef.all
  end

  # GET /word_defs/1
  # GET /word_defs/1.json
  def show
  end

  # GET /word_defs/new
  def new
    @word_def = WordDef.new
  end

  # GET /word_defs/1/edit
  def edit
  end

  # POST /word_defs
  # POST /word_defs.json
  def create
    @word_def = WordDef.new(word_def_params)

    respond_to do |format|
      if @word_def.save
        format.html { redirect_to @word_def, notice: 'Word def was successfully created.' }
        format.json { render :show, status: :created, location: @word_def }
      else
        format.html { render :new }
        format.json { render json: @word_def.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /word_defs/1
  # PATCH/PUT /word_defs/1.json
  def update
    respond_to do |format|
      if @word_def.update(word_def_params)
        format.html { redirect_to @word_def, notice: 'Word def was successfully updated.' }
        format.json { render :show, status: :ok, location: @word_def }
      else
        format.html { render :edit }
        format.json { render json: @word_def.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /word_defs/1
  # DELETE /word_defs/1.json
  def destroy
    @word_def.destroy
    respond_to do |format|
      format.html { redirect_to word_defs_url, notice: 'Word def was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word_def
      @word_def = WordDef.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_def_params
      params.require(:word_def).permit(:title, :en, :jp, :eg)
    end
end
