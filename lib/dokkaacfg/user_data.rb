require 'open-uri'
require 'yaml'

module DokkaaCfg
  class UserData
    USER_DATA_PATH = File.join(File.expand_path("../../../", __FILE__), "user-data")

    def self.make_user_data
      yaml = YAML.load_file(USER_DATA_PATH)
      etcd_token = open('https://discovery.etcd.io/new').read
      yaml['coreos']['etcd']['discovery'] = etcd_token
      lines = YAML.dump(yaml).split("\n")
      lines[0] = '#cloud-config'
      lines.join("\n")
    end
  end
end
