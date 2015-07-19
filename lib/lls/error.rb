module Lls

  module Error

    class Base < StandardError

      attr_reader :status, :err_msg

      def initialize(msg, status)
        @err_msg = msg
        @status = status
      end
    end

    class Conflict < Base
      def initialize(message)
        super(message, 409)
      end
    end

    class Unauthorized < Base
      def initialize(message)
        super(message, 401)
      end
    end

    class NotFound < Base
      def initialize(resource)
        super("#{resource} not found", 404)
      end
    end

  end

end
