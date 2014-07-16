require 'pry'
require 'sinatra'
require 'pstore'
require 'json'

class ToDo
	def initialize()
		@storeFile = PStore.new("tasks.pstore")
	end

	def add(tdObject)
		@storeFile.transaction do
			@storeFile[:superList] ||= []
			@storeFile[:superList] << tdObject
		end
	end

	def delete(item)
		@storeFile.transaction do
			@storeFile[:superList].delete_if {|inValue| inValue == item }
		end
	end

	def all
		@storeFile.transaction do
			@storeFile[:superList]
		end
	end
end

get '/beta' do
	erb :beta
end

get '/' do
	@todo_items = ToDo.new.all
	@todo_items ||= []
	erb :index
end

post '/save' do
	ToDo.new.add(params["task"])
	redirect to('/') unless params["frombeta"]
	redirect to('/beta')
end

post '/del' do
	ToDo.new.delete(params["chk"])
	redirect to('/') unless params["frombeta"]
	redirect to('/beta')
end

get '/api/list' do
	everything = Hash.new
	everything["list"] = ToDo.new.all
	everything["list"].to_json
end