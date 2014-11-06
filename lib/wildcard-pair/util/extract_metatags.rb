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

    private_class_method :get_meta_value, :get_meta_key, :get_metatag_key

    public
    def self.extract(web_url)
        begin
            metatags = Hash.new
                 
            if web_url.is_a?(String) && !web_url.nil? && !web_url.empty? 
 	   		     html_content = Net::HTTP.get(URI.parse(web_url))
                 ##store html content in metatags hash
                 metatags['html']=html_content
 	   		     doc = Nokogiri::HTML(html_content)
 	   		     
                doc.xpath("//meta").each do |meta|
        		      meta_key = get_meta_key(meta.attributes)
        		      meta_tag_key = get_metatag_key(meta_key)

        		      next if meta_tag_key.nil?
                      next if metatags.has_key?(meta_tag_key)

        		      metatags[meta_tag_key] = get_meta_value(meta.attributes) 
        	    end

            end

            return metatags

        rescue Exception => e
            ## something bad happened during extraction, lets output message and return empty hash
            puts e.message
            return {}
        end
    end

  end
end
