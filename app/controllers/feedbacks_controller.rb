class FeedbacksController < InheritedResources::Base

	def create
		p feedback_params
	  @feedback = Feedback.new(feedback_params)

	  respond_to do |format|
	    if @feedback.save
	    	format.html { redirect_to :back, notice: 'feedback was successfully created.' }
	    	# format.js   {}
	    	format.json { render json: @feedback, status: :created }
	    else
	      # format.html { redirect_to :back, notice: 'error', status: :unprocessable_entity }
	      format.json { render json: @feedback.errors, status: :unprocessable_entity }
	    end
	  end
	end
  private

    def feedback_params
      params.require(:feedback).permit(:title, :content, :email, :tel, :reply, :firstname, :lastname)
    end
end

