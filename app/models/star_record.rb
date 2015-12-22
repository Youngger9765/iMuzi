class StarRecord < ActiveRecord::Base

  belongs_to :user

  def self.monthly_star
    where("created_at > ? AND action =?",  Time.current.advance(months: -1), "add_monthly_star")
  end

  def self.overtime_star
    where("created_at < ? AND status is ? ",  Time.current.advance(months: -1), nil).where( action: ["add_free_star","add_monthly_star"])
  end

end
