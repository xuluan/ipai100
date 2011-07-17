class User < ActiveRecord::Base
  attr_accessible :phone_no, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :phone_no
  validates_uniqueness_of :phone_no
  validates :phone_no, :length => 11..11
  validates :password, :length => 6..20
  validates :phone_no, :numericality  => true
  validates :password, :numericality  => true

  has_many :sync_sites, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  belongs_to :user_info
  before_create :create_user_info

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

  protected

  def create_user_info
    user_info = UserInfo.new
    user_info.save
    self.user_info_id = user_info.id
  end
end
