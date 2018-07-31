require "bunny"
require "dotenv/load"

connection = Bunny.new ENV['CLOUDAMQP_URL']
connection.start # Start a communication session with the amqp server
channel = connection.create_channel # Declare a channel
queue = channel.queue("bunny_queue") # Declare a queue

# Declare a default direct exchange which is bound to all queues
exchange = channel.exchange("")

# Publish a message to the exchange which then gets routed to the queue
exchange.publish("Hello everybody!", :key => queue.name)
connection.close # Finally, close the connection