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

  end

end
