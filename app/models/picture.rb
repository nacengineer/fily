require 'securerandom'
require 'carrierwave/datamapper'

require 'carrierwave/datamapper'

class Picture
  include Rails.application.routes.url_helpers
  include DataMapper::Resource

  def self.default_repository_name
    :default
  end

  property  :id,          Serial,  :key => true
  # property  :avatar_uid,  Integer
  # property  :name,        String
  # property  :avatar_name, String
  # property  :path,        String
  # property  :avatar,      String, :length => 255
  # property  :created_at,  DateTime
  # property  :updated_at,  DateTime

  # belongs_to :user
  mount_uploader :source, AvatarUploader

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name"        => id,
      "size"        => source.size,
      "url"         => source.url,
      "delete_url"  => picture_path(:id => id),
      "delete_type" => "DELETE"
    }
  end

end