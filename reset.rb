#!/usr/bin/ruby

def run command
  puts command
  puts `#{command}`
end

# reset life.rb
run "cp life.example life.rb"

