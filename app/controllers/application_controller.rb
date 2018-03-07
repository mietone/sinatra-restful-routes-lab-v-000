require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # CREATE =========================

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "recipes/#{recipe.id}"
  end

  # READ =========================

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  #
  # get '/recipes/:id' do
  #   @recipe = Recipe.find(params[:id])
  #   erb :show
  # end
  #
  # # UPDATE =========================
  #
  # get '/recipes/:id/edit' do
  #   @recipe = Recipe.find(params[:id])
  #   erb :edit
  # end
  #
  # patch '/recipes/:id' do
  #   @recipe = Recipe.find(params[:id])
  #   @recipe.name = params[:name]
  #   @recipe.ingredients = params[:ingredients]
  #   @recipe.cook_time = params[:cook_time]
  #   @recipe.save
  #   redirect '/recipes/#{@recipe.id}'
  # end
  #
  # # DELETE =========================
  #
  # delete '/recipes/:id/delete' do
  #   @recipe = Recipe.find(params[:id])
  #   @recipe.delete
  #   redirect '/'
  # end

  get '/recipes/:id' do  #loads show page
  @recipe = Recipe.find_by_id(params[:id])
  erb :show
end

get '/recipes/:id/edit' do #loads edit form
  @recipe = Recipe.find_by_id(params[:id])
  erb :edit
end

patch '/recipes/:id' do  #updates a recipe
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.name = params[:name]
  @recipe.ingredients = params[:ingredients]
  @recipe.cook_time = params[:cook_time]
  @recipe.save
  redirect to "/recipes/#{@recipe.id}"
end

post '/recipes' do  #creates a recipe
  @recipe = Recipe.create(params)
  redirect to "/recipes/#{@recipe.id}"
end

delete '/recipes/:id/delete' do #delete action
@recipe = Recipe.find_by_id(params[:id])
@recipe.delete
redirect to '/recipes'
end
end
