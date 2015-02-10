#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'

module WildcardPair
  class LinkCard < WildcardPair::Card
    private

    attr_accessor :target

    public

    attr_reader :target

    validate :validate_target

    def initialize(attributes = {})
      super
      @card_type = 'link'
    end

    def target=(target)
      @target = map_hash(target, WildcardPair::Target.new)
    end

    def validate_target
      if @target.nil? || !@target.is_a?(Target)
        errors.add(:target, "A target is required")
        return
      end

      if !@target.valid?
        @target.errors.each do |error, msg|
           errors["media[%s]" % error] = msg = msg
        end
      end
    end

  end
end