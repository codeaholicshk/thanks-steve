require 'csv'
require 'time'
require 'erb'

lines = CSV.read(File.open('bin/thankings.csv'))

header = lines.shift
lines.each do |timestamp, name, photo_url, message|

  time = Time.parse(timestamp)

  post = <<-MARKDOWN
---
layout: post
title:  #{ name.inspect }
date:   #{ time.to_s.split(' ')[0..-2].join(" ") }
categories: thanks
---

![photo](#{ photo_url })

> #{ message }

MARKDOWN

  filename = "#{time.to_date.to_s}-#{name.downcase.gsub(/s/,"-")}.markdown"

  File.open("_posts/#{filename}", "w") do |file|
    file.puts(post)
  end
end
