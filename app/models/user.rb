class User < ActiveRecord::Base
  attr_accessible :login_token, :password_digest, :password_salt, :username
end
