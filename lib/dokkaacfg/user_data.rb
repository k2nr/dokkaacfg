require 'open-uri'
require 'ostruct'
require 'erb'
require 'yaml'

module DokkaaCfg
  class UserData
    USER_DATA_PATH = File.join(File.expand_path("../../../", __FILE__), "user-data.erb")

    def self.make_user_data(vars={})
      data = File.read USER_DATA_PATH
      erb = ERB.new(data).result(OpenStruct.new(vars).instance_eval{ binding })
      yaml = YAML.load(erb)
      etcd_token = open('https://discovery.etcd.io/new').read
      yaml['coreos']['etcd']['discovery'] = etcd_token
      lines = YAML.dump(yaml).split("\n")
      lines[0] = '#cloud-config'
      lines.join("\n")
    end
  end
end
