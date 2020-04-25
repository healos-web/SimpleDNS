class ResourceRecord < ActiveRecord::Base
  HOST_NAME_REGEXP ||= /(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])/.freeze
  API_ADDRESS_REGEXP ||= /(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/.freeze


  enum type: %i[a cname nx]

  validates :ttl, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 172800, only_integer: true }, presence: true
  validates :name, length: { maximum: 64 }, presence: true, format: { with: HOST_NAME_REGEXP, message: 'Should be valid host name' }
  validates :record, format: { with: /#{HOST_NAME_REGEXP}|#{API_ADDRESS_REGEXP}/, message: 'Should be valid host name or valid api address' }
end
