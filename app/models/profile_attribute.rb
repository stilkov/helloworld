class ProfileAttribute < ActiveRecord::Base
  def self.types 
    ["work", "home", "alternate"]
  end
end
