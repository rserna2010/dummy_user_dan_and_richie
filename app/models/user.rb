class User < ActiveRecord::Base
  # Remember to create a migration!

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, presence: true


  def self.authenticate(email, password)
    @users = User.where(email: email, password: password)
    if @users.count == 1
      return @users.first.id
    else
      return false #or something
    end
  end


end
