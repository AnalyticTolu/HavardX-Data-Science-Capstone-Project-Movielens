# Load Required Libraries
if(!require(tidyverse)) install.packages("tidyverse", repos = 'http://cran.us.r-project.org')
if(!require(caret)) install.packages("caret", repos = 'http://cran.us.r-project.org')
if(!require(lubridate)) install.packages("lubridate", repos = 'http://cran.us.r-project.org')

library(tidyverse)
library(caret)
library(lubridate)

# Download and Load the MovieLens 10M dataset
options(timeout = 600)
dl <- 'ml-10M100K.zip'
if(!file.exists(dl)) download.file('https://files.grouplens.org/datasets/movielens/ml-10m.zip', dl)

# Define file paths
ratings_file <- 'ml-10M100K/ratings.dat'
movies_file <- 'ml-10M100K/movies.dat'

# Unzip files if not already unzipped
if(!file.exists(ratings_file)) unzip(dl, ratings_file)
if(!file.exists(movies_file)) unzip(dl, movies_file)

# Load Ratings Data
ratings <- as.data.frame(str_split(read_lines(ratings_file), fixed('::'), simplify = TRUE), stringsAsFactors = FALSE)
colnames(ratings) <- c('userId', 'movieId', 'rating', 'timestamp')
ratings <- ratings %>% mutate(userId = as.integer(userId), movieId = as.integer(movieId), rating = as.numeric(rating), timestamp = as.integer(timestamp))

# Load Movies Data
movies <- as.data.frame(str_split(read_lines(movies_file), fixed('::'), simplify = TRUE), stringsAsFactors = FALSE)
colnames(movies) <- c('movieId', 'title', 'genres')
movies <- movies %>% mutate(movieId = as.integer(movieId))

# Merge Ratings and Movies Data
movielens <- left_join(ratings, movies, by = 'movieId')

# Create final hold-out test set (10% of MovieLens data)
set.seed(1, sample.kind = 'Rounding') 
test_index <- createDataPartition(y = movielens$rating, times = 1, p = 0.1, list = FALSE)
edx <- movielens[-test_index,]
temp <- movielens[test_index,]

# Ensure userId and movieId in final hold-out test set are also in edx set
final_holdout_test <- temp %>% semi_join(edx, by = 'movieId') %>% semi_join(edx, by = 'userId')

# Add removed rows back into edx set
removed <- anti_join(temp, final_holdout_test)
edx <- rbind(edx, removed)

rm(dl, ratings, movies, test_index, temp, movielens, removed)

# Convert timestamp to date
edx <- edx %>% mutate(date = as_datetime(timestamp))

# Data Visualization
## Ratings Distribution
edx %>% ggplot(aes(x = rating)) + geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black") + labs(title = "Distribution of Movie Ratings", x = "Rating", y = "Count") + theme_minimal()

## Ratings Over Time
edx_sample <- edx %>% sample_n(1000)
edx_sample %>% ggplot(aes(x = date, y = rating)) + geom_jitter(alpha = 0.3, size = 0.5) + geom_smooth(method = "loess", col = "blue") + labs(title = "Average Movie Ratings Over Time", x = "Date", y = "Rating") + theme_minimal()

# Model Development
## Splitting Data
set.seed(1, sample.kind = 'Rounding')
train_index <- createDataPartition(edx$rating, times = 1, p = 0.8, list = FALSE)
train_set <- edx[train_index,]
test_set <- edx[-train_index,]

## Naive Model
mu <- mean(train_set$rating)
naive_rmse <- RMSE(test_set$rating, mu)
print(naive_rmse)

## Movie Effect Model
movie_avgs <- train_set %>% group_by(movieId) %>% summarize(b_i = mean(rating - mu))
predicted_ratings <- test_set %>% left_join(movie_avgs, by = "movieId") %>% mutate(pred = mu + b_i) %>% .$pred
movie_effect_rmse <- RMSE(test_set$rating, predicted_ratings)
print(movie_effect_rmse)

## Movie + User Effect Model
user_avgs <- train_set %>% left_join(movie_avgs, by = "movieId") %>% group_by(userId) %>% summarize(b_u = mean(rating - mu - b_i))
predicted_ratings <- test_set %>% left_join(movie_avgs, by = "movieId") %>% left_join(user_avgs, by = "userId") %>% mutate(pred = mu + b_i + b_u) %>% .$pred
user_effect_rmse <- RMSE(test_set$rating, predicted_ratings)
print(user_effect_rmse)

## Regularized Movie + User Effect Model
lambda <- 5
b_i <- train_set %>% group_by(movieId) %>% summarize(b_i = sum(rating - mu) / (n() + lambda))
b_u <- train_set %>% left_join(b_i, by = "movieId") %>% group_by(userId) %>% summarize(b_u = sum(rating - mu - b_i) / (n() + lambda))
predicted_ratings <- test_set %>% left_join(b_i, by = "movieId") %>% left_join(b_u, by = "userId") %>% mutate(pred = mu + b_i + b_u) %>% .$pred
regularized_rmse <- RMSE(test_set$rating, predicted_ratings)
print(regularized_rmse)
