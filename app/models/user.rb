class User < ApplicationRecord
  before_validation {self.username.strip!}
  validates :username, presence: true, length: {minimum:2, maximum: 50}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  has_many :supports
end
