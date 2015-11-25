class Church < ActiveRecord::Base
  has_many :users
  has_many :church_roles
end
