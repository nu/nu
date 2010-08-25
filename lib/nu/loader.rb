require 'rubygems'
require 'rubygems/dependency_installer'
require 'lib/nu/lib_tools'
require 'lib/nu/gem_tools'
require 'lib/nu/project'

module Nu
  class Loader
    
    def self.load(name)
      load(name, 'lib')
    end

    def self.load(name, location, version)
      #improve the crap out of this
      @gem_name = name
      @location = location
      @version = version

      if !gem_available?
        puts "Gem #{@gem_name} #{@version} is not installed locally - I am now going to try and install it"
        begin
          inst = Gem::DependencyInstaller.new
          inst.install @gem_name, version
          inst.installed_gems.each do |spec|
            puts "Successfully installed #{spec.full_name}"
          end
        rescue Gem::GemNotFoundException => e
          puts "ERROR: #{e.message}"
          return #GTFO
        end
      else
        puts "Found Gem"
      end
      #TODO: better error handling flow control for above
    end

		def self.copy_to_lib
			start_here = copy_source
			puts "Copy From: #{start_here}"

			to = copy_dest
			puts "Copy To: #{to}"

			FileUtils.copy_entry start_here, to

			process_dependencies
		end

		def self.gemspec
			Nu::GemTools.spec_for(@gem_name)
		end

		def self.gem_available?
			Gem.available? @gem_name, @version
		end

    def self.copy_source
      Nu::GemTools.lib_for(@gem_name).gsub '{lib}','lib'
    end

    def self.copy_dest
      proj = Nu::Project.new

      #to be used in copying
      if proj.should_use_long_names?
        name = gemspec.full_name
      else
        name = gemspec.name
      end
      to = Dir.pwd + "/#{@location}/#{name}"
      if Dir[to] == [] #may need a smarter guy here
        FileUtils.mkpath to
      end
      to
    end

    def self.process_dependencies
      gemspec.dependencies.each do |d|
        if Gem.available? d.name
          puts "Loading dependency: #{d.name}"
          load d.name, @location, d.requirement
        else
          puts "#{d.name} is not installed locally"
          puts "please run 'gem install #{d.name}"
        end
      end
    end

  end
end
