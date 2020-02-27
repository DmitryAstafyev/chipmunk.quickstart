require 'json'
require 'fileutils'
require './src/plugin.backend'
require './src/plugin.frontend'
require './src/tools'

class Plugin

    def initialize(path, versions)  
        @name = File.basename(path)
        @path = path
        @versions = versions
    end

    def build
        backend = PluginBackend.new(@path, @versions)
        if !backend.exist() 
            puts "Plugin \"#{@name}\" doesn't have backend"
        else
            if !backend.valid()
                puts "Fail to build plugin \"#{@name}\" because backend isn't valid"
                return nil
            end
            if backend.install()
                puts "Install backend of \"#{@name}\": SUCCESS"
            else
                puts "Install backend of \"#{@name}\": FAIL"
            end
        end
        frontend = PluginFrontend.new(@path, @versions)
        if !frontend.exist()
            puts "Plugin \"#{@name}\" doesn't have frontend"
        else
            if !frontend.valid()
                puts "Fail to build plugin \"#{@name}\" because frontend isn't valid"
                return nil
            end
            if frontend.install()
                puts "Install frontend of \"#{@name}\": SUCCESS"
            else
                puts "Install frontend of \"#{@name}\": FAIL"
            end
        end
        if backend.get_state() == nil || frontend.get_state() == nil 
            puts "Fail to build plugin \"#{@name}\" because backend or frontend weren't installed correctly"
            return false
        end
        if backend.get_state() && !frontend.get_state()
            puts "Fail to build plugin \"#{@name}\" because plugin has only backend"
            return false
        end
        if !File.directory?(PLUGIN_RELEASE_FOLDER)
            Rake.mkdir_p(PLUGIN_RELEASE_FOLDER, verbose: true)
            puts "Creating release folder: #{PLUGIN_RELEASE_FOLDER}"
        end
        dest = "#{PLUGIN_RELEASE_FOLDER}/#{@name}"
        if !File.directory?(dest)
            Rake.mkdir_p(dest, verbose: true)
            puts "Creating plugin release folder: #{dest}"
        end
        if backend.get_state()
            copy_dist(backend.get_path(), "#{dest}/process")
        end
        if frontend.get_state()
            copy_dist(frontend.get_path(), "#{dest}/render")
        end
        return true
    end

    def get_name 
        return @name
    end

end