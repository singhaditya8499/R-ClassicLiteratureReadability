source('data.R')

books_by_download <- books %>% arrange(desc(downloads))
# books_by_download

books_refined <- books_by_download %>% select(author,title,words,syllables,sentences)
top_ten_authors <- books_refined %>% head(10) %>% pull(author)