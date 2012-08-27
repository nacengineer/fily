require 'dm-rails/mass_assignment_security'

class User
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity

  def self.default_repository_name
    :default
  end

  # Include default devise modules
  devise :omniauthable, :rememberable, :trackable, :timeoutable

  ## Rememberable
  property :remember_created_at, DateTime

  ## Encryptable
  # property :password_salt, String

  ## Trackable
  property :sign_in_count,      Integer, :default => 0
  property :current_sign_in_at, DateTime
  property :last_sign_in_at,    DateTime
  property :current_sign_in_ip, String
  property :last_sign_in_ip,    String

  # Attributes set from eCourts
  property :e_account_no,     Integer,  :key => true
  property :atty_no,          Integer
  property :username,         String    # eCourts login name
  property :e_account_dn,     String
  property :name_f,           FirstNameT
  property :name_m,           MiddleNameT
  property :name_l,           LastNameT
  property :name_suffix,      NameSuffixT
  property :name_full,        FullNameT
  property :email,            EmailT
  property :email_cc,         EmailT
  property :pin_no,           Integer
  property :pin_confirmed,    Boolean
  property :phone_num,        String
  property :fax_num,          String

  # bbe app specific
  property :roles_mask, Integer, :default => 0

  has n, :akas
  # has n, :pictures

  # Map eAccount nodes to this user model
  EACCOUNT_MAP = {:eAccountNo => :e_account_no,
                  :attyNo => :atty_no,
                  :cn => :username,
                  :dn => :e_account_dn,
                  :firstName => :name_f,
                  :middleName => :name_m,
                  :sn => :name_l,
                  :nameSuffix => :name_suffix,
                  :fullName => :name_full,
                  :mail => :email,
                  :pinNo => :pin_no,
                  :pinNoConfirmed => :pin_confirmed,
                  :telephoneNumber => :phone_num,
                  :facsimileTelephoneNumber => :fax_num}

  # Update this model using an OmniAuth auth hash
  def update_from_auth_hash(auth_hash)
    if e_account_no && auth_hash.uid != e_account_no
      raise "eAccount #'s don't match! Expected #{e_account_no} but " +
            "got #{auth_hash.uid}"
    end
    EACCOUNT_MAP.each do |k,v|
      val = auth_hash.extra[k]
      if val && v == :email
        # Email fields come in as multiple <mail> xml nodes :/
        val = [] << val unless val.respond_to?(:each)
        self.email = val[0] if val[0]
        self.email_cc = val[1] if val[1]
        next
      elsif val && val.respond_to?(:blank?)
        self.send("#{v}=", val) unless val.blank?
      else
        self.send("#{v}=", val)
      end
    end
    self.e_account_no = auth_hash.uid
    self.save
  end

  def is_atty?
    !!atty_no
  end

  def self.find_or_create_from_auth_hash(auth_hash, signed_in_resource=nil)
    user = User.first(:e_account_no => auth_hash.uid) || User.new
    user.update_from_auth_hash(auth_hash)
    user
  end

  ROLES = %w[ normal ccap ]
  # TODO Protect from mass assignment
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  # not using is_a? here because Devise doesn't like that
  def is_an?(role)
    roles.include?(role.to_s)
  end

  # TODO encrypt ssn before storing in database
end
