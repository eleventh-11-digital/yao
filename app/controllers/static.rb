get '/' do
	@urls = Url.all
  erb :"static/index"
end

post '/urls' do
	@url = Url.find_by(long_url:params[:long_url])

	if 	@url
		@msg = "U been shorten before, Dude!"
		@urls = Url.all
		erb :"static/index"
	else
		@url = Url.new(long_url:params[:long_url])

		if @url.save
			@msg = "Its done for u, Bro!"
			@urls = Url.all
			erb :"static/index"
		else
			@msg = "WTF u try to input?"
			@urls = Url.all
			erb :"static/index"
		end
	end
end

get '/:short_url' do
	@urls = Url.where(short_url: params[:short_url]).first
	@urls.save
	redirect @urls.long_url
end