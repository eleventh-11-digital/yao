# require 'byebug'
get '/' do
	@urls = Url.all
  erb :"static/index"
end

# get '/about' do
# 	erb :"static/about"
# end

post '/urls' do
	@url = Url.find_by(long_url:params[:long_url])

	if 	@url
		@msg = "U been shorten before, Dude!"
		@urls = Url.all
		status 400
		hash = { message: 'U been shorten before, Dude!'}
		return hash.to_json
		# erb :"static/index"
	else
		@url = Url.new(long_url:params[:long_url])

		if @url.save
			@msg = "Its done for u, Bro!"
			@urls = Url.all
			status 200
			hash = { short_url: @url.short_url, long_url: @url.long_url, message: "Its done for u, Bro!" }
			return hash.to_json
			# erb :"static/index"
		else
			@msg = "WTF u try to input?"
			@urls = Url.all
			status 400
			hash = { message: "WTF u try to input?" }
			return hash.to_json
			# erb :"static/index"
		end
	end
end

get '/:short_url' do
	@urls = Url.where(short_url: params[:short_url]).first
	@urls.save
	redirect @urls.long_url
end