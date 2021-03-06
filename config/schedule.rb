# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
every :day, at: '1am' do
  # specify the task name as a string
  rake 'scheduler:feeds'
end

every :day, at: '10pm' do
  # specify the task name as a string
  rake 'mostviewedyt:mostviewedalltime'
end

every :day, at: '2am' do
	rake 'mostviewedyt:mostviewedtoday'
end

every :day, at: '7am' do
	rake 'mostviewedyt:mostviewedtoday'
end

every :day, at: '12pm' do
	rake 'mostviewedyt:mostviewedtoday'
end

every :day, at: '8pm' do
	rake 'mostviewedyt:mostviewedtoday'
end
# Learn more: http://github.com/javan/whenever
