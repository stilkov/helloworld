class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :private_address, :class_name => 'Address'
  belongs_to :business_address, :class_name => 'Address'
  has_many :profile_attributes
  has_many :relations, :foreign_key => :source_id
  has_many :contacts, :through => :relations, :source => :source

  def full_name 
    "#{first_name} #{last_name}"
  end

  def contact_count 
    # intentionally stupid
    contacts.count
  end
end
