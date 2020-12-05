# frozen_string_literal: true

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database,  { adapter: 'sqlite3', database: 'barbershop.db' }

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { in: 3..20}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
	validates :user_name, presence: true
	validates :user_message, presence: true
end


before do
	@barbers = Barber.all
	@clnt = Client.new params[:client]
end


get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do

	
	@clnt.save

	if @clnt.save
		erb 'You in!'
	else
		@error= @clnt.errors.full_messages.first
		erb :visit
	end
end

get '/contact' do
	erb :contact
end

post '/contact' do

	cntct = Contact.new params[:contact]
	cntct.save

	if cntct.save
		erb :contact 
	else
		@error = cntct.errors.full_messages.first
		erb :contact
	end
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])

	erb :barber
end

get '/bookings' do
	@visiters = Client.order(:datestamp).reverse_order

	erb :bookings
end

get '/client/:id' do
	@client = Client.find(params[:id])

	erb :client
end
