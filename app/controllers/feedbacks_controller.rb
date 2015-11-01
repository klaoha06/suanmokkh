class FeedbacksController < InheritedResources::Base

	def create
	  @feedback = Feedback.new(feedback_params)

	  respond_to do |format|
	    if @feedback.save
	    	format.html { redirect_to :back, notice: 'feedback was successfully created.' }
	    	format.json { render json: @feedback, status: :created }
	    else
	      format.json { render json: @feedback.errors, status: :unprocessable_entity }
	    end
	  end
	end
  private

    def feedback_params
      params.require(:feedback).permit(:title, :required_response, :content, :email, :tel, :reply, :firstname, :lastname)
    end
end

