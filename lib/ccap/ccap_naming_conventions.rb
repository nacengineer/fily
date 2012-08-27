module DataMapper

  # example --> my_table_name becomes MyTableName
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

    # example --> my_field_name becomes myFieldName
    # notice the extra step to downcase. also if you just
    # do c[0] in Rails < 1.9 you'll get a bytecode.
    module Field
      module CamelizedWithoutModule
        def self.call(property)
          c = DataMapper::Inflector.camelize(
            DataMapper::Inflector.underscore(
              DataMapper::Inflector.demodulize( property.name.to_s )
            )
          )
          c[0,1] = c[0,1].downcase
          c
        end
      end
    end
  end
end