#!/usr/bin/env ruby

def createPlaceholder(dir, level = 0)
    dir = dir + '/' if(!dir.empty? && dir[-1].chr != '/')

    entries = Array.new
    entries = File.new("#{dir}menu.def").readlines if(FileTest.exists?("#{dir}menu.def"))

    rel = ''
    level.times {
        rel += '../'
    }

    entries.each { |x|
        entry = x.split(/\s*\|\s*/, 2)
        if(!FileTest.exists?(dir + entry[0] + '.html'))
            File.symlink("#{rel}placeholder.html", dir + entry[0] + '.html')
        end
        
        if(FileTest.directory?(dir + entry[0]))
            createPlaceholder(dir + entry[0], level + 1)
        end
    }
end

if(!ARGV[0])
    puts 'Need a directory'
end

createPlaceholder(ARGV[0], 0)

