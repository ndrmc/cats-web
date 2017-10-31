#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

# conn = Bunny.new(:automatically_recover => false)
conn = Bunny.new(:host => "192.168.69.123", :user => "cats", :password => "cats")
conn.start

ch   = conn.create_channel
q    = ch.queue("Hello")

begin
  puts " [*] Waiting for messages. To exit press CTRL+C"
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"
  end
rescue Interrupt => _
  conn.close

  exit(0)
end