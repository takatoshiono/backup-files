require 'file_transporter/s3'
require 'vcr'
require 'dotenv'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('./spec/fixtures/vcr_cassettes')
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.around(:each) do |example|
    VCR.use_cassette(example.metadata[:full_description]) do
      example.run
    end
  end
end

Dotenv.load

describe FileTransporter::S3 do
  describe '#transport' do
    let(:file_path) { File.expand_path('../../../files/2014-06-24/clip-2014-06-24 00:16;00;00.mov', __FILE__) }
    let(:content) { File.read(file_path) }

    it 'uploads a file to Amazon S3' do
      FileTransporter::S3.transport(file_path)
      object_key_name = FileTransporter::S3.object_key_name(file_path)
      expect(FileTransporter::S3.bucket.objects[object_key_name].read).to eq content
    end
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

