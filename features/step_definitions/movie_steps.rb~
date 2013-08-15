# Add a declarative step here for populating the DB with movies.

Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, movie_director|
  movie_details_html = find("div#main").text
  assert movie_details_html.include? movie_title
  assert movie_details_html.include? movie_director
end
