# Principles of Data Analytics Project: Air Traffic Passenger Data Analysis

## Problem Statements
The analysis of air traffic passenger data provides valuable insights into trends, behaviors, and patterns in aviation, which can help airlines optimize operations, improve passenger experiences, and predict future demand. This project aims to develop a data-driven approach for predicting passenger counts and activity types using machine learning algorithms.

## Project Overview
This project leverages R for data preprocessing, exploratory data analysis (EDA), and predictive modeling using machine learning. It involves the following steps:
- **Data Preprocessing:** The dataset undergoes cleaning, handling missing values, and encoding categorical variables.
- **Exploratory Data Analysis (EDA):** Visualizations and statistical analysis are performed to understand the data and detect trends.
- **Predictive Modeling:** A Naïve Bayes model is trained on the data to predict passenger activity types, such as "Enplaned", "Deplaned", or "Transit".
  
The purpose of the project is to provide insights into air traffic data and create a model that can predict the type of activity for a given passenger, based on various features. The results can help airlines, airport authorities, and transportation planners optimize operations and improve efficiency.

## Key Features
- Data cleaning and preprocessing techniques.
- Visualizations for understanding passenger counts across various regions.
- Machine learning model built using Naïve Bayes to predict passenger activity types.
- Correlation analysis and insights to understand the relationships between various regions and activity types.
- Exploratory data analysis using plots like bar charts, boxplots, and correlation matrices.

## Technologies Used
- **R** - Programming language for statistical computing and graphics.
- **dplyr** - Data manipulation package.
- **ggplot2** - Visualization library for creating static plots.
- **caret** - Package for training and evaluating machine learning models.
- **e1071** - Library for Naïve Bayes implementation.
- **Hmisc & corrplot** - Used for correlation and visualization.

## Data Preparation
### Data Preparation and Preprocessing
1.  **Original Dataset:**
    <p align="center">
    <img src="readme-assets/01 Original Dataset.png" alt="original dataset"/>
    <br>
    <i>Figure 1: Original dataset</i>
    </p>

2.  **Dataframe that Have Undergone Preprocessing:**
    <p align="center">
    <img src="readme-assets/02 Dataframe that Have Undergone Preprocessing.png" alt="dataframe that have undergone preprocessing"/>
    <br>
    <i>Figure 2: Dataframe that have undergone preprocessing</i>
    </p>

    Figure 1 shows the data read from csv and stored into dataframe, df. It contains 15007 entries with 16 columns. Figure 2 shows the dataframe df that have undergone preprocessing. It has 367 entries with 8 total columns now.

3.  **Locations and Total Numbers of Missing Values:**
    <table>
    <tr>
        <td style="text-align: center;">
        <img src="readme-assets/03 Locations and Total Numbers of Missing Values.png" alt="locations and total numbers of missing values 2"/>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/03 Locations and Total Numbers of Missing Values 2.png" alt="boxplot for the housing value prices by months for rent" />
        </td>
    </tr>
    </table>
    <p align="center">
        <i>Figure 3: Locations and total numbers of missing values</i>
    </p>

4.  **Structure of the Dataframe Before Preprocessing:**
    <p align="center">
    <img src="readme-assets/04 Structure of the Dataframe Before Preprocessing.png" alt="structure of the dataframe before preprocessing"/>
    <br>
    <i>Figure 4: Structure of the dataframe before preprocessing</i>
    </p>

5.  **Structure of the Dataframe After Preprocessing:**
    <p align="center">
    <img src="readme-assets/05 Structure of the Dataframe After Preprocessing.png" alt="structure of the dataframe after preprocessing"/>
    <br>
    <i>Figure 5: Structure of the dataframe after preprocessing</i>
    </p>

6.  **First Few Rows of the Dataframe for df3, Training_Set and Test_Set:**
    <p align="center">
    <img src="readme-assets/06 First Few Rows of the Dataframe for df3, Training_Set and Test_Set.png" alt="first few rows of the dataframe for df3, training_set and test_set"/>
    <br>
    <i>Figure 6: First few rows of the dataframe for df3, training_set and test_set</i>
    </p>

7.  **Summary of the Dataframe for df3, Training_Set and Test_Set:**
    <p align="center">
    <img src="readme-assets/07 Summary of the Dataframe for df3, Training_Set and Test_Set.png" alt="summary of the dataframe for df3, training_set and test_set"/>
    <br>
    <i>Figure 7: Summary of the dataframe for df3, training_set and test_set</i>
    </p>

8.  **Training Set for Air_Traffic_Passenger_Data After Preprocessing:**
    <p align="center">
    <img src="readme-assets/08 Training Set for Air_Traffic_Passenger_Data After Preprocessing.png" alt="training set for air_traffic_passenger_data after preprocessing"/>
    <br>
    <i>Figure 8: Training set for air_traffic_passenger_data after preprocessing</i>
    </p>
    Figure 8 shows the training set. It has 309 entries with 8 columns.

