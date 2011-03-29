class UserController < ApplicationController

  before_filter :authenticate_user!

  def dashboard
    @publishers = Publisher.where(:owner_id => current_user).order('created_at')
    @isbn_queue = Publication.where("(isbn10 IS NULL AND isbn13 IS NULL) AND publisher_id IN (?)",
      current_user.publisher_ids).order('created_at')
    @cip_queue = Publication.where("(cip = '' OR cip IS NULL) AND (isbn10 IS NOT NULL OR isbn13 IS NOT NULL) "+
      "AND publisher_id IN (?)", current_user.publisher_ids).order('updated_at')
    @completed_publications = Publication.where("(isbn10 IS NOT NULL OR isbn13 IS NOT NULL) AND " +
      "(cip <> '' OR cip IS NOT NULL) AND publisher_id IN (?)",
      current_user.publisher_ids).order('updated_at DESC').limit(15)
  end

  private

end
