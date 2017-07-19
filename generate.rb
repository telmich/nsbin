#!/usr/bin/env ruby

require 'misen/style-sgml'
require 'misen/util'

require 'getoptlong'
require 'fileutils'
require 'digest/sha1'

@version  = '0.2'
@verbose  = 0
@force    = false
@outpath  = "#{Dir.pwd}/generated"
@inpath   = "#{Dir.pwd}/source"
@template = "#{Dir.pwd}/templates"
@default  = 'default.html'

@datadir  = "#{Dir.pwd}/data"
@filehash = Hash.new

def printMsg(prefix, msg, descriptor = $stdout)
    descriptor.puts '%-12s %s' % [prefix + ':', msg]
end

def panic(msg)
    printMsg('PANIC', msg, $stderr)
    Kernel.exit(-1)
end

def error(msg)
    printMsg('ERROR', msg, $stderr)
end

def warn(msg)
    printMsg('WARNING', msg)
end

def info(msg)
    printMsg('INFO', msg)
end

def debug(msg, verbosity = 1)
    if(@verbose >= verbosity)
        printMsg("DEBUG(#{verbosity})", msg, $stderr)
    end
end

def generateMenu(dir, file = nil, level = 0)
    debug("call generateMenu('#{dir}', '#{file}', #{level})")
    template = '<ul<misen:class />>
                    <misen:menuentries>
                    <li><a href="<misen:url />"<misen:class />><misen:desc /></a><misen:menu /></li>
                    </misen:menuentries>
                </ul>'

    dir = dir + '/' if(!dir.empty? && dir[-1].chr != '/')
    menu = File.new("#{dir}menu.def").readlines

    data = Hash.new
    menuentries = Array.new

    menu.each { |x|
        entry = x.split(/\s*\|\s*/, 2)
        e = Hash.new
        e[:class] = (file && dir + entry[0] == file ? ' class="active"' : '')
        if(file && dir + entry[0] == file)
            e[:class] = data[:class] = ' class="active"'
        end
        e[:url]   = "/#{dir}#{entry[0]}" # TODO: make relative paths
        e[:desc]  = entry[1].strip
        if(FileTest.directory?("#{dir}#{entry[0]}") && FileTest.exists?("#{dir}#{entry[0]}/menu.def"))
            e[:menu] = generateMenu("#{dir}#{entry[0]}", file, level + 1)
        end
        menuentries << e
    }

    return '' if(menuentries.empty?)

    data[:menuentries] = menuentries

    return removeEmptyLine(Misen.expand_text(Misen::STYLE_SGML, template, data))

end

def generateFiles(dir = '')
    debug("call generateFiles('#{dir}')")
    dir = dir + '/' if(!dir.empty? && dir[-1].chr != '/')
    Dir.foreach(dir.empty? ? '.' : dir) { |x|
        next if(x =~ /^(\.|\.\.)$/)
        
        if(x =~ /\.html$/)
            if(!FileTest.exists?(@outpath + '/' + dir + x) || @filehash[dir + x] != Digest::SHA1.hexdigest(File.new(dir + x).read) || @force)
                info("Transforming #{dir}#{x}")
                data = {:style => getStylePath(dir) + 'style.css', :content => File.new("#{dir}#{x}").read, :menu => generateMenu('', dir + File.basename(x, '.html'))}
                Dir.mkdir("#{@outpath}/#{dir}") if(!FileTest.exists?("#{@outpath}/#{dir}"))
                File.open("#{@outpath}/#{dir}#{x}", "w") { |file|
                    file.print removeEmptyLine(Misen.expand_text(Misen::STYLE_SGML_EX, @source, data))
                }
                @filehash[dir + x] = Digest::SHA1.hexdigest(File.new(dir + x).read)
            else
                info("Nothing to do for #{dir}#{x}")
            end
        elsif(FileTest.directory?(dir + x))
            begin
                Dir.mkdir("#{@outpath}/#{dir}#{x}") if(!FileTest.exists?("#{@outpath}/#{dir}#{x}"))
            rescue
                panic("Could not create #{@outpath}/#{dir}#{x}: #{$!}")
            end
            generateFiles("#{dir}#{x}")
        elsif(x !~ /(\.def|\.swp)$/)
            if(!FileTest.exists?(@outpath + '/' + dir + x) || @filehash[dir + x] != Digest::SHA1.hexdigest(File.new(dir + x).read) || @force)
                info("Copying file #{dir}#{x}")
                FileUtils.cp(dir + x, @outpath + '/' + dir + x)
                @filehash[dir + x] = Digest::SHA1.hexdigest(File.new(dir + x).read)
            else
                info("No need to copy #{dir}#{x}. Already latest.")
            end
        end
    }
