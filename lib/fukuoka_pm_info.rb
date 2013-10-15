require "fukuoka_pm_info/version"
require 'open-uri'

module FukuokaPmInfo
	class Fukuoka
		def initialize(url = nil, cache = nil)
			url ||= "http://www.fukuokakanshi.com/mobile2/data/051/MobileHourItemvalue01.htm"

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


			flg = true
			@br_positions = []
			while flg
				unless @br_positions.last
					pos = @body_str.index('<br>')
				else
					pos = @body_str.index('<br>',@br_positions.last + 1)
				end

				unless pos
					flg = false
					break
				else
					if pos == @br_positions.last
						break
					end
					@br_positions << pos
				end
			end
		end

		def br_section(index)
			@body_str[@br_positions[index]+4,@br_positions[index+1]-@br_positions[index]-4].lstrip.rstrip
		end

		def date_str
			br_section(3)
		end

		def date
			str = date_str # 2013年5月14日（火）15時
			Time.local(*str.scan(/[\d]+/))
		end

		def fetch_data
			array = []
			8.times do |i| 
				hash = {}
				hash[:place] = br_section(7 + (i*2))
				hash[:value] = br_section(8 + (i*2)).gsub("：",'').lstrip
				array << hash
			end

			array
		end

		def unit
			unit_str = br_section(5)
			unit_str[unit_str.index('：')+1..-1]
		end
		
	end	

end
