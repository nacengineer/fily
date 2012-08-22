# TODO Tie these datatypes to the CCAP Date and DateTime params
# tests to ensure this is working. It was at one point. Its not currently
# override timestamp_format similar to http://datamapper.wanwizard.eu/pages/config.html
require 'dm-timestamps'

module Ccap
  module Property
    module Timestamp
      def self.included(base)
        base.class_eval do
          property :created_at, DateTime
          property :created_on, Date
          property :updated_at, DateTime
          property :updated_on, Date
        end
      end
    end
  end
end