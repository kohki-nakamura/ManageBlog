class Blog < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	validates :is_public, inclusion: {in: [true, false]}

  has_one_attached :image # ActiveStorage

	def self.search(search)
		return Blog.all unless search
		Blog.where(['title LIKE ?', "%#{search}%"])
	end

  def get_image
    self.image.present? ? self.image.url : "noimage.png"
  end

	scope :to_csv, -> {
    headers = %w(
      id title content is_public image
    )
    csv = CSV.generate(headers: headers, write_headers: true, encoding: 'SJIS', force_quotes: true) do |_csv|
      # find_each を使うことで分割してレコードを取得することが可能になるので、メモリ不足でエラーになる問題が解消されます
      # https://www.techscore.com/blog/2017/12/04/fast_and_low-load_processing_method_when_exporting_csv_from_db_with_rails/
      find_each{|blog|
        row = []
        row.push(blog.id)
        row.push(blog.title)
        row.push(blog.content)
				row.push(blog.is_public)
				row.push()
        _csv << row.map{|v| ApplicationController.helpers.encode_sjis(v.to_s) }
      }
		end
  }
end