end

def removeEmptyLine(str)
    str.split($/).collect{ |x| x =~ /^\s*$/ ? nil : x}.compact.join($/)
end

def getPath(path)
    return path if(path[0].chr == '/')
    return "#{Dir.pwd}/#{path}"
end

def getStylePath(dir)
    newdir = ''

    dir.split('/').each {
        newdir += '../'
    }

    return newdir
end

def usage
    info("Usage: #{File.basename(__FILE__)} [options]")
    info('')
    info('%20s    %s' % ['--verbose, -v',  'Verbose output. Add v for more verbose output'])
    info('%20s    %s' % ['--inpath, -i',   'Specify where to search for input files [./source]'])
    info('%20s    %s' % ['--outpath, -o',  'Specify where to write the output files [./generated]'])
    info('%20s    %s' % ['--template, -t', 'Specify where to search for template files [./templates]'])
    info('%20s    %s' % ['--default, -d',  'The default template name [default.html]'])
    info('%20s    %s' % ['--force, -f',    'Force the new generating of all files [false]'])
    info('%20s    %s' % ['--help, -h',     'Print this screen'])
    info('%20s    %s' % ['--version, -V',  'Print the version and exit'])
end

puts "This is #{File.basename(__FILE__)} v#{@version} 2005 by René Nussbaumer"
puts 

opts = GetoptLong.new(
    ['--verbose',  '-v', GetoptLong::OPTIONAL_ARGUMENT],
    ['--inpath',   '-i', GetoptLong::REQUIRED_ARGUMENT],
    ['--outpath',  '-o', GetoptLong::REQUIRED_ARGUMENT],
    ['--template', '-t', GetoptLong::REQUIRED_ARGUMENT],
    ['--default',  '-d', GetoptLong::REQUIRED_ARGUMENT],
    ['--force',    '-f', GetoptLong::NO_ARGUMENT],
    ['--help',     '-h', GetoptLong::NO_ARGUMENT],
    ['--version',  '-V', GetoptLong::NO_ARGUMENT]
)

opts.each { |arg,value|
    case arg
    when '--verbose'
        @verbose += 1
        value.each_byte { |x|
            if(x.chr == 'v')
                @verbose += 1
            end
        }
        debug("Verbosity set to: #{@verbose}")
    when '--inpath'
        @inpath = getPath(value)
    when '--outpath'
        @outpath = getPath(value)
    when '--template'
        @template = getPath(value)
    when '--default'
        @default = value
    when '--force'
        @force = true
    when '--help'
        usage
        Kernel.exit(0)
    when '--version'
        Kernel.exit(0)
    else
        warn("Unknown option #{arg}#{value && !value.empty? ? ('with value ' + value) : ''}")
    end
}

debug("Current configuration:")
debug('%-10s %s' % ['Inpath:',   @inpath])
debug('%-10s %s' % ['Outpath:',  @outpath])
debug('%-10s %s' % ['Template:', @template])
debug('%-10s %s' % ['Default:',  @default])

begin
    Dir.mkdir(@inpath)   if(!FileTest.directory?(@inpath))
    Dir.mkdir(@outpath)  if(!FileTest.directory?(@outpath))
    Dir.mkdir(@template) if(!FileTest.directory?(@template))
    Dir.mkdir(@datadir)  if(!FileTest.directory?(@datadir))
rescue
    panic("Could not create directory: #{$!}")
end

panic("#{@template}/#{@default} does not exist! Please create at least the default template.") if(!FileTest.exists?("#{@template}/#{@default}"))

@source = File.new("#{@template}/#{@default}").read

Dir.chdir(@inpath)
panic("Init directory needs a menu.def!") if(!FileTest.exists?('menu.def'))

@filehash = Marshal.load(File.new(@datadir + '/digest').read) if(FileTest.exists?(@datadir + '/digest'))
generateFiles
File.open(@datadir + '/digest', 'w') { |file|
    file.print Marshal.dump(@filehash)
}
