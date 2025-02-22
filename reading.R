source('data.R')

books_by_download <- books %>% arrange(desc(downloads))
# books_by_download

books_refined <- books_by_download %>% select(author,title,words,syllables,sentences)
top_ten_authors <- books_refined %>% head(10) %>% pull(author)
# top_ten_authors

authors_books <- books_refined %>% filter(author %in% top_ten_authors) %>% arrange(author)
reading_ease <- authors_books %>% mutate(flesch_reading_ease = 206.835 - 1.015*(words / sentences) - 84.6*(syllables / words))
reading_grade <- reading_ease %>% mutate(flesch_kincaid_grade_level = 0.39*(words/sentences) + 11.8*(syllables/words) - 15.59)

reading_grouped <- reading_grade %>% group_by(author)

reading_summary <- reading_grouped %>% summarise(flesch_reading_ease = mean(flesch_reading_ease) , flesch_kincaid_grade_level = mean(flesch_kincaid_grade_level))
reading_long <- reading_summary %>% gather(type,score,flesch_reading_ease:flesch_kincaid_grade_level)


p <- ggplot(reading_long,aes(author,score)) + geom_bar(stat = 'identity')
p <- p + facet_grid(rows=vars(type))
p <- p + theme(axis.text.x = element_text(angle = 45,hjust = 1))
plot(p)
