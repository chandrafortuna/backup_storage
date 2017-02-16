# Rsync class
class Rsync

  attr_reader :tmp_dir,
              :destination_dir

  def initialize
    @tmp_dir          = "#{Dir.home}/backup_me/tmp"
    @destination_dir  = "#{Dir.home}/backup_me/destination"
  end

  def backup(user_id, profile, paths, excludes)
    path = ini_directory(user_id, profile)
    file_exclude = excludes.any? ? create_exclude_list(excludes) : nil
    result = []
    paths.each do |p|
      result.push rbackup(p, path, file_exclude)
    end
    delete(file_exclude) unless file_exclude.nil?
    result
  end

  def find_directory(parent_dir)
    find(parent_dir)
  end

  def create_exclude_list(excludes)
    filename = "#{@tmp_dir}/#{DateTime.now.strftime('%Y%m%d%H%M%S')}.txt"
    excludes.each { |ex| add_to_file(ex, filename) }
    filename
  end

  def diff(paths, target_path)

  end

  def delete(path)
    rm(path)
  end

  # ================= ALL the command lines wrapper functions =================
  private

  def ini_directory(user_id, profile)
    log = DateTime.now.strftime('%Y-%m-%d-%H-%M-%S')
    user_directory = "#{@destination_dir}/#{user_id}"
    profile_directory = "#{@destination_dir}/#{user_id}/#{profile}"
    profile_log_directory = "#{@destination_dir}/#{user_id}/#{profile}/#{log}"

    Dir.mkdir(user_directory) unless File.exists?(user_directory)
    Dir.mkdir(profile_directory) unless File.exists?(profile_directory)
    Dir.mkdir(profile_log_directory) unless File.exists?(profile_log_directory)
    profile_log_directory
  end

  def rbackup(source, path, exclude_file)
    if exclude_file.blank?
      cmd = "rsync -avz #{source} #{path} "
      `#{cmd}`
    else
      cmd = "rsync -avz --exclude-from '#{exclude_file}' #{source} #{path} "
      `#{cmd}`
    end
  end

  def add_to_file(content, filename)
    cmd = "echo #{content} >> #{filename}"
    `#{cmd}`
  end

  def find(dir_path)
    cmd = "find #{@destination_dir}/#{dir_path}"
    `#{cmd}`
  end

  def create_dir(dir_path)
    cmd = "mkdir #{dir_path}"
    `#{cmd}`
  end

  def rm(path)
    cmd = "rm -rf #{path}"
    `#{cmd}`
  end


end