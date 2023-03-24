#!/usr/bin/env ruby

require 'erb'

def die(err=nil, ecode=nil)
  name = File.basename($0)
  puts "Usage: #{name} <README.md.erb>"
  if err
    ecode ||= 1
    puts "\nERROR: #{err}"
  else
    ecode ||= 0
  end
  exit ecode
end

def which(path)
  return path if path.start_with?("./")
  cands = [".", *ENV['PATH'].split(':')]
  cands.each do |dir|
    fpath = File.join(dir, path)
    return fpath if File.exist?(fpath)
  end
  return nil
end

def usage_for(ipath)
  path = which(ipath)
  unless path
    raise "ERROR: cannot file #{ipath}"
  end
  `#{path} --help`
end

#--- main

ipath = ARGV[0]
unless ipath
  ipath = "./README.md.erb"
end

unless File.exist?(ipath)
  die("No such file at: #{ipath}")
end

template = ERB.new(IO.read(ipath))
puts template.result(binding)
