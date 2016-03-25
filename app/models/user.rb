class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  attr_accessor :remember_token

  has_attached_file :avatar, styles: { medium: "50x50>", thumb: "50x50>" }, default_url: "/images/:thumb/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # this before_save is a callback method. What it does is before it saves the email
  #address it calls back and transforms all the letters into lower case. Had to do the indexing
  #in active record in order for the method to work
  validates :first_name , presence: true, length: {maximum: 15}
  validates :last_name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #code that ensures that a user  puts the right format for emails in signup
    #fields
  validates :email, presence: true, length:{maximum: 50},
                                    format:{with: VALID_EMAIL_REGEX },
                                    uniqueness:{ case_sensitive: false }
                                    #rails still assumes that uniquess is true
                                    #whether the user types CAMELcase or lowercase
  validates :password, presence: true, length:{maximum: 50}
  validates :user_about_me, presence: true
  validates :birthday, presence:true
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


## returns a random user token
 def User.new_token
    SecureRandom.urlsafe_base64
 end

 # Remember a given user to the database for use of persistent sessions

 def remember
   self.remember_token = User.new_token
   update_attribute(:remember_digest, User.digest(remember_token))
 end
##returns true if given token matches the digest
 def authenticated?(remember_token)
   return false if remember_digest.nil?
   BCrypt::Password.new(remember_digest).is_password?(remember_token)
 end

 def forget
   update_attribute(:remember_digest, nil)
 end
 def log_out
  forget(current_user)
  session.delete(:user_id)
  @current_user = nil
  end
end
