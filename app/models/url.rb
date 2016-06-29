class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :long_url, uniqueness:{case_sensitive: false, message: "So bad! Try another link!"}
	validates :long_url, format: {with:(URI::regexp(['http', 'https']))}

	before_create :shorten_it

	def shorten_it
		self.short_url = SecureRandom.hex(6)
	end
end