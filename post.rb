require "rubygems"
require "gcal4ruby"
require "hipchat-api"

hipchat = HipChat::API.new(ENV['HIPCHAT_API_KEY'])
serv = GCal4Ruby::Service.new
serv.authenticate ENV['GCAL_USERNAME'], ENV['GCAL_PASSWORD']
today = Time.now

def write_event(event, hipchat)
  str = "'" + event.title + "': "
  if event.content != "" and event.content != nil
    str = str + "'" + event.content.to_s + "'"
  end
  if event.where != "" and event.where != nil
    str = str + " in: " + "'" + event.where + "'"
  end
  if event.start_time != "" and event.start_time != nil
    str = str + " start: " + "'" + event.start_time.to_s + "'"
  end
  if event.end_time != "" and event.end_time != nil
    str = str + " end: " + "'" + event.end_time.to_s + "'"
  end
  hipchat.rooms_message(ENV['HIPCHAT_ROOM_NUMBER'], ENV['HIPCHAT_BOT_ALIAS'], str, notify = 0, color = ENV['HIPCHAT_MSG_COLOR'], message_format = 'html')
end

if today.wday == 1
  start_date = Time.parse(today.day.to_s + "/" + today.month.to_s + "/" + today.year.to_s)
  events = GCal4Ruby::Event.find(serv, "", 'start-min' => start_date.utc.xmlschema, 'start-max' => (start_date + 3600*24*7).utc.xmlschema)
  if events.count > 0
      header = "Events for this week: "
    hipchat.rooms_message(ENV['HIPCHAT_ROOM_NUMBER'], ENV['HIPCHAT_BOT_ALIAS'], header, notify = 0, color = ENV['HIPCHAT_MSG_COLOR'], message_format = 'html')
    events.each do |event|
      write_event(event, hipchat)
    end
  else
    str = "There are no significant events this week."
    hipchat.rooms_message(ENV['HIPCHAT_ROOM_NUMBER'], ENV['HIPCHAT_BOT_ALIAS'], str, notify = 0, color = ENV['HIPCHAT_MSG_COLOR'], message_format = 'html')
  end
else
  start_date = Time.parse(today.day.to_s + "/" + today.month.to_s + "/" + today.year.to_s)
  events = GCal4Ruby::Event.find(serv, "", 'start-min' => start_date.utc.xmlschema, 'start-max' => (start_date + 3600*24).utc.xmlschema)
  if events.count > 0
    header = "Events for this day: "
    hipchat.rooms_message(ENV['HIPCHAT_ROOM_NUMBER'], ENV['HIPCHAT_BOT_ALIAS'], header, notify = 0, color = ENV['HIPCHAT_MSG_COLOR'], message_format = 'html')
    events.each do |event|
      write_event(event, hipchat)
    end
  else
    str = "There are no significant events today."
    hipchat.rooms_message(ENV['HIPCHAT_ROOM_NUMBER'], ENV['HIPCHAT_BOT_ALIAS'], str, notify = 0, color = ENV['HIPCHAT_MSG_COLOR'], message_format = 'html')
  end
end
