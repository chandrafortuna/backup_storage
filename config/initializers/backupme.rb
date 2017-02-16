home = "#{Dir.home}/backup_me"
tmp = "#{Dir.home}/backup_me/tmp"
destination = "#{Dir.home}/backup_me/destination"
Dir.mkdir(home) unless File.exists?(home)
Dir.mkdir(tmp) unless File.exists?(tmp)
Dir.mkdir(destination) unless File.exists?(destination)