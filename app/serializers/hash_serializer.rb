class HashSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    HashWithIndifferentAccess.new(hash || {})
  end
end
