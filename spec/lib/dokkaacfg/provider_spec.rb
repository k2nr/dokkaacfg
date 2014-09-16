require 'dokkaacfg/provider'

module DokkaaCfg
  class Dummy < Provider
    def up; end
    def down; end
  end

  describe Provider do
    let(:prov){ Dummy.new }

    describe "#execute" do
      it "call real methods if the provider has" do
        expect(prov).to receive(:up).once
        prov.execute("up", [], {})
        expect(prov).to receive(:down).once
        prov.execute("down", [], {})
      end

      it "do nothing if real method does not exist" do
        expect{prov.execute("aaa", [], {})}.to_not raise_error
      end
    end
  end
end
