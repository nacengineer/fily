module DataMapper
  module NamingConventions
    module Resource
      module CamelizedWithoutModule
        def self.call(name)
          DataMapper::Inflector.camelize(
            DataMapper::Inflector.underscore(
              DataMapper::Inflector.demodulize( name )
            )
          )
        end
      end
    end
  
    module Field
      module CamelizedWithoutModule
        def self.call(property)
          c = DataMapper::Inflector.camelize(
            DataMapper::Inflector.underscore(
              DataMapper::Inflector.demodulize( property.name.to_s )
            )
          )
          c[0] = c[0].downcase
          c
        end
      end
    end
  end
end