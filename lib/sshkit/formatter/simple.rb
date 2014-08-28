# encoding: utf-8

require 'sshkit'

module SSHKit
  module Formatter
    class Simple < Abstract
      def initialize(original_output)
        super(original_output)

        @spinner = CapistranoSimpleFormatter::Spinner.new
        @in_block = false
      end

      def start(message, &block)
        @spinner.start

        begin
          if block_given?
            @in_block = true
            puts "\b#{message}".yellow
            block.call()
            stop
            @in_block = false
          else
            print "\b#{message}   ".yellow
          end
        rescue Exception => e
          stop
          @in_block = false
          error("\n X ERROR: #{e.message}\n")
          raise e
        end
      end

      def stop
        @spinner.stop
      end

      def result(message)
        if @in_block
          print "\b"
          message = "  ├── #{message}"
        else
          stop
        end

        puts(message)
      end

      def info(message)
        result(message)
      end

      def error(message = 'X')
        result(message.red)
      end

      def success(message = '✔')
        result(message.green)
      end

      def write(message) end

      alias :<< :write
    end
  end
end
