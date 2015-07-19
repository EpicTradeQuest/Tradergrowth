module ReviewsHelper
  def tag_list
    unless params[:query].present?
      'ALL'
    else
      params[:query]
    end
  end

  def total_pip_result trades
    trades.sum(:result).round(2)
  end

  def average_pip_result trades
    trades.average(:result).round(1)
  end

  def win_rate trades
    (trades.where('result > 0').count.to_f / trades.count.to_f * 100).round(1)
  end

  def largest_win trades
    trades.maximum(:result).round(2)
  end

  def largest_loss trades
    trades.minimum(:result).round(2)
  end
end
