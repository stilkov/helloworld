PROFILE_COUNT = ENV['USERS'] || 50
RELATION_COUNT = ENV['RELATIONS'] || PROFILE_COUNT * 20
MESSAGE_COUNT = ENV['MESSAGES'] || PROFILE_COUNT * 20

def rand_time(days = 365)
  rand(days).days.ago - rand(24).hours - rand(60).minutes
end

def random_boolean
  rand(2) == 1
end

def maybe(&block)
  yield if random_boolean
end

def rand_type 
  ProfileAttribute.types[rand(ProfileAttribute.types.length)]
end

def random_profile
  Profile.find(:first, :offset => rand(PROFILE_COUNT))
end

def two_random_different_profiles
  p1 = p2 = random_profile
  p2 = random_profile until p1 != p2
  [p1, p2]
end

def create_profile_attributes
  attrs = []
  5.times { maybe { attrs << (ProfileAttribute.new :attr_type => rand_type, :value => Forgery::Internet.email_address) } }
  attrs
end

def create_address 
  Address.create!  :street => Forgery::Address.street_name,
                   :city => Forgery::Address.city,
                   :zip => Forgery::Address.zip,
                   :country => Forgery::Address.country
end

def create_profiles
   Profile.delete_all
   User.delete_all
   Address.delete_all
   PROFILE_COUNT.times do 
     p = Profile.create! :last_name => Forgery::Name.last_name,
                         :first_name => Forgery::Name.first_name,
                         :company => Forgery::Name.company_name,
                         :about => Forgery::LoremIpsum.paragraph, 
                         :created_at => rand_time,
                         :updated_at => rand_time
     p.create_user :login => Forgery::Internet.user_name,
                           :password  => Forgery::Basic.password,
                           :created_at => rand_time,
                           :updated_at => rand_time

     maybe { p.private_address = create_address }
     maybe { p.business_address = create_address }
     p.profile_attributes << create_profile_attributes
     p.save!
   end
end

def create_relations
  Relation.delete_all
  RELATION_COUNT.times do 
    source, target = two_random_different_profiles
    Relation.create! :source => source, :destination => target,
                     :comment => Forgery::LoremIpsum.paragraph,
                     :accepted => random_boolean,
                     :created_at => rand_time,
                     :updated_at => rand_time
  end
end

def create_messages
  Message.delete_all
  MESSAGE_COUNT.times do 
    source, target = two_random_different_profiles
    Message.create! :from => source, :to => target, 
    :subject => Forgery::LoremIpsum.sentence,
                     :body => Forgery::LoremIpsum.paragraph,
                     :created_at => rand_time,
                     :updated_at => rand_time
  end
end

begin
  namespace :db do
    desc "Populate the development database with some fake data, based on #{PROFILE_COUNT} users"
    task :populate => :environment do
      create_profiles
      create_relations
      create_messages
    end
  end
rescue LoadError
  puts "Please run 'sudo gem install forgery' before executing this task"
end


