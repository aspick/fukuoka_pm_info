require "fukuoka_pm_info/version"
require 'open-uri'
require 'nokogiri'

module FukuokaPmInfo
	class Fukuoka
		def initialize(url = nil, cache = nil)
			url ||= "http://www.fukuokakanshi.com/taikidayitem/Nipokomokubetsu_051_20160111.html"

			if cache && cache.get("content-#{url}")
				@body_str = cache.get("content-#{url}")
			else
				html = open(url) do |f|
				  f.read
				end
				doc = Nokogiri::HTML.parse(html, nil, 'Shift_JIS')
				body = doc.search('//body')

				puts body.to_s.encode("utf-8")

				@body_str = body.to_s.encode("utf-8")
				@body_str.gsub!('&#160;',' ')

				if cache
					cache.set("content-#{url}",@body_str,300)
				end
			end

			@dom = Nokogiri::HTML(@body_str)
		end

		def date
			str = @dom.search('.hidtable td').last.text # 測定年月日：2013年5月14日（火）
			comp = str.scan(/[\d]+/)
			comp << [0, 0, 0, 3/8r]
			comp.flatten!
			Time.local(*comp)
		end

		def fetch_data
			array = []
			table = @dom.search('#tableBody').first

			table.search('tr').each do |tr|
				place = tr.search('th').first.text.gsub(/\s/,'')
				values = tr.search('td').map{|td| td.text}.map{|text| Integer(text) rescue nil }

				array << {
					place: place,
					values: values
				}

			end

			array
		end

		def unit
			@dom.search('.hidtable td')[-2].text.split('：').last.gsub(/\s/,'')
		end

	end

end
