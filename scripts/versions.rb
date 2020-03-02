require 'json'
require 'open-uri'

VERSIONS_FILE_URL = "https://raw.githubusercontent.com/DmitryAstafyev/chipmunk.plugins.store/master/versions.json";

class Versions

    def initialize()
        puts "Reading versions file from \"#{VERSIONS_FILE_URL}\""
        @versions_str = open(VERSIONS_FILE_URL) { |f| f.read }
        @versions = JSON.parse(@versions_str)
        puts "Next versions of frameworks/modules will be used:\n"
        puts "\telectron: #{@versions['electron']}\n"
        puts "\telectron-rebuild: #{@versions['electron-rebuild']}\n"
        puts "\tchipmunk.client.toolkit: #{@versions['chipmunk.client.toolkit']}\n"
        puts "\tchipmunk.plugin.ipc: #{@versions['chipmunk.plugin.ipc']}\n"
        puts "\tchipmunk-client-material: #{@versions['chipmunk-client-material']}\n"
        puts "\tangular-core: #{@versions['angular-core']}\n"
        puts "\tangular-material: #{@versions['angular-material']}\n"
    end

    def get
        return @versions
    end

    def get_hash
        p = [
            @versions['electron'].split("."),
            @versions['electron-rebuild'].split("."),
            @versions['chipmunk.client.toolkit'].split("."),
            @versions['chipmunk.plugin.ipc'].split("."),
            @versions['chipmunk-client-material'].split("."),
            @versions['angular-core'].split("."),
            @versions['angular-material'].split(".")
        ];
        hash = '';
        for i in 0..2 do
            if hash != ""
                hash = "#{hash}."
            end
            for x in p do
                hash = "#{hash}#{x[i]}"
            end
        end
        return hash
    end

end
