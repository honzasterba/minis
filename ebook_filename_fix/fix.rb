#!/usr/bin/ruby

require "rubygems"
require "stringex"
require "YAML"

TRANS = {}
RE = /(%[a-f0-9]{2})/i

Translation = Struct.new(:name, :value, :files)
class Translation
	def files_translated
		files.collect { |f| translate(f) }
	end
	def print_files(m = "_translated")
		send("files" + m).each do |f|
			puts "- #{f}"
		end
	end
end

files = `find . | grep "%"`.split("\n")

def trans(str)
	return TRANS[str] if TRANS[str]
	TRANS[str] = Translation.new(str, nil, [])
	return TRANS[str]
end

def translate(f)
	f.gsub(RE) do |m|
		t = trans(m.to_s)
		if t.value
			t.value
		else
			m
		end	
	end
end

def untranslated
	have = true
	while have
		have = false
		todo = TRANS.select { |k, t| t.value.nil? }
		have = todo.any?
		todo.each { |k,v| yield v }
	end	
end

def save
	res = {}
	TRANS.each do |n, t|
		if t.value
			res[n] = t.value
		end
	end
	File.open "data.txt", "w" do |f|
		YAML::dump(res, f)
	end
end

def load
	data = {}
	File.open "data.txt", "r" do |f|
		data = YAML::load(f)
	end
	return if !data
	data.each do |k, v|
		trans(k).value = v
	end
end

files.each do |f|
	m = f.match RE
	break if !m
	i = 0
	while i < m.size
		t = trans(m[i])
		t.files << f
		i += 1
	end
end

load
untranslated do |t|
	puts "Translate [#{t.name}] (#{t.files.size} files)"
	t.print_files 
	a = gets.strip
	if a == "" || a == "x"
		puts "Skip for now"
	else
		puts "Translated #{t.name} to #{a}"
		t.value = a
		t.print_files
		gets
		save
	end	
end

puts "Everything translated!"

files.each do |f|
	cmd = "mv -v \"#{f}\" \"#{translate(f)}\""
	puts cmd
	`#{cmd}`
end
