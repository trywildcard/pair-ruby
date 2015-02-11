#!/usr/bin/env ruby -wKU

require_relative 'Object.rb'
require_relative 'Media.rb'

module WildcardPair
	class ObjectWithMedia < WildcardPair::Object

		include WildcardPair::Media

		attr_reader :media
		validate :validate_media

		def media=(media)
			if media.is_a? Video
				@media = map_hash(media, Media::Video.new)
			elsif media.is_a? Image
				@media = map_hash(media, Media::Image.new)
			elsif media.is_a? Hash
				if media[:type] == 'video'
					@media = map_hash(media, Media::Video.new)
				elsif media[:type] == 'image'
					@media = map_hash(media, Media::Image.new)
				else
					@media = media
				end
			end
		end

		def validate_media
			if @media.nil? then return end

			if !@media.is_a? Media or !@media.valid?
				errors.add(:media, "Media is invalid")
				return false
			end
		end
	end
end