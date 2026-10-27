class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  enum :status, { active: 'active', blocked: 'blocked' }, validate: true
  self.per_page = 9
end
