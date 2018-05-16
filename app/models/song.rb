class Song < ActiveRecord::Base
  validates :title, presence: true
  #validates :title, uniqueness: true, if: :artist_name_not_duplicate_in_same_year
  validates :release_year, presence: true, if: :released
  validates :artist_name, presence: true
  validate :release_year_cannot_be_after_current_year
  validate :title_author_name_not_duplicate_in_same_year

  def title_author_name_not_duplicate_in_same_year
    if title.present? && !title.uniq
      errors.add(:title, "can't be released by same artist in same year") 
    end
  end

  def release_year_cannot_be_after_current_year
    if release_year.present? && release_year > Date.today.year
      errors.add(:release_year, "can't be in the future")
    end
  end
end
