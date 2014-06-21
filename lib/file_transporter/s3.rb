module FileTransporter
  class S3
    class << self
      def transport(file_path)
      end

      def object_key_name(file_path)
        if file_path.end_with?('.mov')
          file_path.match(/(\d{4})-\d{2}-\d{2}/) do |m|
            "/videos/#{m[1]}/#{File.basename(file_path)}"
          end
        end
      end
    end
  end
end
