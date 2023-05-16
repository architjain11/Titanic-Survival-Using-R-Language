suppressWarnings({
# Load the required library
library(randomForest)
library(ggplot2)

# options(warn=-1)

# Load the Titanic dataset
titanic_data <- read.csv("train.csv")

# Convert the "Survived" column to a factor
titanic_data$Survived <- as.factor(titanic_data$Survived)

# Remove the rows with missing values
titanic_data <- titanic_data[complete.cases(titanic_data), ]


# Train the random forest model on COMPLETE ORIGINAL DATASET
model <- randomForest(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare, data = titanic_data, ntree = 100)

predict_survival <- function(model, new_sample) {
  survival_prediction <- predict(model, newdata = new_sample, type = "prob")
  cat(survival_prediction)
  return(ifelse(survival_prediction[, 2] > 0.6, "Yes", "No"))
}

# Predict the survival of a new sample data
new_sample <- data.frame(Pclass = 3, Sex = "male", Age = 50, SibSp = 0, Parch = 0, Fare = 7.25)
print(paste("Survival Prediction:", predict_survival(model, new_sample)))

printAccuracy <- function() {
  # Split the data into training and test sets
  set.seed(123)
  train_index <- sample(1:nrow(titanic_data), 0.8 * nrow(titanic_data))
  train_data <- titanic_data[train_index, ]
  test_data <- titanic_data[-train_index, ]

  # Train the random forest model on the TRAINING DATA
  testmodel <- randomForest(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare, data = train_data, ntree = 100)

  # Evaluate the model on the test data
  predictions <- predict(testmodel, newdata = test_data)

  # Calculate the accuracy of the model
  accuracy <- mean(predictions == test_data$Survived)
  cat("Machine Learning Algorithm: Random Forest\n")
  cat("Accuracy: ")
  cat(accuracy)
  cat("\n")
}

display_visualizations <- function() {
  cat("Visualizations:\n")
  cat("1. Class vs Survived\n")
  cat("2. Sex vs Survived\n")
  cat("3. Age vs Survived\n")
  cat("4. Fare vs Survived\n")
  cat("5. Parch vs Fare as Scatter Plot\n")
  cat("6. Class vs Fare respresented as Jitter Points\n")
  cat("7. Age vs Fare as Scatter Plot\n")
  cat("8. SibSb vs Survived as Histogram Plot\n")
  choice <- readline("Enter your choice: ")
  if (choice == 1) {
    ggplot(titanic_data, aes(x = Pclass, fill = Survived)) +
      geom_bar(position = "dodge") +
      scale_fill_manual(values = c("#0000FF", "#FF0000")) +
      ggtitle("Class vs Survived")
    print(last_plot())
  } else if (choice == 2) {
    ggplot(titanic_data, aes(x = Sex, fill = Survived)) +
      geom_bar(position = "dodge") +
      scale_fill_manual(values = c("#0000FF", "#FF0000")) +
      ggtitle("Sex vs Survived")
    print(last_plot())
  } else if (choice == 3) {
    ggplot(titanic_data, aes(x = Age, fill = Survived)) +
      geom_histogram(binwidth = 5, color = "black", fill = "#0000FF") +
      scale_fill_manual(values = c("#0000FF", "#FF0000")) +
      ggtitle("Age vs Survived")
    print(last_plot())
  } else if (choice == 4) {
    ggplot(titanic_data, aes(x = Fare, fill = Survived)) +
      geom_histogram(binwidth = 5, color = "black", fill = "#0000FF") +
      scale_fill_manual(values = c("#0000FF", "#FF0000")) +
      ggtitle("Fare vs Survived")
    print(last_plot())
  } else if (choice == 5) {
    ggplot(data = titanic_data, aes(x = Parch, y = Fare)) +
      geom_point() +
      scale_x_continuous(limits = c(0, 6), expand = c(0, 0)) +
      scale_y_continuous(limits = c(0, 600), expand = c(0, 0)) +
      ggtitle("Relationship between Parch and Fare") +
      xlab("Number of Parents/Children") +
      ylab("Fare Paid")
    print(last_plot())
  } else if (choice == 6) {
    ggplot(data = titanic_data, aes(x = Pclass, y = Fare)) +
      geom_jitter(width = 0.2, height = 0.2, alpha = 0.5) +
      scale_x_continuous(limits = c(1, 3), expand = c(0, 0)) +
      scale_y_continuous(limits = c(0, 600), expand = c(0, 0)) +
      ggtitle("Relationship between Pclass and Fare") +
      xlab("Passenger Class") +
      ylab("Fare")
    print(last_plot())
  } else if (choice == 7) {
    ggplot(titanic_data, aes(x = Age, y = Fare)) +
      geom_point(alpha = 0.5) +
      ggtitle("Age vs Fare")
    print(last_plot())
  } else if (choice==8) {
    ggplot(data = titanic_data, aes(x = SibSp, fill = as.factor(Survived))) +
      geom_histogram(position = "fill", binwidth = 1) +
      scale_x_continuous(limits = c(0, 10), expand = c(0, 0)) +
      scale_y_continuous(limits = c(0, 1), expand = c(0, 0)) +
      scale_fill_manual(values = c("#2ca02c", "#d62728")) +
      ggtitle("Relationship between SibSp and Survived") +
      xlab("Number of Siblings/Spouses") +
      ylab("Proportion of Passengers")
    print(last_plot())
  } else {
    cat("\nInvalid choice. Please try again.\n")
  }
}

cat("\nTITANIC SURVIVAL PREDICTION AND DATA VISUALIZATION\n")
while (TRUE) {
  cat("\nMain Menu:\n")
  cat("1. Make prediction of survival for new passenger\n")
  cat("2. Show details of the Machine Learning Model used\n")
  cat("3. Display visualizations\n")
  cat("4. View creator and project details\n")
  cat("5. Quit\n")
  choice <- readline("Enter your choice: ")
  if (choice == 1) {
    newdata <- data.frame(
      Pclass = as.integer(readline("Class:")),
      Sex = readline("Sex:"),
      Age = as.integer(readline("Age:")),
      SibSp = as.integer(readline("Siblings/Spouses:")),
      Parch = as.integer(readline("Parents/Children:")),
      Fare = as.numeric(readline("Fare:"))
    )
    print(paste("Survival Prediction:", predict_survival(model, newdata)))
  } else if(choice == 2) {
    printAccuracy()
  } else if (choice == 3) {
    display_visualizations()
  } else if (choice == 4) {
    cat("\nCreator: Archit Jain\n")
    cat("College: Netaji Subhas University of Technology\n")
    cat("Course: Computer Engineering\n")
    cat("Batch: 2020-24\n")
    cat("Project Overview: The aim of the project is to use Random Forest Machine Learning algorithm to train our program to predict the probability of survival of a passenger during the Titanic tragedy. The threshold used for prediction is 0.6.\n")
    cat("Dataset used: Dataset used here is the famous \"Titanic- Machine Learning from Disaster\" dataset from Kaggle\n")
  } else if (choice == 5) {
    cat("\nExiting program...\n")
    break
  } else {
    cat("\nInvalid choice. Please try again.\n")
  }
}


})