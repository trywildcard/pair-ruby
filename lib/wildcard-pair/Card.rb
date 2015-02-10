require 'active_model'
require_relative 'hash_mappable.rb'
require_relative 'Creator.rb'

module WildcardPair
	class Card
		private

		attr_accessor :card_type, :pair_version, :creator

		public

		include ActiveModel::Validations
		include ActiveModel::Serializers::JSON
		include WildcardPair::HashMappable

		attr_accessor :web_url, :keywords, :app_link_android, :app_link_ios
		attr_reader :card_type, :pair_version, :creator

		validates :web_url, presence: true
		validate :validate_keywords
		validate :validate_creator

		def initialize(attributes = {})
			attributes.each do |name, value|
				send("#{name}=", value)
			end

			if !Gem.loaded_specs['wildcard-pair'].nil?
				@pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
			else
				@pair_version = "unknown"
			end
		end

		def attributes
			instance_values
		end

		def validate_keywords
			if !@keywords.nil? and !@keywords.instance_of? Array
				errors.add(:keywords, "Keywords must be an array of strings")
				return
			end

			if !@keywords.nil?
				@keywords.each do |k|
					if !k.instance_of? String
						errors.add(:keywords, "Keywords must be an array of strings")
						return
					end
				end
			end
		end

		def creator=(creator)
			@creator = map_hash(creator, WildcardPair::Creator.new)
		end

		def validate_creator
			if @creator.nil? then return end

			if !@creator.is_a? Creator or !@creator.valid?
				errors.add(:creator, "Creator is invalid")
				return false
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
				raise self.card_type.capitalize + " Card is not valid - please remedy the following errors:" << self.errors.messages.to_s
			end    
		end 
	end
end
