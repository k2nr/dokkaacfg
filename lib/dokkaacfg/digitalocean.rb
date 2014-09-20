require 'barge'
require 'optparse'
require 'dokkaacfg/provider'
require 'dokkaacfg/user_data'

module DokkaaCfg
  class DigitalOcean < Provider
    DROPLET_NAME_PREFIX = 'dokkaa-'

    def initialize(access_token=nil)
      super()
      access_token ||= ENV["DIGITALOCEAN_ACCESS_TOKEN"]
      @client = Barge::Client.new(access_token: access_token)
    end

    def up(args, options_={})
      options = options_.clone
      options[:scale]  ||= 1
      options[:region] ||= 'sfo1'
      options[:slug]   ||= '512mb'
      ssh_keys = keys.map do |k|
        if k.name == options[:ssh_key]
          k.id
        end
      end.compact
      user_data = UserData.make_user_data

      (1..options[:scale]).each do |n|
        name = "#{DROPLET_NAME_PREFIX}#{n}"
        puts "launching #{name}"
        @client.droplet.create(
          name: name,
          region: options[:region],
          size: options[:slug],
          image: "coreos-alpha",
          ssh_keys: ssh_keys,
          private_networking: true,
          user_data: user_data
        )
      end
    end

    def scale(args, options=nil)
    end

    def down(args, options={})
      droplets = @client.droplet.all["droplets"]
      r = droplet_regexp
      droplets.each do |d|
        if r.match(d.name)
          @client.droplet.destroy(d.id)
        end
      end
    end

    private
    def droplet_regexp
      Regexp.new("^#{DROPLET_NAME_PREFIX}")
    end

    def dokkaa_droplets
      droplets = @client.droplet.all["droplets"]
      r = droplet_regexp
      droplets.filter{|d| d.name =~ r}
    end

    def keys
      @keys ||= @client.key.all["ssh_keys"]
    end
  end
end
