class ContactsController < ApplicationController
  
  require 'csv'
  def index
    # fileList = Dir.glob("#{Rails.root}/public/uploads/*.csv")
    # s3fileList = S3_BUCKET.objects['.csv']
    s3fileList = S3_BUCKET.objects.collect(&:key)
    # @files = processFileList(fileList)
    @files = processFileList(s3fileList)
    @busy = checkProcessing()
  end
  
  def search
    @contacts = Contact.search(params[:search])
  end
  
  def checkProcessing()
    processingFileList = S3_BUCKET.objects(prefix: 'processing').collect(&:key)
    # Dir.glob("#{Rails.root}/public/uploads/processing/*.csv")
    if underProcess(processingFileList).empty?
      return false
    else
      return underProcess(processingFileList)
      # return processingFileList
    end
  end
  
  def underProcess(fileList)
    files = []
    fileList.each do |fileName|
      if fileName == 'processing/'
        next
      end
      files << fileName.split("/").last
    end
    return files
  end
  
  def processFileList(fileList)
    files = []
    fileList.each do |fileName|
      if fileName =~ /processing\//
        next
      end
      files << fileName.split("/").last
    end
    return files
  end
  
  def process_file
    begin
      @rowarray = []
      #oldFile = File.open("#{Rails.root}/public/uploads/" + params[:file], "r")
      s3 = Aws::S3::Client.new
      newFile = File.open(Rails.root.join('tmp', params[:file]), 'wb')
      @filePath = "#{Rails.root}/tmp/" + params[:file]
      oldFile = File.open(s3.get_object({ bucket:ENV['S3_BUCKET_NAME'], key: params[:file] }, target: newFile).body)
        csv = CSV.new(oldFile, headers: false)
        @rowarray << csv.first
        @rowarray << csv.first
        #puts @rowarray.to_a
      
      newFile.write(oldFile.read)
      newFile.close
      oldFile.close
      sourceFile = S3_BUCKET.object(params[:file])
      newObj = S3_BUCKET.object("processing/" + params[:file])
      aws_response = newObj.copy_from(sourceFile)
      sourceFile.delete
      puts aws_response
      @filePath = "#{Rails.root}/tmp/" + params[:file]
    rescue
      redirect_to root_url, error: "Invalid CSV file format."
    end
  end
  
  def save_list
    begin
      list = List.where(title: params[:title]).first || List.create!(title: params[:title])
        column = params[:column].to_i
        headerRow = params[:headerRow]
        filePath = params[:filePath]
      UltimateJob.perform_async(column, headerRow, filePath, list.id)
      redirect_to root_url, notice: "File is being filtered of duplicates and will be available shortly."
    rescue
      redirect_to root_url, error: "Something went wrong."
    end
  end
  
  def load_to_s3
    # UploadJob.perform_async(params)
    # https://c9.io/jonatans/ruby-aws-s3-example
    #make an object in your bucket for the upload
    file_to_upload = params[:file]
    file_name = params[:file].original_filename
    bucket = S3.bucket(S3_BUCKET.name)

    obj = bucket.object(file_name)
    #byebug

    #upload the file:
    obj.put(
      acl: "public-read",
      body: file_to_upload
    )
    redirect_to root_url, notice: "File has been uploaded."
  end

  
  def load_to_drive
    redirect_to root_url, notice: "File has been uploaded."
    UploadJob.perform_async(params)
  end

  def create_list
    @contacts = Contact.where(list_id: params[:listId]).limit(params[:sampleSize])
    @list = List.where(id: params[:listId]).first.title
    @listId = params[:listId]
    @sampleSize = params[:sampleSize]
    @filename = "phone list_#{@list}_#{params[:sampleSize]} items.csv"
    #render create_list_contacts_path
  end
  
  def download
    begin
      @contacts = Contact.where(list_id: params[:listId]).limit(params[:sampleSize])
      #puts @contacts
      respond_to do |format|
        format.html 
        format.csv {send_data @contacts.to_csv, filename: params[:file], disposition: 'attachment'}
      end
      #puts @contacts.to_csv
    rescue
      redirect_to root_url, notice: "Something went wrong."
    end
  end # end dowload
  
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # def catch_404
  #   raise ActionController::RoutingError.new(params[:path])
  #   raise ActionView::MissingTemplate.new(params[:path])
  # end
end