require 'resolv'

class Link < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user

  validate :url, :presence => true
  validate :dns_ok
  
  after_create :shortify

  
  def shortify
    self.short_url = self.id.to_s(36)
    self.save
  end

  def dns_ok
    ok = Resolv.getaddress(self.url) rescue nil
    if ok.nil?
      errors.add(:url, "could not resolve url")
    end
  end

end
