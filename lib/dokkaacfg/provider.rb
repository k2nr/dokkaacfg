
module DokkaaCfg
  class Provider
    def initialize
    end

    def execute(cmd, args, options)
      cmd = cmd.to_sym
      if self.respond_to?(cmd)
        self.send(cmd, args, options)
      end
    end
  end
end
