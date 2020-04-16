class User < ApplicationRecord
  has_many :orders
  has_many :aggregators, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  def has_new_items?
    ParseItem.joins(site: [aggregator: :user])
             .where(users: { id: id })
             .any? { |i| i.status_new? }
  end
  
  def new_items
    ParseItem.joins(site: :user).where(users: {id: id}).status_new
  end
end
