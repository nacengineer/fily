require 'securerandom'
require 'carrierwave/datamapper'

require 'carrierwave/datamapper'

class Document
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

  mount_uploader :source, DocumentUploader

  belongs_to :user

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name"        => file_name,
      "size"        => source.size,
      "url"         => source.url,
      "delete_url"  => document_path(:id => id),
      "delete_type" => "DELETE"
    }
  end

  def file_name
    source.to_s.split("/").last
  end

  # before :valid do
  #   u = User.first || User.create(:user_e_account_no => Time.now.to_i)
  #   user_e_account_no( u.user_e_account_no )
  # end

end