#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class Product

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    attr_accessor :name, :merchant, :brand, :description, :gender, :rating, :rating_scale, :rating_count, :sizes, :model, :app_link_ios, :app_link_android
    attr_reader :colors, :images, :related_items, :referenced_items, :options

    validates :name, presence: true, length: {minimum: 1}
    validates :gender, allow_nil: true, inclusion: {in: %w(male female unisex) }

    validate :validateColors
    validate :validateImages

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def attributes
      instance_values
    end

    def colors=(colors)
      @colors ||= Array.new

      if colors.is_a?(Array)
        colors.each do |color|
          @colors << map_hash(color, Color.new)
        end
      elsif colors.is_a?(Color)
          @colors << colors
      else
        @colors << map_hash(colors, Color.new)
      end
    end

    def images=(images)
      @images ||= Array.new

      if images.is_a?(Array)
        @images = images
      else
        @images << images
      end
    end

    def related_items=(related_items)
      @related_items ||= Array.new

      if related_items.is_a?(Array)
        @related_items = related_items
      else
        @related_items << related_items
      end
    end

    def referenced_items=(referenced_items)
      @referenced_items ||= Array.new

      if referenced_items.is_a?(Array)
        @referenced_items = referenced_items
      else
        @referenced_items << referenced_items
      end
    end

    def options=(options)
      @options ||= Array.new

      if options.is_a?(Array)
        @options = options
      else
        @options << options
      end
    end

    def validateColors
      if (!@colors.nil? && @colors.any?)
        @colors.each do |color|
          if (!color.is_a?(Color) || !color.valid?)
            errors.add(:colors, "Atleast one of the colors is an invalid color object")
            return
          end
        end
      end
    end

    def validateImages
      if @images.nil? || (@images.is_a?(Array) && !@images.any?)
        errors.add(:images, 'A product image is required')
        return
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
        raise "Product is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end