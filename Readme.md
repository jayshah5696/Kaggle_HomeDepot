# Kaggle - Home Depot Product Search Relevance

Shoppers rely on Home Depot’s product authority to find and buy the latest products and to get timely solutions to their home improvement needs. From installing a new ceiling fan to remodeling an entire kitchen, with the click of a mouse or tap of the screen, customers expect the correct results to their queries – quickly. Speed, accuracy and delivering a frictionless customer experience are essential.

In this competition, Home Depot is asking Kagglers to help them improve their customers' shopping experience by developing a model that can accurately predict the relevance of search results.

Search relevancy is an implicit measure Home Depot uses to gauge how quickly they can get customers to the right products. Currently, human raters evaluate the impact of potential changes to their search algorithms, which is a slow and subjective process. By removing or minimizing human input in search relevance evaluation, Home Depot hopes to increase the number of iterations their team can perform on the current search algorithms.

### About the Project

This Project was first experience on working with text data. By working on this project, I got good grasp on working with text manipulation and building models with it.

![](https://media.giphy.com/media/8dYmJ6Buo3lYY/giphy.gif)

### Approch

#### Basic Text Pre-processing of text data
1. Lower casing
1. Punctuation removal
1. Stopwords removal
1. Frequent words removal
1. Spelling correction
1. Tokenization
1. Stemming
1. Lemmatization

#### Basic feature extraction using text data
1. Number of words
1. Number of characters
1. Average word length
1. Number of stopwords
1. Number of special characters
1. Number of numerics



### Results

Here, 2 Algorithms are implemented.

1. XGboost
2. Feed Forward Neaural Network

H2O API was not working, so NN is implemented in R.


We achieved RMSE score of - 0.47

![](https://media.giphy.com/media/l0Iyb1KcVIu4NpmXm/giphy.gif)


Please, Check out code. And your feedback is appriciated.
