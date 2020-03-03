# frozen_string_literal: true

require './scripts/register'
require './scripts/plugin'
require './scripts/versions'
require './scripts/tools'

PLUGINS_DEST_FOLDER = './plugins'
PLUGIN_RELEASE_FOLDER = './releases'

task :build, [:target] do |_t, args|
  if args.target.nil?
    putsAccent('Please define target to be built like: "rake build[./plugins/plugin.complex]"', true)
  end
  versions = Versions.new
  plugin = Plugin.new(args.target, versions)
  if plugin.build
    puts "Plugin #{plugin.get_plugin_name} is built SUCCESSFULLY"
  else
    success = false
    puts "Fail to build plugin #{plugin.get_plugin_name}"
  end
  # ...
  puts "Traget is: #{args.target}"
end
