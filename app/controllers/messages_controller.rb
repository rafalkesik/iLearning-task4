class MessagesController < ApplicationController
  def create
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append('messages', partial: 'users/question_and_answer', locals: { message: params[:message] })
      end
    end    
  end
end