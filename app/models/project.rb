class Project < ApplicationRecord
    belongs_to :user
    has_many_attached :files, dependent: :destroy
    
    before_save :set_folder_name, if: :new_record?
    after_save :create_image_folder, if: :folder_name_changed?
    # after_create :create_image_folder
    before_destroy :remove_image_folder
  
    
    def remove_image_folder
      # Make sure the folder_name attribute is present
      return unless folder_name.present?
  
      # Remove the associated folder and its contents
      folder_path = Rails.root.join('public/uploads', folder_name)
      FileUtils.rm_rf(folder_path)
    end

    def set_folder_name
        self.folder_name = "image_folder_#{Time.now.to_i}" if folder_name.blank?
      end
    
      def create_image_folder
        folder_path = Rails.root.join('public/uploads', folder_name)
        FileUtils.mkdir_p(folder_path)
        add_files_to_image_folder(folder_path)
      end
    
      def add_files_to_image_folder(folder_path)
        files.each do |file|
          next unless file.image?
    
          # Get the image content and save it to the new location
          File.open(File.join(folder_path, file.filename.to_s), 'wb') do |f|
            f.write(file.download)
          end
        end
      end
  end
  