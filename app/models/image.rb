class Image < ApplicationRecord
    mount_uploader :image_path, SummernoteUploader
end
