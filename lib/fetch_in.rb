module FetchIn
  def self.fetch_in(collection, first_key, *rest)
    keys = [first_key] + rest
    last_key = nil
    keys.reduce(collection) do |c, k|
      last_key = k
      c.fetch(k)
    end
  rescue IndexError, KeyError
    raise unless block_given?
    yield last_key
  end
end
