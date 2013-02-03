class Movie < ActiveRecord::Base

  @@all_ratings = ['G','PG', 'PG-13', 'R']
  @@saved_selections = {:sort => "title", :ratings => {'G' => 1, 'PG' => 1, 'PG-13' => 1, 'R' => 1}}

  def Movie.all_ratings
    @@all_ratings
  end

  def Movie.saved_selections
    @@saved_selections
  end

  def Movie.saved_selections=(ss)
    @@saved_selections = ss
  end

end
