require "bunny"
require 'dotenv/load'

connection = Bunny.new ENV['CLOUDAMQP_URL']
connection.start
channel = connection.create_channel
queue = channel.queue("bunny_queue")

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Consumed the message: #{body}"
  end
rescue Interrupt => _
  connection.close
  exit(0)
end