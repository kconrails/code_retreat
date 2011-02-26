#!/usr/bin/ruby

def run command
  puts command
  puts `#{command}`
end

# require ruby version as a parameter. otherwise, print usage
ruby_version = `rvm-prompt`.chomp

if ruby_version == ''
  puts <<USAGE
  You need to be in rvm first, then re-run this command.
USAGE

  exit 0
else
  ruby_version = ruby_version.split(/@/).first
end

# gemset command string
gemset_command = "rvm use #{ruby_version}@code_retreat"

# setup gemset
run "rvm use #{ruby_version} && rvm gemset create code_retreat && #{gemset_command}"

# automatically use this gemset when we enter this directory
File.open('.rvmrc', 'w'){|f| f.write gemset_command}

# download the required gems
['dust', 'redgreen', 'ruby-fsevent', 'watchr'].each do |gem_name|
  run "gem install #{gem_name} --no-rdoc --no-ri"
end

# reset life.rb
run "cp life.example life.rb"

# try to get screencapture app
screencapture = `whereis screencapture`.chomp
screencapture_message = ""
unless screencapture == ""
  File.open('.screencapture', 'w'){|f| f.write screencapture}
  system "mkdir screencaptures"
  
  screencapture_message = "Every save will take a snapshot of your progress,\n  which you can find in the screencaptures directory!\n"
end

# print instructions
puts <<INSTRUCTIONS
--------------------
  Great!  Now run watcher like so:

      watchr life.watchr
    
  And start adding your code to life.rb in your favorite editor.
  Your tests will run automatically every time you save the file.

  #{screencapture_message}
  Enjoy :)
--------------------
INSTRUCTIONS