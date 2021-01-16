books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]

authors = authors.map do |author|
  author.split(" ")[0].downcase
end

book_info = authors.inject({}) do |memo, author|
  memo[author.to_sym] = books[authors.index(author)]
  memo
end

puts book_info
