class UsersController < ApplicationController

  def new
    @user = User.new
    # has_many relationship adds the collection.build method
    @user.addresses.build(address_type: "Home")
    @user.addresses.build(address_type: "Work")
    @user.build_team # build_ method comes from the belongs_to association
  end

  def create
    @user = User.create(user_params)
    raise params.inspect
    if @user.valid?
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, 
                                addresses_attributes: [
                                  :street_1,
                                  :street_2,
                                  :city,
                                  :state,
                                  :zip_code,
                                  :address_type
                                  ],
                                team_attributes: [
                                  :name,
                                  :hometown
                                ])
  end
end

