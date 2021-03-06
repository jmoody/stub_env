module StubEnv
  module Helpers

    def stub_env key_or_hash, value=nil
      init_stub unless env_stubbed?
      if value
        add_stubbed_value key_or_hash, value
      else
        key_or_hash.each { |k,v| add_stubbed_value k,v }
      end
    end

    private

    def add_stubbed_value key, value
      allow(ENV).to receive(:[]).with(key).and_return(value) 
    end

    def env_stubbed?
      ENV.respond_to?(:stubbed?) && ENV.stubbed?
    end

    def init_stub
      allow(ENV).to receive(:stubbed?).and_return(true)
      allow(ENV).to receive(:[]).and_call_original
    end
    
  end
end