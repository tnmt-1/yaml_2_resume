# require File.expand_path '../spec_helper.rb', __FILE__
require './app.rb'
require './lib/util'
include Util

describe "Sinatra Application" do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should receive form-data" do
    @date = Date.today
    data = {
      data_yml: load_as_erb("templates/data.yaml"),
      style_txt: load_as_erb("templates/style.txt"),
    }
    post '/create', data
    expect(last_response).to be_ok
  end

  it "should raise error" do
    data = {}
    post '/create', data
    expect(last_response).not_to be_ok
  end
end
