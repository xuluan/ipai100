class User < ActiveRecord::Base
  attr_accessible :phone_no, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :phone_no
  validates_uniqueness_of :phone_no
  validates :phone_no, :length => 10..12
  validates :password, :length => 6..20
  validates :phone_no, :numericality  => true
  validates :password, :numericality  => true

  has_many :sync_sites, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  def self.authenticate(phone_no, password)
    user = find_by_phone_no(phone_no)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
