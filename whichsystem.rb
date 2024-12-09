#!/usr/bin/env ruby
# encoding: utf-8
#
# Usage: ruby whichSystem.rb <ip-address>

if ARGV.length != 1
  puts "\n[!] Usage: ruby #{__FILE__} <ip-address>\n"
  exit(1)
end

def get_ttl(ip_address)
  ping_result = `ping -c 1 #{ip_address}`
  ttl_line = ping_result.split("\n").find { |line| line.include?("ttl=") }
  return nil unless ttl_line

  ttl_value = ttl_line.match(/ttl=(\d+)/)[1]
  ttl_value.to_i
end

def get_os(ttl)
  case ttl
  when 0..64 then "Linux"
  when 65..128 then "Windows"
  else "Not Found"
  end
end

ip_address = ARGV[0]

ttl = get_ttl(ip_address)
if ttl
  os_name = get_os(ttl)
  puts "#{ip_address} (ttl -> #{ttl}): #{os_name}"
else
  puts "Could not retrieve TTL for #{ip_address}"
end

