class Admin < ApplicationRecord
  rolify
  before_create :set_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable



  private

  def set_role
    debugger
    if self.email!="a@a.com"
      self.add_role :vendor
    else
      self.add_role :admin
    end
  end


end
