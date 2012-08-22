module Ccap
  module Monkeys
    # Here there be monkeys!

    module ActiveSupport::Inflector

      def titleize(word)
        humanize(underscore(word)).gsub(/\b('?[a-z]{3})/) { $1.capitalize }
      end

    end
  end
end