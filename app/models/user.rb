class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_admin?
    true
  end

  def gender_text
    case self.gender
    when 1
      return "Female"
    when 2
      return "Male"
    else
      return ""
    end
  end

  private
	def check_admin_user
		redirect_to root_path unless current_user.is_admin?
	end
end
