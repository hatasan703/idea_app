class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :ideas, ->{ order(position: :asc)  }, dependent: :destroy
  has_many :plans
  has_many :memos
  has_many :comments
end