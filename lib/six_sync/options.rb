require 'optparse'
require 'ostruct'

module SixSync
  ##
  # Handles commandline parameters
  class Options
    class <<self
      ##
      # Parse given args
      #
      # === Arguments
      #
      # * +args+ - Optional. Parse given args. Defaults to ARGV (commandline args)
      def parse args = ARGV
        options = OpenStruct.new
        options.tasks = []

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: #{$0} [options]"
          opts.separator ""
          opts.separator "Specific options:"

          opts.on("-c", "--clone URL",
            "Clone from given URL") do |url|
            options.tasks << [:clone, url]
          end

          opts.on("-i", "--init [DIR]",
                  "Init at given dir, or current dir if unspecified") do |dir|
            dir = Dir.pwd if dir.nil?
            options.tasks << [:init, dir]
          end

          # Boolean switch.
          opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
            options.verbose = v
          end

          opts.separator ""
          opts.separator "Common options:"

          # No argument, shows at tail.  This will print an options summary.
          # Try it and see!
          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            return exit
          end

          # Another typical switch to print the version.
          opts.on_tail("-v", "--version", "Show version") do
            puts SixSync::VERSION
            return exit
          end
        end

        opts.parse!(args)

        options
      end
    end
  end
end