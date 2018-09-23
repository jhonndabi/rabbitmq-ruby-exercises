#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(hostname: '172.17.0.2', automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

queue.publish(message, persistent: true)
puts " [x] Sent #{message}"

connection.close