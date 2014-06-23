require 'file_transporter/s3'

describe FileTransporter::S3 do
  describe '#transport' do
  end

  describe '#bucket' do
    it 'returns a instance of AWS::S3::Bucket' do
      expect(FileTransporter::S3.bucket).to be_instance_of AWS::S3::Bucket
    end
  end

  describe '#object_key_name' do
    context 'when file path end with *.mov' do
      context 'file name includes year(YYYY)' do
        let(:file_path) { '/Users/takatoshi/Movies/iMovie Events.localized/2014-02-27/clip-2014-02-27 18;22;02.mov' }
        it 'returns like videos/YYYY/file_name.mov' do
          expect(FileTransporter::S3.object_key_name(file_path)).to match "videos/2014/#{File.basename(file_path)}"
        end
      end

      context 'file name donot includes year(yyyy)' do
        let(:file_path) { '/Users/takatoshi/Movies/yet_another_file.mov' }
        it 'returns nil' do
          expect(FileTransporter::S3.object_key_name(file_path)).to be_nil
        end
      end
    end

    context 'when file path donot end with *.mov' do
      let(:file_path) { '/Users/takatoshi/Movies/iMovie Events.localized/2014-02-27/sample.jpg' }
      it 'returns nil' do
        expect(FileTransporter::S3.object_key_name(file_path)).to be_nil
      end
    end
  end
end

