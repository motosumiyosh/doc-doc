<<<<<<< HEAD
# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
=======
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
>>>>>>> d27e0e8e5f7516a48adcc5789c0d96b4e0b1d886
         :recoverable, :rememberable, :validatable
end
