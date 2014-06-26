require 'dotenv/tasks'

$LOAD_PATH << './lib'

require 'file_transporter/s3'

desc 'Backup iMovie Events'
namespace :backup do
  task :imovie => :dotenv do
    # TODO: 実装する
    puts 'backup imovie event files to amazon s3'
    # dummy
    FileTransporter::S3.transport('/Users/takatoshi/Movies/iMovie Events.localized/2014-02-27/clip-2014-02-27 18;22;02.mov')
  end
end
