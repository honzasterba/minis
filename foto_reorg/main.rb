def is_event(month)
  month.match /\s/
end

def has_files(month)
  `ls -1 '#{month}'`.split(/\n/).collect do |subdir|
    subdir_path = "#{month}/#{subdir}"
    if File.file?(subdir_path)
      return true
    end
  end
  false
end

def subdir_target(month, subdir)
  if subdir.match /^#{month}.*/
    subdir
  else
    "#{month} #{subdir}"
  end
end

def move_subdirs(month)
  `ls -1 '#{month}'`.split(/\n/).collect do |subdir|
    subdir_path = "#{month}/#{subdir}"
    if File.directory?(subdir_path)
      "mv '#{subdir_path}' '#{subdir_target(month, subdir)}'"
    else
      nil
    end
  end
end

def remove_month_if_no_files(month)
  if has_files(month)
    []
  else
    ["rmdir '#{month}'"]
  end
end

months = `ls -1`.split(/\n/)

commands = months.collect do |month|
  if is_event(month)
    # do nothing
  else
    move_subdirs(month) + remove_month_if_no_files(month)
  end
end

commands.flatten.reject { |a| a.nil? || a == "" }.each do |c|
  puts c
end