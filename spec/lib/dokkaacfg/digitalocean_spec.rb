require 'dokkaacfg/digitalocean'
require 'ostruct'

module DokkaaCfg
  describe DigitalOcean do
    let(:dio) { DigitalOcean.new("abcdefg") }
    describe "#up" do
      let(:ssh_key) { "k2nr" }
      before do
        @client = dio.instance_variable_get(:@client)
        allow(@client).to receive_message_chain(:key, :all)
                           .and_return({"ssh_keys" => [OpenStruct.new(name: ssh_key, id: "id")]})
        allow(UserData).to receive(:make_user_data).and_return("user data")
      end

      it do
        expect(@client).to receive_message_chain(:droplet, :create).with({
          name: 'dokkaa-1',
          region: 'sfo1',
          size: '512mb',
          image: 'coreos-alpha',
          ssh_keys: ["id"],
          private_networking: true,
          user_data: 'user data'
        })
        dio.up([], {ssh_key: ssh_key})
      end
    end

    describe "#down" do
      before do
        prefix = DigitalOcean::DROPLET_NAME_PREFIX
        @client = dio.instance_variable_get(:@client)
        allow(@client).to receive_message_chain(:droplet, :all)
                           .and_return({"droplets" => [OpenStruct.new(id: "id1",
                                                                      name: "#{prefix}name1"),
                                                       OpenStruct.new(id: "id2",
                                                                      name: "name2")]})
      end

      it do
        expect(@client).to receive_message_chain(:droplet, :destroy).with("id1")
        dio.down([])
      end
    end
  end
end
