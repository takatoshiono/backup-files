require 'dotenv'

$LOAD_PATH << './lib'

require 'file_transporter/s3'

desc 'Backup iMovie Events'
namespace :backup do
  task :imovie do
    # TODO: 実装する
    puts 'backup imovie event files to amazon s3'
    # dummy
    Dotenv.load
    FileTransporter::S3.transport('/Users/takatoshi/Movies/iMovie Events.localized/2014-02-27/clip-2014-02-27 18;22;02.mov')
  end
end
