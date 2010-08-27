class Message < ActiveRecord::Base
  has_one :from, :class_name => "Profile"
  has_one :to, :class_name => "Profile"
end
