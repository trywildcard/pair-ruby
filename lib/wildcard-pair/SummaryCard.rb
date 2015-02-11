#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'

module WildcardPair
  class SummaryCard < WildcardPair::Card
    private

    attr_accessor :summary

    public

    attr_reader :summary

    validate :validate_summary

    def initialize(attributes = {})
      super
      @card_type = 'summary'
    end

    def summary=(summary)
      @summary = map_hash(summary, WildcardPair::Summary.new)
    end

    def validate_summary
      if @summary.nil? || !@summary.is_a?(Summary)
        errors.add(:summary, "A summary is required")
        return
      end

      if !@summary.valid?
        @summary.errors.each do |error, msg|
           errors["summary[%s]" % error] = msg
        end
      end
    end
  end
end

