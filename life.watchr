# get screencapture command, if available
screencapture = File.exists?('.screencapture') ?
  File.open('.screencapture', 'r'){|f| f.read} :
  nil

watch('life.rb') do |md|
  system './life.rb'
  
  if screencapture
    timestamp = Time.now.to_s.split(/\s+/)[1].gsub(/:/, '')
    system "#{screencapture} -x screencaptures/#{timestamp}.png"
  end
end