# encoding: utf-8

module CapistranoSimpleFormatter
  class Spinner
    CHARS = ['|', '/', '-', '\\']

    def initialize
      @running = false
    end

    def start
      return if @running

      @running = true
      @thread = Thread.new do
        while @running do
          print CHARS.rotate!.first
          sleep 0.1
          print "\b"
        end
      end
    end

    def stop
      return unless @running

      @running = false
      @thread.join
    end
  end
end
