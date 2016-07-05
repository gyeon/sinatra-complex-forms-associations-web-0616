class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
     @pet = Pet.create(params[:pet])
     # @pet.owner_id = params[:pet][:owner_id].first
    if params[:owner_name].empty?
      @owner = Owner.find(params[:pet][:owner_id]).first
      @owner.pets << @pet
      @owner.save
    else
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << @pet
      @owner.save
    end

  
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    ##ask about this part again, because, what????
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner_name])
      @pet.update(owner_id: @owner.id)

    end
    @owner.update(params[:owner])

    redirect to "pets/#{@pet.id}"
  end
end



 