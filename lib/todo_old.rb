require 'pry'
require 'sinatra'

get '/' do

	class ToDo
		attr_accessor :task
		@@superList ||= []
		def initialize(item)
			@task = item
			@@superList << self
		end
		def self.getMyTasks
			@@superList
		end
		def self.delete(item)
			@@superList.delete_if {|inValue| inValue.task == item }
		end
	end

	erb :index
end

post '/' do
	ToDo.new(params["task"])
	redirect to('/')
end

post '/del' do
	ToDo.delete(params["chk"])
	redirect to('/')
end