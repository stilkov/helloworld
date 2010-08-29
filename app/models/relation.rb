class Relation < ActiveRecord::Base
  belongs_to :source, :class_name => "Profile"
  belongs_to :destination, :class_name => "Profile"
end
