class VotesController < ApplicationController

  def create
    @poll = Poll.find(params[:poll_id])
    @trip = @poll.trip
    @option = PollOption.find(params[:poll_option_id])

    if current_user && user_voted?

      if current_user.voted_for?(@poll)
        flash[:error] = 'Your vote cannot be saved. Have you already voted?'
        render template: 'polls/show'
      else
        @option.votes.create({user_id: current_user.id})
        redirect_to [@trip, @poll]
      end

    else
      flash[:error] = 'Your vote cannot be saved.'
      render template: 'polls/show'
    end
  end

  private

  def user_voted?
    params[:poll_option_id].present?
  end

end
