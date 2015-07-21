#!/usr/bin/env ruby

# Hash of file_name => access_time
hamls = Dir.glob('**/*.haml').map {|x| [ x, File.mtime(x) ]  }.to_h

print "updating all files... "

hamls.keys.each do |haml_file|
  html_file = haml_file.gsub(/\.haml$/,'.html')
  print `haml #{haml_file} > _public/#{html_file} `
end

puts "done\n\n"

while 1 do
  new_hamls = Dir.glob('**/*.haml').map {|x| [ x, File.mtime(x) ]  }.to_h

  new_hamls.keys.each do |haml_file|
    if new_hamls[haml_file] != hamls[haml_file]
      puts "updating #{haml_file}"

      html_file = haml_file.gsub(/\.haml$/,'.html')
      print `haml #{haml_file} > _public/#{html_file} `
    end      
  end

  hamls = new_hamls
  sleep 0.5
end

