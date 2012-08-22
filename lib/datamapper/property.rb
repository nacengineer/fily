module DataMapper
  class Property
    # These are types that correspond to BBE Data Types
    # http://tomcruise/localdoc/DataDictionary/BBE_trunk/AllTypes.html

    class NamePrefixT < String
      def custom?; true; end
      length 4
    end

    class FirstNameT < String
      def custom?; true; end
      length 30
    end

    class LastNameT < String
      def custom?; true; end
      length 60
    end

    class MiddleNameT < String
      def custom?; true; end
      length 30
    end

    class NameSuffixT < String
      def custom?; true; end
      # TODO This needs to be 3 to match tomcruise definition
      length 30
    end

    class FullNameT < String
      def custom?; true; end
      # TODO This needs to be 3 to match tomcruise definition
      length 132
    end

    class NotesT < String
      def custom?; true; end
      length 255
      lazy true
    end

    class EmailT < String
      def custom?; true; end
      length 255
      lazy true
    end

  end
end