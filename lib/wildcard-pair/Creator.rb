#!/usr/bin/env ruby -wKU

require_relative 'Object.rb'

module WildcardPair  
  class Creator < WildcardPair::Object

    attr_accessor :name, :favicon, :ios_app_store_url, :android_app_store_url, :url

    validates :name, presence: true
    validates :favicon, presence: true
  end
end