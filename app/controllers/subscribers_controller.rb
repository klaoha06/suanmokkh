class SubscribersController < InheritedResources::Base
	skip_before_action :verify_authenticity_token
	def create
	  @subscriber = Subscriber.new(subscriber_params)

	  respond_to do |format|
	    if @subscriber.save
	    	format.html { redirect_to :back, notice: 'subscriber was successfully created.' }
	    	# format.js   {}
	    	format.json { render json: @subscriber, status: :created, location: @subscriber }
	    else
	      # format.html { render :new }
	      format.json { render json: @subscriber.errors, status: :unprocessable_entity }
	    end
	  end
	end

  private

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end