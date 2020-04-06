class User < ApplicationRecord
  has_many :sites
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  def has_new_items?
    new_items.exists?
  end
  
  def new_items
    UserParseItems.call(self).status_new
  end
end
