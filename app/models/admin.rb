class Admin < ActiveRecord::Base
  attr_accessible :login
  attr_accessible :password
  attr_accessible :password_confirmation	

  acts_as_authentic   #telling the admin model that it uses authlogic
end
