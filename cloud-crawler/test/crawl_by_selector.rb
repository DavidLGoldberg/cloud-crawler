#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'cloud-crawler'
require 'trollop'

opts = Trollop::options do
  opt :urls, "urls to crawl", :short => "-u", :multi => true,  :default => "http://www.ehow.com"
  opt :selector, "selector", :default => "body", :type => :string
  opt :file, "file path to save output", :short => "-f", :default => "crawl.out", :type => :string
  opt :headless, "whether to use headless browsing", :short => "-h", :default => false
  opt :headless_wait, "whether to use headless browsing", :short => "-w", :default => 3, :type => :int
end

CloudCrawler::standalone_crawl(opts[:urls], {}) do |crawl|
  $sel = opts.selector
  $file = opts.file
  puts "crawling with: #{$sel}"
  puts "saving to file: #{$file}"
  crawl.on_every_page do |p|
    puts "page: #{p.url.to_s}"
    page.doc.css($sel.to_s).each do |elem|
      File.open($file, 'a') { |file| file.write("#{elem.content}\n")}
    end
  end
end
