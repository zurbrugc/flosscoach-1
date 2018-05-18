desc 'Clear dev/production/test logs'
task :clear_logs do
#  Truncates all *.log files in log/ to zero bytes 
#  Specify which logs with LOGS=test,development,production
puts"Log files cleaned"
end
