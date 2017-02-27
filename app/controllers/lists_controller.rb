class ListsController < ApplicationController
  # before_action :authentication_required!
  before_action :set_list, only: [:update, :destroy]
  
  def index
    authentication_required!
    @lists = List.all
    # puts checkProcessing()
    # if checkProcessing()
      # @listRef = List.all.select("lists.*").joins(:contacts).order('contacts.created_at DESC').first
      #@totalCount = UltimateJob.new.count(checkProcessing())
      #puts checkProcessing(), @listRef, @totalCount
    # else
      # @listId = nil
    # end
  end
  
  # def checkProcessing()
  #   processingFileList = Dir.glob("#{Rails.root}/tmp/*.csv")
  #   if processingFileList.empty?
  #     return false
  #   else
  #     return processingFileList[0]
  #   end
  # end
  
  def show
  end

  def new
    authentication_required!
    @list = List.new
  end

  def edit
  end

  def create
    authentication_required!
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authentication_required!
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authentication_required!
    @list.destroy
    #DeleteWorker.perform_async(@list.id)
    #DeleteListJob.perform_async(@list.id)
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title)
    end
end