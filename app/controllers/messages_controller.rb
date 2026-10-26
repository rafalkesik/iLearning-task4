class MessagesController < ApplicationController
  def create
    element_id = "message_#{SecureRandom.hex(4)}"
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append('messages',
                              partial: 'users/question_and_answer',
                              locals: { message: params[:message], element_id: element_id }),
          turbo_stream.action(:focus, element_id)
        ]
      end
    end    
  end
end