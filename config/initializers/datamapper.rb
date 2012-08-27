require 'ccap_naming_conventions'
require 'overrides'
require 'property'

dm = Rails::DataMapper.configuration
convention_resource = DataMapper::NamingConventions::Resource::CamelizedWithoutModule
convention_fields   = DataMapper::NamingConventions::Field::CamelizedWithoutModule

Rails::DataMapper.configuration.resource_naming_convention[:default] = convention_resource
Rails::DataMapper.configuration.field_naming_convention[:default]    = convention_fields

repos = Rails::DataMapper.configuration.raw[Rails.env.to_s]['repositories']

if repos
  repos.each do |k,v|
    Rails::DataMapper.configuration.resource_naming_convention[ k.to_sym ] = convention_resource
    Rails::DataMapper.configuration.field_naming_convention[ k.to_sym ]    = convention_fields
  end
end
