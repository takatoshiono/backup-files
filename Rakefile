require 'dotenv/tasks'

$LOAD_PATH << './lib'

require 'file_transporter/s3'

desc 'Backup iMovie Events'
namespace :backup do
  task :imovie => :dotenv do |task_name|
    puts 'backup imovie event files to amazon s4'

    dir = ENV['DIR']

    unless dir
      puts "Usage: rake #{task_name} DIR=/path/to/imovie-events-dir"
      exit
    end

    Dir.glob("#{File.absolute_path(dir)}/*.mov") do |filepath|
      puts filepath
      FileTransporter::S3.transport(filepath)
    end
  end
end
