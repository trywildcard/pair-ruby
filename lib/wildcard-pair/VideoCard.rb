#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'
require_relative 'Media.rb'

module WildcardPair
  class VideoCard
    private

    attr_accessor :video, :card_type, :pair_version

    public

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    attr_accessor :web_url
    attr_reader :video, :card_type, :pair_version

    validates :web_url, presence: true
    validate :validate_video

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      @card_type = 'video'

      if !Gem.loaded_specs['wildcard-pair'].nil?
        @pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
      else
        @pair_version = "unknown"
      end
    end

    def attributes
      instance_values
    end

    def video=(video)
      @video = map_hash(video, WildcardPair::Media::Video.new)
    end

    def validate_video
      if @video.nil? || !@video.is_a?(Video)
        errors.add(:video, "A video is required")
      end

      if !@video.nil? 
        if !@video.valid?
          @video.errors.each do |error, msg|
            errors[error] = msg
          end
        end
      end
    end

    #exclude validation fields in the JSON output
    def as_json(options={})
      super(options.merge({:except => [:errors, :validation_context]}))
    end

    def to_json(options={})
      if self.valid?
        super(options)
      else
        raise "Video Card is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end

