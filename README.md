This project aims to develop an algorithm to predict movie ratings using the MovieLens 10M dataset. The algorithm will be trained on the `edx` dataset and evaluated on the `final_holdout_test` dataset. Performance will be measured using Root Mean Square Error (RMSE).

Libraries and Dataset

The necessary libraries for this project are `tidyverse` and `caret`. The MovieLens 10M dataset is downloaded and unzipped if not already available. The dataset is then loaded, merged, and split into the `edx` and `final_holdout_test` datasets.

Data Visualization

The following visualizations are included:
- Distribution of movie ratings
- Average movie ratings by genre
- Average movie ratings over time

Methods/Analysis

Splitting the Dataset

The `edx` dataset is split into training and testing sets.

Model Development

Four models are developed and evaluated:
1. Naive Model: Predicts the average rating for all movies.
2. Movie Effect Model: Considers the average rating for each movie.
3. Movie + User Effect Model: Considers both movie and user effects.
4. Regularized Movie + User Effect Model: Applies regularization to movie and user effects.

Results

The performance of each model is evaluated using RMSE, with the Regularized Movie + User Effect Model showing the best performance.

Conclusion

The project successfully developed an algorithm to predict movie ratings using the MovieLens 10M dataset. Future improvements could include incorporating additional features and advanced machine learning techniques.

References

- Irizarry, R. A. (2020). Introduction to Data Science. Retrieved from [Introduction to Data Science](https://rafalab.github.io/dsbook/introduction-to-machine-learning.html#notation-1)
- Harper, F. M., & Konstan, J. A. (2016). The MovieLens Datasets: History and Context. ACM Transactions on Interactive Intelligent Systems (TiiS), 5(4), 1–19. [The MovieLens Datasets: History and Context](https://dl.acm.org/doi/10.1145/2827872)
- Ricci, F., Rokach, L., Shapira, B., & Kantor, P. B. (2011). Recommender Systems Handbook. Springer. [Recommender Systems Handbook](https://link.springer.com/book/10.1007/978-0-387-85820-3)
- Adomavicius, G., & Tuzhilin, A. (2005). Toward the next generation of recommender systems: A survey of the state-of-the-art and possible extensions. IEEE Transactions on Knowledge and Data Engineering, 17(6), 734–749. [Toward the next generation of recommender systems](https://ieeexplore.ieee.org/document/1423975)
