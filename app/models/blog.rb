class Blog < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	validates :is_public, inclusion: {in: [true, false]}

	def self.search(search)
		return Blog.all unless search
		Blog.where(['title LIKE ?', "%#{search}%"])
	end
end
