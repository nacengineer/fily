class Picture
  include DataMapper::Resource
  # include Rails.application.routes.url_helpers

  def self.default_repository_name
    :default
  end

  mount_uploader :avatar, AvatarUploader

  attr_accessor :gender
  property  :id,          Serial, :key => true
  property  :avatar_uid,  Integer
  property  :name,        String
  property  :avatar_name, String
  property  :path,        String
  property  :avatar,      String
  property  :created_at,  DateTime
  property  :updated_at,  DateTime

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name"        => read_attribute(:avatar),
      "size"        => avatar.size,
      "url"         => avatar.url,
      "delete_url"  => picture_path(:id => id),
      "delete_type" => "DELETE"
    }
  end
end