9.  **Test Set for Air_Traffic_Passenger_Data After Preprocessing:**
    <p align="center">
    <img src="readme-assets/09 Test Set for Air_Traffic_Passenger_Data After Preprocessing.png" alt="test set for air_traffic_passenger_data after preprocessing"/>
    <br>
    <i>Figure 9: Test set for air_traffic_passenger_data after preprocessing</i>
    </p>
    Figure 9 shows the test set. It has 78 entries with 8 columns. The preprocessed dataframe is split into training and test set with the ratio of 0.8 and 0.2 respectively.

### Exploratory Data Analysis (EDA)
1.  **Barplot for the Passengers Count of All Activities for Asia:**
    <p align="center">
    <img src="readme-assets/10 Barplot for the Passengers Count of All Activities for Asia.png" alt="barplot for the passengers count of all activities for asia"/>
    <br>
    <i>Figure 10: Barplot for the passengers count of all activities for asia</i>
    </p>

2.  **Boxplot for the Passengers Count by Activity Period for Deplaned, Enplaned and Transit:**
    <table>
    <tr>
        <td style="text-align: center;">
        <img src="readme-assets/11 Boxplot for the Passengers Count by Activity Period for Deplaned.png" alt="boxplot for the passengers count by activity period for deplaned"/>
        <br>
        <i>Figure 11: Boxplot for the passengers count by activity period for deplaned</i>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/12 Boxplot for the Passengers Count by Activity Period for Enplaned.png" alt="boxplot for the passengers count by activity period for enplaned"/>
        <br>
        <i>Figure 12: Boxplot for the passengers count by activity period for enplaned</i>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/13 Boxplot for the Passengers Count by Activity Period for Transit.png" alt="boxplot for the passengers count by activity period for transit"/>
        <br>
        <i>Figure 13: Boxplot for the passengers count by activity period for transit</i>
        </td>
    </tr>
    </table>

3.  **Correlation Value and the p-value of All Activity Type, Deplaned, Enplaned and Transit:**
    <table>
    <tr>
        <td style="text-align: center;">
        <img src="readme-assets/14 Correlation Value and the p-value of All Activity Type.png" alt="correlation value and the p-value of all activity type"/>
        <br>
        <i>Figure 14: Correlation value and the p-value of all activity type</i>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/15 Correlation Value and the p-value of Deplaned.png" alt="correlation value and the p-value of deplaned"/>
        <br>
        <i>Figure 15: Correlation value and the p-value of deplaned</i>
        </td>
    </tr>
    <tr>
        <td style="text-align: center;">
        <img src="readme-assets/16 Correlation Value and the p-value of Enplaned.png" alt="correlation value and the p-value of enplaned"/>
        <br>
        <i>Figure 16: Correlation value and the p-value of enplaned</i>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/17 Correlation Value and the p-value of Transit.png" alt="correlation value and the p-value of transit"/>
        <br>
        <i>Figure 17: Correlation value and the p-value of transit</i>
        </td>
    </tr>
    </table>

4.  **Correlation Plot for the Passengers Count of All Activity Type:**
    <table>
    <tr>
        <td style="text-align: center;">
        <img src="readme-assets/18 Correlation Plot for the Passengers Count of All Activity Type.png" alt="correlation plot for the passengers count of all activity type"/>
        <br>
        <i>Figure 18: Correlation plot for the passengers count of all activity type</i>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/19 Correlation Plot for the Passengers Count of Deplaned.png" alt="correlation plot for the passengers count of deplaned"/>
        <br>
        <i>Figure 19: Correlation plot for the passengers count of deplaned</i>
        </td>
    </tr>
    <tr>
        <td style="text-align: center;">
        <img src="readme-assets/20 Correlation Plot for the Passengers Count of Enplaned.png" alt="correlation plot for the passengers count of enplaned"/>
        <br>
        <i>Figure 20: Correlation plot for the passengers count of enplaned</i>
        </td>
        <td style="text-align: center;">
        <img src="readme-assets/21 Correlation Plot for the Passengers Count of Transit.png" alt="correlation plot for the passengers count of transit"/>
        <br>
        <i>Figure 21: Correlation plot for the passengers count of transit</i>
        </td>
    </tr>
    </table>

## Prediction of Passengers Enplaned, Deplaned or Thru-Transit using Naïve Bayes Classification

**Naïve Bayes Classification Result:**
<p align="center">
<img src="readme-assets/22 Naive Bayes Classification Result.png" alt="naive bayes classification result"/>
<br>
<i>Figure 22: Naïve bayes classification result</i>
</p>

For prediction of enplaned, deplaned or thru-transit, we are using Naïve Bayes classifiers because  it  is  easier  and  execute  efficiently  without  prior  knowledge  of  the  data.  The performance of the Naïve Bayes classifier can be evaluated by accuracy and confusion matrix. From  result  in  above  figure,  the  model  achieved  65.38%  accuracy  with  a  p-value  of 0.000007354. We can conclude that our Naïve Bayes classifier still need to be improved. 