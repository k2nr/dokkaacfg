require 'thor'
require 'dokkaacfg/digitalocean'

module DokkaaCfg
  class DigitalOceanCli < Thor
    desc "up", ""
    option :scale,   type: :numeric, default: 1
    option :region,  type: :string,  default: 'sfo1'
    option :slug,    type: :string,  default: '512mb'
    option :ssh_key, type: :string,  required: true
    def up
      dio = DigitalOcean.new
      dio.execute("up", nil, options)
    end

    desc "down", ""
    def down
      dio = DigitalOcean.new
      dio.execute("down", nil, options)
    end
  end

  class Cli < Thor
    desc "digitalocean SUBCOMMAND ...ARGS", ""
    subcommand "digitalocean", DigitalOceanCli
  end
end
