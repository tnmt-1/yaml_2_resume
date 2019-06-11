require 'securerandom'

require './lib/cv_maker'
require './lib/txt2yaml'
require './lib/util'

include Util

describe "CVMaker" do
  before do
    @converter = TXT2YAMLConverter.new
    @date = Date.today
    @file_name = "_spec_#{SecureRandom.hex(8)}.pdf"
  end

  after do
    begin
      File.delete(@file_name)
    rescue
      p $!
    end
  end

  it "should create normal resume pdf" do
    data = YAML.load(load_as_erb('templates/data.yaml'))
    style = @converter.load_file('templates/style.txt')
    doc = CVMaker.new.generate(data, style)
    expect(doc).to be_truthy
    doc.render_file @file_name
    expect(File.exists?(@file_name)).to be_truthy
  end

  it "should create academic resume pdf" do
    data = YAML.load(load_as_erb('templates/academic.yaml'))
    style = @converter.load_file('templates/academic.txt')
    doc = CVMaker.new.generate(data, style)
    expect(doc).to be_truthy
    doc.render_file @file_name
    expect(File.exists?(@file_name)).to be_truthy
  end

end
