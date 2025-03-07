# MovieLens Project

## Project Overview
This project aims to develop an algorithm to predict movie ratings using the **MovieLens 10M dataset**. The algorithm is trained on the `edx` dataset and evaluated on the `final_holdout_test` dataset. The model performance is measured using **Root Mean Square Error (RMSE)**.

## Libraries and Dataset
### Required Libraries
- `tidyverse` (for data manipulation and visualization)
- `caret` (for machine learning model training and evaluation)

### Dataset
- **MovieLens 10M Dataset**: Automatically downloaded and extracted if not available.
- The dataset is processed, merged, and split into `edx` (training) and `final_holdout_test` (evaluation) datasets.

## Data Visualization
The project includes the following visualizations:
- **Distribution of Movie Ratings**: Histogram of ratings across all movies.
- **Average Movie Ratings by Genre**: Analysis of how ratings differ across genres.
- **Average Movie Ratings Over Time**: Trend analysis of ratings over time.

## Methods & Analysis
### Splitting the Dataset
- The `edx` dataset is split into **training (80%)** and **testing (20%)** sets to validate model performance.

### Model Development
Four models are implemented and evaluated:
1. **Naive Model**: Predicts all ratings as the global average rating.
2. **Movie Effect Model**: Adjusts predictions based on each movie's average rating deviation.
3. **Movie + User Effect Model**: Further refines predictions by incorporating user rating biases.
4. **Regularized Movie + User Effect Model**: Uses **regularization** to reduce overfitting by penalizing extreme values.

## Results
- Model performance is evaluated using **RMSE**, with lower values indicating better accuracy.
- The **Regularized Movie + User Effect Model** achieves the best RMSE, demonstrating the benefits of regularization in improving rating predictions.

## Conclusion
This project successfully developed an algorithm to predict movie ratings using the **MovieLens 10M dataset**. Future enhancements could include:
- Incorporating additional features (e.g., **movie genres, timestamps, and user demographics**).
- Exploring **advanced machine learning techniques**, such as **matrix factorization and deep learning**.

## References
- Irizarry, R. A. (2020). [Introduction to Data Science](https://rafalab.github.io/dsbook/introduction-to-machine-learning.html#notation-1)
- Harper, F. M., & Konstan, J. A. (2016). [The MovieLens Datasets: History and Context](https://dl.acm.org/doi/10.1145/2827872) ACM Transactions on Interactive Intelligent Systems (TiiS), 5(4), 1–19.
- Ricci, F., Rokach, L., Shapira, B., & Kantor, P. B. (2011). [Recommender Systems Handbook](https://link.springer.com/book/10.1007/978-0-387-85820-3) Springer.
- Adomavicius, G., & Tuzhilin, A. (2005). [Toward the Next Generation of Recommender Systems](https://ieeexplore.ieee.org/document/1423975) IEEE Transactions on Knowledge and Data Engineering, 17(6), 734–749.

---
### **How to Run the Project**
1. Clone the repository:
   ```sh
   git clone https://github.com/AnalyticTolu/movielens-project.git
   cd movielens-project
   ```
2. Install dependencies in R:
   ```r
   install.packages(c("tidyverse", "caret", "lubridate"))
   ```
3. Run the R script:
   ```r
   source("HavardX movielens Project.R")
   ```

