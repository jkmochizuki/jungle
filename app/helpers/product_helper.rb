module ProductHelper
  def average_rating_stars(average_rating)
    if average_rating.nil?
      return "☆" * 5
    end
  
    full_stars = average_rating.to_i
    half_star = (average_rating - full_stars) >= 0.5
    empty_stars = 5 - (full_stars + (half_star ? 1 : 0))
  
    "★" * full_stars + (half_star ? "★" : "") + "☆" * empty_stars
  end
  
end
