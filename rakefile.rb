require './src/register'
require './src/plugin'
require './src/versions'
require './src/tools'

PLUGINS_DEST_FOLDER = "./plugins";
PLUGIN_RELEASE_FOLDER = "./releases"

task :build3 do
    success = true
    register = Register.new()
    versions = Versions.new()
    loop do
        plugin_info = register.next()
        if plugin_info == nil
            break
        end
        plugin = Plugin.new(plugin_info['name'], plugin_info['repo'], PLUGINS_DEST_FOLDER, plugin_info['version'], versions.get(), versions.get_hash())
        if plugin.build()
            puts "Plugin #{plugin_info['name']} is built SUCCESSFULLY"
        else
            success = false
            puts "Fail to build plugin #{plugin_info['name']}"
        end
    end
end

task :build, [:target] do |t, args|
    if args.target == nil
        putsAccent("Please define target to be built like: \"rake build[./plugins/plugin.complex]\"", true)
    end
    versions = Versions.new()
    plugin = Plugin.new(args.target, versions.get())
    if plugin.build()
        puts "Plugin #{plugin.get_name()} is built SUCCESSFULLY"
    else
        success = false
        puts "Fail to build plugin #{plugin.get_name()}"
    end
    # ...
    puts "Traget is: #{args.target}"
end



task :test do
    puts File.basename('/d/t')
end