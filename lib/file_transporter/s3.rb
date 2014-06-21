require 'aws-sdk'
require 'pathname'

module FileTransporter
  class S3
    class << self
      def transport(file_path)
        if object_key_name(file_path)
          puts "object: #{object_key_name(file_path)}"
          bucket.objects[object_key_name(file_path)].write(Pathname.new(file_path))
        else
          raise "Unkown file format: #{file_path}"
        end
      end

      def bucket
        AWS.s3.buckets[ENV['AWS_BUCKET_NAME']]
      end

      def object_key_name(file_path)
        if file_path.end_with?('.mov')
          file_path.match(/(\d{4})-\d{2}-\d{2}/) do |m|
            "videos/#{m[1]}/#{File.basename(file_path)}"
          end
        end
      end
    end
  end
end
