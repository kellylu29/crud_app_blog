require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, { adapter: "sqlite3", database: "development.sqlite3" }

get '/' do
  @posts = Post.all.sort_by { |r| r.id }.reverse
  erb :index
end

post '/posts' do
  post = Post.new(params[:post])
  if post.save
    redirect "/posts/#{post.id}"
  else
    redirect '/posts/new'
  end
end

get '/posts/new' do
  erb :new
end

get '/posts/:id' do
  @post = Post.find_by_id(params[:id])
  erb :show
end

put '/posts/:id' do
  post = Post.find_by_id(params[:id])
  if post.update(params[:post])
    redirect "/posts/#{post.id}"
  else
    redirect "/posts/#{post.id}/edit"
  end
end

get '/posts/:id/edit' do
  @post = Post.find_by_id(params[:id])
  erb :edit
end
