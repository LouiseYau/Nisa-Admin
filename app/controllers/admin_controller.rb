class AdminController < ApplicationController
  layout false
  def index
     @sub = Admin.all
     @new = Admin.where(sent: 'false')

     Gibbon::Request.api_key = Rails.application.credentials.gibbon_api_key
     list = Gibbon::Request.lists("9225cefb61").members.retrieve(params: {"fields": "members.email_address"})
     list_hash = list.body
     @result_array =  list_hash['members'].map { |ea| ea['email_address'] }

    # send = Gibbon::Request.campaigns("d6072e2ed5").actions.send.create
    #  @newd = Sub.find_by sent: 'true'
  end

  def show
    @sub = Admin.find(params[:id])
  end

  def new
     @sub = Admin.new()
  end

  def create
    # Instantiate a new object using form parameters
    @sub = Admin.new(sub_params)
    # Save the object
    if @sub.save
      # If save succeeds, redirect to the index action
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @sub = Admin.find(params[:id])
  end

  def update
    # Find an existing object using form parameters
    @sub = Admin.find(params[:id])
    # Update the object
    if @sub.update_attributes(sub_params)
      
      # If update succeeds, redirect to the index action
      redirect_to(:controller=>'admin') 
    else
      # If save fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
  end

  def new_sign_ups

  #  @sub = Sub.find_by sent: 'true'
   @sub = Admin.where(sent: 'true')
  # @sub = Sub.all
  
  end

  def send_email
  end

  def a_list
    list = Gibbon::Request.lists("9225cefb61").members.retrieve(params: {"fields": "members.email_address"})
    list_hash = list.body
    @result_array =  list_hash['members'].map { |ea| ea['email_address'] }
  end

  private

  def sub_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:sub).permit(:first_name, :last_name, :email, :sent)
  end

  
end