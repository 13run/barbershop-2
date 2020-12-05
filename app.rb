# frozen_string_literal: true

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: 'barbershop.db' }

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end


before do
	@barbers = Barber.all
end


get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	# @barber = params[:barber]
	# @user = params[:user_name]
	# @phone = params[:user_phone]
	# @date = params[:date_time]
	# @color = params[:colorpicker]

	# Client.create 	name: @user, phone: @phone,
	# 				datestamp: @date, barber: @barber,
	# 				color: @color

	clnt = Client.new params[:client]
	clnt.save

	erb 'You in!'
end

get '/contact' do
	erb :contact
end

post '/contact' do
	@user_name = params[:user_name]
	@user_message = params[:user_message]

	Contact.create user_name: @user_name, user_message: @user_message

	erb :contact 
end
