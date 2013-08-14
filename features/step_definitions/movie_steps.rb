# Add a declarative step here for populating the DB with movies.

Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, movie_director|
  #movie_html = page.body.find().text
  #assert movie_page has_content(movie_title)
  #assert movie_page has_content(movie_director)
  assert page.body =~ /#{movie_title}.+Director.+#{movie_director}/m
end
