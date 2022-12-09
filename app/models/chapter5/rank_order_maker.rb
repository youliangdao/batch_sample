module Chapter5

  class RankOrderMaker
    def each_ranked_user
      rank = 1
      previous_score = 0

      users_sorted_by_score.each do |user|
        rank += 1 if user.total_score < previous_score
        yield(user, rank)
        previous_score = user.total_score
      end
    end

    private

    def users_sorted_by_score
      User.includes(:user_scores)
        .all
        .select { |user| user.total_score.nonzero? }
        .sort_by { |user| user.total_score * -1 }
    end
  end
end
