class Pic < ActiveRecord::Base
mount_base64_uploader :photo, PhotoUploader
end
