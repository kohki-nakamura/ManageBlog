class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :is_admin, inclusion: {in: [true, false]}

  def self.search(search)
		return User.all unless search
		User.where(['email LIKE ?', "%#{search}%"])
	end

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

  scope :to_csv, -> {
    headers = %w(
      id last_name first_name birthday gender phone zipcode address email
    )
    csv = CSV.generate(headers: headers, write_headers: true, encoding: 'SJIS', force_quotes: true) do |_csv|
      # find_each を使うことで分割してレコードを取得することが可能になるので、メモリ不足でエラーになる問題が解消されます
      # https://www.techscore.com/blog/2017/12/04/fast_and_low-load_processing_method_when_exporting_csv_from_db_with_rails/
      find_each{|user|
        row = []
        row.push(user.id)
        row.push(user.last_name)
        row.push(user.first_name)
        row.push(user.birthday)
        row.push(user.gender_text)
        row.push(user.phone)
        row.push(user.zipcode)
        row.push(user.address)
        row.push(user.email)
        _csv << row.map{|v| ApplicationController.helpers.encode_sjis(v.to_s) }
      }
		end
  }

  private
	def check_admin_user
		redirect_to root_path unless current_user.is_admin?
	end
end
