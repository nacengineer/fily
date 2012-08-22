class Aka
  # This is essentially User aliases. Alias is a ruby reserved word
  include DataMapper::Resource
  include DataMapper::Overrides

  def self.default_repository_name
    :default
  end

  property :id,           Serial
  property :name_f,       FirstNameT
  property :name_l,       LastNameT
  property :name_m,       MiddleNameT
  property :name_suffix,  NameSuffixT
  property :notes,        NotesT

  belongs_to :user

  def name_full
    a = [name_f, name_m, name_l, name_suffix]
    a.compact!
    a.delete_if(&:blank?)
    a.join(' ')
  end

end