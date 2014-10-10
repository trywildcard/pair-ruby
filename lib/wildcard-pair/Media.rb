module WildcardPair
  module Media
    def type
      return self.class.name.split('::').last.downcase
    end
  end
end