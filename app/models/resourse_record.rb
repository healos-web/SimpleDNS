class ResourceRecord < ActiveRecord::Base
  HOST_NAME_REGEXP ||= /(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])/.freeze
  API_ADDRESS_REGEXP ||= /(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/.freeze

  enum record_type: %i[a cname nx]

  validates :ttl, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 172800, only_integer: true }, presence: true
  validates :host_name, length: { maximum: 64 }, presence: true, uniqueness: true, format: { with: HOST_NAME_REGEXP, message: 'Should be valid host name' }
  
  validates :record_value, presence: true
  validates :record_value, length: { maximum: 64 }, format: { with: HOST_NAME_REGEXP, message: 'should be valid host name' }, unless: -> { record_type == 'a' }
  validates :record_value, format: { with: API_ADDRESS_REGEXP, message: 'should be valid api address' }, if: -> { record_type == 'a' }
end
