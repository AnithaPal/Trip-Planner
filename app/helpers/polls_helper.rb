module PollsHelper
  def visualize_votes(option)
    content_tag :div, class: 'progress' do
      content_tag :div, class: 'progress-bar',
                  style: "width: #{option.poll.normalized_votes_for(option)}%" do
        "#{option.votes.count}"
      end
    end
  end
end


 # def visualize_votes(option)
 #  <div class="progress progress-info" style="margin-bottom: 9px;">
 #     <div class="bar" style="width: #{option.poll.normalized_votes(option)}%"> 
 #      "#{option.votes.count}"
 #     </div>
 #  </div>
 # end 