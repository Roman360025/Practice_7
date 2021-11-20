#!/usr/bin/env tarantool


box.cfg {listen = 3301}
box.schema.user.passwd('pass')

-- Queue out
test1 = box.schema.space.create('test1')
test1:create_index('id')

-- Load Tarantool mqtt
mqtt = require('mqtt')

yaml = require('yaml')

-- Create instance
connection = mqtt.new("client_id15623445", true)

connection:login_set('Hans', 'Test')

-- Connect to the server
connection:connect({host='194.67.112.161', port=1883})

-- Set callback for recv new messages
connection:on_message(function (message_id, topic, payload, gos, retain)
  -- print('New message', message_id, topic, payload, gos, retain)
  test1:auto_increment{yaml.decode(payload)}
end)


-- Subscribe to a system topic
connection:subscribe('v6')

-- Get all data from space
print(test1:select{})

