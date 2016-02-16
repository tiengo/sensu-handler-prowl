#!/usr/bin/env ruby
#
# Sensu Handler: prowl
#
# This handler script is used to send notifications to Prowl application.
#
# Note: The default prowl config is fetched from the predefined json config file which is "prowl.json" or any other
#       file defiend using the "json_config" command line option. The apikey could also be configured on a per client basis
#       by defining the "prowl_apikey" attribute in the client config file. This will override the default prowl apikey where the
#       alerts are being routed to for that particular client.

require 'sensu-handler'
require 'prowl'
require 'timeout'

class ProwlSensu < Sensu::Handler
  option :json_config,
         description: 'Config Name',
         short: '-j JsonConfig',
         long: '--json_config JsonConfig',
         required: false

  def event_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def handle
    json_config = config[:json_config] || 'prowl'
    apikey = @event['client']['prowl_apikey'] || @event['check']['prowl_apikey'] || settings[json_config]['apikey']
    application = settings[json_config]['application'] || 'SENSU'

    prowl_message = Prowl.new(apikey: apikey, application: application)
    message = @event['check']['notification'] || @event['check']['output']

    begin
      timeout(15) do
        if @event['action'].eql?('resolve')
          prowl_message.add(:event => "RESOLVED - [#{event_name}]", :description => "#{message}.")
        else
          prowl_message.add(:event => "ALERT - [#{event_name}]", :description => "#{message}.")
        end
      end
    rescue Timeout::Error
      puts "prowl -- timed out while attempting to message #{apikey}"
    end
  end
end
