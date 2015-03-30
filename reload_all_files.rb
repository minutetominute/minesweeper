def rall
  Dir["./*"].reject do |file|
    file == "./reload_all_files.rb"
  end.each {|file| load file if file.include?('.rb') }
end

rall
