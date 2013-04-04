require 'bcrypt'


class User < ActiveRecord::Base

    include BCrypt

  validate :email, # unique
           :name # unique

  def self.authenticate(email, secret)
    user = find_by_email(email)
    password_hash = user.password_hash
    # p hash
    salt = user.salt
     # p salt
    compare_string = BCrypt::Engine.hash_secret(secret, salt)
    # p compare_string   
    if compare_string == password_hash
      return user
    else  
      return nil
    end  
  
  end

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(secret)
    @password = Password.create(secret)
    self.salt = @password.salt
    self.password_hash = @password.to_s
  end


end


