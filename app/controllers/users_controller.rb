class UsersController < InheritedResources::Base
	skip_before_action :verify_authenticity_token
	def create
	  @user = User.new(user_params)

	  respond_to do |format|
	    if @user.save
	    	format.html { redirect_to :back, notice: 'User was successfully created.' }
	    	# format.js   {}
	    	format.json { render json: @user, status: :created, location: @user }
	    else
	      # format.html { render :new }
	      format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
	  end
	end

  private

    def user_params
      params.require(:user).permit(:email)
    end
end

