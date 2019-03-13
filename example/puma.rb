workers 2
ssl_bind '0.0.0.0', ENV['PORT'], { key: "../localhost.business.com.key", cert: "../localhost.business.com.crt" }

require 'diplomat'

svc_port = ENV['PORT'].to_i


begin
  # TODO Ideally this would run once after all workers are forked, but Puma seems to have no option for that.
  Diplomat.configure { |config|
    svc_port = ENV['PORT'].to_i
    raise "CONSUL_URL env var not defined" unless config.url = ENV['CONSUL_URL']
    Diplomat::Node.register(
      {
        :Node => "localhost.business.com",
        :Address => "host.docker.internal",
        :Service => {
          :Service => "sso",
          :Port => svc_port,
          :Address => "host.docker.internal",
          :Checks => [
            {
              "CheckID": "sso-ui-https",
              "ServiceID": "sso",
              "Definition": {
                "HTTP": "https://host.docker.internal:#{svc_port}/health",
                "Method": "GET",
                "Interval": "10s"
              }
            }
          ]
        }
      }
    )
    STDERR.puts "Configured consul at #{config.url} with options #{config.options}"
  }
rescue Exception => e
  STDERR.puts "Continuing without Consul connection endpoint because " + e.message
end
