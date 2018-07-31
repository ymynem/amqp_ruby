#sneakers_app.rb

require 'sneakers' # don't forget to put gem "sneakers" in your Gemfile
require 'sneakers/runner'

class Processor
  include Sneakers::Worker
  from_queue :default_queue
  def work(msg)
    puts "Msg received: " + msg
  end
end

opts = {
  :amqp => 'CLOUDAMQP_URL', # Replace the string with your AMQP url that you can find on CloudAMQP console page
  :vhost => 'username', # Replace with the vhost/username 
  :exchange => 'sneakers',
  :exchange_type => :direct
}

Sneakers.configure(opts)
r = Sneakers::Runner.new([Processor])
r.run
