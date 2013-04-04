require 'bcrypt'


class User < ActiveRecord::Base
  include BCrypt

  validates :password, 
              :confirmation => true, 
              :length => { :minimum => 6 }

  validates :email, 
              :uniqueness => true, 
              :presence => true,
              :format=> { :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
  
  validates :name, :presence => true
  

  def self.authenticate(email, secret)
    user = find_by_email(email)
    return nil unless user
    user.password == secret ? user : nil
  end

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(secret)
    @password = Password.create(secret)
    self.password_hash = @password
  end
end


