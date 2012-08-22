# include this in models with Compound Primary Keys
# with "include DataMapper::Overrides"
module DataMapper
  module Overrides
    def self.included(klass)
      klass.extend ClassMethods
    end

    def to_param
      key.collect{|k| k.to_s}.join(',')
    end

    module ClassMethods
      def get_from_param(param)
        get(*param.split(','))
      end
    end
  end
end