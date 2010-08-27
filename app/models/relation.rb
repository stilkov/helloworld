class Relation < ActiveRecord::Base
  has_one :source, :class_name => "Profile"
  has_one :destination, :class_name => "Profile"
end
