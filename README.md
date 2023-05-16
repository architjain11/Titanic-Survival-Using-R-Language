# Titanic Survival Prediction and Visualization using R Language

## Project Overview

The Titanic dataset is a well-known dataset, which contains information about the passengers who were on board the Titanic when it sank. The dataset provides a rich source of information for data analysts and machine learning enthusiasts to build models that predict survival rates of passengers. In this project, R language and Rstudio were used to predict the survival rate of passengers and create various data visualizations. The project begins by importing the Titanic dataset into Rstudio. The dataset is cleaned and preprocessed, ensuring that there are no missing values or irrelevant data. The data is then split into two subsets, a training set and a test set. The training set is used to train the machine learning model (Random Forest) and the test set is used to evaluate the model's performance. Once the model is trained, it is used to predict the survival rate of the test set. The predictions are then compared to the actual survival status of the passengers, and the model's accuracy is calculated. Data is further explored using ggplot2 library to create colourful visualizations. A scatter plot is used to visualize the relationship between age and fare, a bar plot is used to show the number of survivors and non-survivors in each passenger class, and many more such visualizations. The entire system works in a clean menu-driven format which displays all necessary information as and when requested by the user.

## Screenshots

A menu-driven interface is visible on which we can select the appropriate option.

Choice 1 makes prediction on a new passenger about their survival rate using the model.

   ![Choice 1](/screenshots/choice1.png)
---

Choice 2 displays the model used and it's accuracy.

   ![Choice 2](/screenshots/choice2.png)
---

Choice 3 gives a menu for various different visualizations using ggplot2 library.

   ![Choice 3](/screenshots/choice3.png)
   ![Plots](/visualizations/plots.jpg)
---

Choice 4 displays creator information and project details.

   ![Choice 4](/screenshots/choice4.png)
