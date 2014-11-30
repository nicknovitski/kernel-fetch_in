require 'fetch_in'

module Kernel
  extend Forwardable
  def_delegator :FetchIn, :fetch_in
  private :fetch_in
end
