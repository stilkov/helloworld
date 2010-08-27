class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :private_address, :class_name => "Address"
  has_one :business_address, :class_name => "Address"
  has_many :profile_attributes
end
