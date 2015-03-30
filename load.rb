def rall
  Dir["./*"].reject do |file|
    file == "./load.rb"
  end.each {|file| load file if file.include?('.rb') }
end

rall
