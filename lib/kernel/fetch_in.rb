require 'kernel/fetch_in'

module Kernel
  def fetch_in(collection, *keys)
    last_key = nil
    keys.reduce(collection) do |c, k|
      last_key = k
      c.fetch(k)
    end
  rescue IndexError, KeyError
    raise unless block_given?
    yield last_key
  end
  private :fetch_in
end
