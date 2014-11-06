require 'uri'
require 'net/http'
require 'nokogiri'

module WildcardPair
  module ExtractMetaTags



    def self.get_metatag_key(attribute)

    	if attribute.nil?
    		return nil
    	end

    	case attribute
    	when "twitter:title", "og:title"
    		return "title"
    	when "twitter:description", "og:description"
    		return "description"
    	when "twitter:image", "twitter:image:src", "og:image"
    		return "image_url"
    	when "og:price:amount", "product:price:amount"
    		return "price"
    	when "twitter:app:url:iphone", "al:ios:url"
    		return "applink_ios"
    	when "twitter:app:url:googleplay", "al:android:url"
    		return "applink_android"
    	when "og:video", "twitter:player"
    		return "video_url"
    	when "og:video:width", "twitter:player:width"
    		return "video_width"
    	when "og:video:height", "twitter:player:height"
    		return "video_height"	
    	else
    		return nil
    	end
    end

    def self.get_meta_key(meta_element)
    	puts meta_element
    	if !meta_element.is_a?(Hash)
    		return nil
    	end

    	if (!meta_element['name'].nil?)
    		return meta_element['name'].value
    	elsif (!meta_element['property'].nil?)
    		return meta_element['property'].value
    	end
   		
    end

    def self.get_meta_value(meta_element)
    	if !meta_element.is_a?(Hash)
    		return nil
    	end

    	if (!meta_element['content'].nil?)
    		return meta_element['content'].value
    	elsif (!meta_element['value'].nil?)
    		return meta_element['value'].value
    	end
   		
    end

        def self.extract(web_url)
       if web_url.is_a?(String) && !web_url.nil? && !web_url.empty? 
       	## todo exception handling
 	   		html = Net::HTTP.get(URI.parse(web_url))
 	   		doc = Nokogiri::HTML(html)
 	   		metatags = Hash.new
 	   		#return doc.xpath("//meta") 		 
        	doc.xpath("//meta").each do |meta|
        		puts meta
        		meta_key = get_meta_key(meta)
        		meta_tag_key = get_metatag_key(meta_key)

        		next if (!meta_key.nil? || metatags.has_key?(meta_tag_key))
        		

##todo add check to see if its a meta tag key we care about
        		metatags[meta_tag_key] = get_meta_value(meta) 


        	end

        	return metatags
       end
      
      return {}
    end

  end
end
