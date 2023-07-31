require 'stringio'
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show iframe edit update destroy ]
  before_action :ensure_owner, only: %i[edit update destroy]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
    @html_content = @project.files.blobs.find_by(content_type: 'text/html')&.download
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  def iframe
    @html_content = @project.files.blobs.find_by(content_type: 'text/html')&.download
    @html_content = remove_local_css_and_scripts(@html_content)
  
    # Fetch all CSS files from the project's attached files
    @css_files = @project.files.select { |file| file.content_type.in?(%w(text/css)) }
  
    # Fetch all JS files from the project's attached files
    @js_files = @project.files.select { |file| file.content_type.in?(%w(text/javascript)) }
  
    # Fetch all image files from the project's attached files (assuming you want image files here)
    @image_files = @project.files.select { |file| file.image? }
  
    render layout: false # To render the iframe view without the default layout
  end
  
  # GET /projects/1/edit
  def edit
  end
  def ensure_owner
    # Ensure that the current_user is the owner of the project
    redirect_to root_path, alert: "You are not authorized to perform this action." unless @project.user == current_user
  end
  # POST /projects or /projects.json
  def create
    @project = current_user.projects.new(project_params)
    respond_to do |format|
      if @project.save
        # Create the image folder and move image files
        add_files_to_image_folder(@project) # Call the method here

        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  
  

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        # Call the method to add image files to the folder
        add_files_to_image_folder(@project)

        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      @js_attachment = @project.files.blobs.find_by(content_type: 'application/javascript')
      @css_attachment = @project.files.blobs.find_by(content_type: 'text/css')
      
    end
    

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, files: [])
    end


    def add_files_to_image_folder(project)
      base_folder_path = Rails.root.join('public/uploads', project.folder_name)
      FileUtils.mkdir_p(base_folder_path)
    
      project.files.each do |file|
        # Check the content type of the file
        case file.content_type
        when 'image/jpeg', 'image/png', 'image/gif', 'text/css', 'text/javascript', 'application/javascript'
          # Save the file to the main folder
          file_path = File.join(base_folder_path, file.filename.to_s)
    
          # Save the file to the respective folder
          File.open(file_path, 'wb') { |f| f.write(file.download) }
        else
          # Skip files with unknown content types or handle them accordingly
          next
        end
      end
    end
    
    
    def ensure_owner
      # Ensure that the current_user is the owner of the project
      redirect_to root_path, alert: "You are not authorized to perform this action." unless @project.user == current_user
    end
    
    def remove_local_css_and_scripts(html_content)
      doc = Nokogiri::HTML.fragment(html_content)
    
      # Select and remove locally included CSS <link> tags with .css files
      doc.css("link[rel='stylesheet']").each do |link|
        href = link['href']
        link.remove if href&.start_with?('/') || href&.start_with?('./') || href&.start_with?('../')
      end
    
      # Select and remove locally included <script> tags
      doc.css("script[src]").each do |script|
        src = script['src']
        script.remove if src&.start_with?('/') || src&.start_with?('./') || src&.start_with?('../')
      end
    
      doc.to_html
    end
    
    
    
    
    
end
