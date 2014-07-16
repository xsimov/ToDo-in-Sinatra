require 'pry'
require 'sinatra'
require 'pstore'

	class ToDo
		attr_accessor :task

		def initialize(item)
			@task = item
			add(self)
		end

		def add(tdObject)
			storeFile.transaction do
				storeFile[:superList] << tdObject
			end
		end

		def self.delete(item)
			storeFile.transaction do
				storeFile[:superList].delete_if {|inValue| inValue.task == item }
			end
		end

	end

storeFile = PStore.new("tasks.pstore")

get '/' do
	storeFile.transaction do
		@superList = storeFile[:superList]
		# binding.pry
	end
	erb :index
end

post '/save' do
	ToDo.new(params["task"])
	redirect to('/')
end

post '/del' do
	ToDo.delete(params["chk"])
	redirect to('/')
end