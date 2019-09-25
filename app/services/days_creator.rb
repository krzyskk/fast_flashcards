# frozen_string_literal: true
class DaysCreator
  attr_reader :end_date, :user

  def initialize(user)
    @user = user
  end

  def call
    # start_date  = user.days.present? ? user.days.last.date : Date.today.beginning_of_month
    start_date  = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    generate_missing_days(start_date, end_date)
  end

  private

  def generate_missing_days(start_date, end_date)
    (start_date..end_date).each do |day_date|
      day = Day.find_or_create_by(user: user, date: day_date.beginning_of_day)
      user.habits.active.each do |habit|
        Result.find_or_create_by(day: day, habit: habit)
      end
    end
  end
end
  