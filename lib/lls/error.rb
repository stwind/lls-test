module Lls

  module Error

    class LlsError < StandardError

      attr_reader :status, :err_msg

      def initialize(msg, status)
        @err_msg = msg
        @status = status
      end
    end

    class Conflict < LlsError
      def initialize(message)
        super(message, 409)
      end
    end

    class Unauthorized < LlsError
      def initialize(message)
        super(message, 401)
      end
    end

    class NotFound < LlsError
      def initialize(resource)
        super("#{resource} not found", 404)
      end
    end

  end

end
