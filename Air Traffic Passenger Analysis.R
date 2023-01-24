##### Part 1: Data Preprocessing #####

### Step 1: Importing the dataset

# Set the working directory
# setwd("")

# Read a CSV files using read.csv() function
df <- read.csv("Air_Traffic_Passenger_Data.csv")

### Step 2: Remove Irrelevant Columns
# Identify whether there are any similar column
all(df$Operating.Airline == df$Published.Airline)
all(df$Operating.Airline.IATA.Code == df$Published.Airline.IATA.Code)
all(df$Activity.Type.Code == df$Adjusted.Activity.Type.Code)

# The column "Operating.Airline" is removed because it is not important
df = subset(df, select = -c(Operating.Airline))
# The column "Operating.Airline.IATA.Code" is removed because it is not important
df = subset(df, select = -c(Operating.Airline.IATA.Code))
# The column "Published.Airline" is removed because it is not important
df = subset(df, select = -c(Published.Airline))
# The column "Published.Airline.IATA.Code" is removed because it is not important
df = subset(df, select = -c(Published.Airline.IATA.Code))
# The column "GEO.Summary" is removed because it is not important
df = subset(df, select = -c(GEO.Summary))
# The column "Activity.Type.Code" is removed because it is not important
df = subset(df, select = -c(Activity.Type.Code))
# The column "Price.Category.Code" is removed because it is not important
df = subset(df, select = -c(Price.Category.Code))
# The column "Terminal" is removed because it is not important
df = subset(df, select = -c(Terminal))
# The column "Boarding.Area" is removed because it is not important
df = subset(df, select = -c(Boarding.Area))
# The column "Passenger.Count" is removed because it is not important
df = subset(df, select = -c(Passenger.Count))
# The column "Year" is removed because it is not important
df = subset(df, select = -c(Year))
# The column "Month" is removed because it is not important
df = subset(df, select = -c(Month))


### Step 3: Combine Rows that have similar attributes
# Split Adjusted.Activity.Type.Code into dfs
dfDeplaned <- subset(df, Adjusted.Activity.Type.Code == "Deplaned")
dfEnplaned <- subset(df, Adjusted.Activity.Type.Code == "Enplaned")
dfTransit  <- subset(df, Adjusted.Activity.Type.Code == "Thru / Transit * 2")

# To sum up all the Adjusted.Passenger.Count with the same 
# Activity.Period, GEO.Region and Adjusted.Activity.Type.Code
# p.s. please run packageVersion("dplyr") and ensure the version must be 1.0.10
# is.function(sum) if false run rm(sum) and try again
# run is.function(sum)
library(dplyr)
dfDeplaned <- dfDeplaned %>%
  dplyr::group_by(Activity.Period, GEO.Region, Adjusted.Activity.Type.Code) %>%
  dplyr::summarise(across(c(Adjusted.Passenger.Count), sum))
dfEnplaned <- dfEnplaned %>%
  dplyr::group_by(Activity.Period, GEO.Region, Adjusted.Activity.Type.Code) %>%
  dplyr::summarise(across(c(Adjusted.Passenger.Count), sum))
dfTransit <- dfTransit %>%
  dplyr::group_by(Activity.Period, GEO.Region, Adjusted.Activity.Type.Code) %>%
  dplyr::summarise(across(c(Adjusted.Passenger.Count), sum))

library(tidyverse)
dfDeplaned <- dfDeplaned[1:nrow(dfDeplaned), c(1,2,4)] %>%  spread(key=GEO.Region, value=Adjusted.Passenger.Count)
dfEnplaned <- dfEnplaned[1:nrow(dfEnplaned), c(1,2,4)] %>%  spread(key=GEO.Region, value=Adjusted.Passenger.Count)
dfTransit  <- dfTransit[1:nrow(dfTransit),   c(1,2,4)] %>%  spread(key=GEO.Region, value=Adjusted.Passenger.Count)


library(tibble)
dfDeplaned <- add_column(dfDeplaned, Adjusted.Activity.Type.Code = "Deplaned", .after = "Activity.Period")
dfEnplaned <- add_column(dfEnplaned, Adjusted.Activity.Type.Code = "Enplaned", .after = "Activity.Period")
dfTransit  <- add_column(dfTransit,  Adjusted.Activity.Type.Code = "Thru / Transit * 2", .after = "Activity.Period")

### Step 4: Handling the missing data
# Calculate the mean value for missing data
for(i in 3:ncol(dfDeplaned)){
  dfDeplaned[[i]] = ifelse(is.na(dfDeplaned[[i]]),
                           ave(dfDeplaned[[i]], FUN = function (x)mean(x, na.rm = TRUE)),
                           dfDeplaned[[i]])
}
for(i in 3:ncol(dfEnplaned)){
  dfEnplaned[[i]] = ifelse(is.na(dfEnplaned[[i]]),
                           ave(dfEnplaned[[i]], FUN = function (x)mean(x, na.rm = TRUE)),
                           dfEnplaned[[i]])
}
for(i in 3:ncol(dfTransit)){
  dfTransit[[i]] = ifelse(is.na(dfTransit[[i]]),
                          ave(dfTransit[[i]], FUN = function (x)mean(x, na.rm = TRUE)),
                          dfTransit[[i]])
}

# Since dfTransit does not have Central America, Middle East and South America, append NA to it
dfTransit <- add_column(dfTransit, "Central America" = NA, .after = "Canada")
dfTransit <- add_column(dfTransit, "Middle East" = NA, .after = "Mexico")
dfTransit <- add_column(dfTransit, "South America" = NA, .after = "Middle East")

df <- rbind(dfDeplaned, dfEnplaned, dfTransit)

# finds the locations of missing values
which(is.na(df))

# finds the count of missing values
sum(is.na(df))



# The column "Central America", "Middle East" and "South America" is removed because empty for Thru / Transit * 2
df = subset(df, select = -c(`Central America`))
df = subset(df, select = -c(`Middle East`))
df = subset(df, select = -c(`South America`))
dfDeplaned = subset(dfDeplaned, select = -c(`Central America`))
dfDeplaned = subset(dfDeplaned, select = -c(`Middle East`))
dfDeplaned = subset(dfDeplaned, select = -c(`South America`))
dfEnplaned = subset(dfEnplaned, select = -c(`Central America`))
dfEnplaned = subset(dfEnplaned, select = -c(`Middle East`))
dfEnplaned = subset(dfEnplaned, select = -c(`South America`))
dfTransit  = subset(dfTransit, select = -c(`Central America`))
dfTransit  = subset(dfTransit, select = -c(`Middle East`))
dfTransit  = subset(dfTransit, select = -c(`South America`))
which(is.na(df))
sum(is.na(df))

# Copy df into df3 because df is used in EDA while df3 is used in Feature Scaling
df3 <- df

### Step 5: Encoding categorical data
# To see the structure of the imported data
str(df3)

# Convert the data type into factor
df3$Adjusted.Activity.Type.Code = factor(df3$Adjusted.Activity.Type.Code,
                                        # levels = c(unique(df$Adjusted.Activity.Type.Code)),
                                        levels = c("Deplaned", "Enplaned", "Thru / Transit * 2"),
                                        labels = seq(1, length(unique(df3$Adjusted.Activity.Type.Code)), by=1)
                                        # labels = c(1,2,3)
                                        )
df3$Adjusted.Activity.Type.Code = as.factor(df3$Adjusted.Activity.Type.Code)


### Step 6: Splitting the dataset into the training and test set

library(caTools) # required library to split data
set.seed(123) # Setting the seed to obtain the same random splitting set
# returns true if observation goes to the Training set and 
# false if observation goes to the test set.
split = sample.split(df3$Adjusted.Activity.Type.Code, SplitRatio = 0.8)

#Creating the training set and test set separately
training_set = subset(df3, split == TRUE)
test_set = subset(df3, split == FALSE)


### Step 7: Feature scaling
training_set[, 3:8] = scale(training_set[, 3:8])
test_set[, 3:8] = scale(test_set[, 3:8])

# To see the structure of the dataframe (after)
str(df3)

# View the first few rows of the dataset
head(df3)
head(training_set)
head(test_set)

# Print the summary of the imported data
summary(df3)
summary(training_set)
summary(test_set)

################################################################################
##### Part 2: Exploratory Data Analysis(EDA) #####
### Visualising the data:
ylabel = 'Passengers Count'
xlabel = 'Activity Period'

## a. Barplot for Deplaned:
titlelabel = 'Deplaned'
plot1 = ggplot(data=dfDeplaned,aes(x=reorder(Activity.Period,Asia),y=Asia,fill=x)) + 
  geom_bar(stat ='identity',aes(fill=Asia))+
  coord_flip() + 
  theme_grey() + 
  scale_fill_gradient(name="Passengers Count Level")+
  ggtitle(titlelabel)+
  ggeasy::easy_center_title()+
  theme(plot.title = element_text(face = "bold"))+
  labs(y=ylabel,x=xlabel) +
  geom_hline(yintercept = mean(dfDeplaned$Asia),size = 1, color = 'blue')
## a. Barplot for Enplaned:
titlelabel = 'Enplaned'
plot2 = ggplot(data=dfEnplaned,aes(x=reorder(Activity.Period,Asia),y=Asia,fill=x)) + 
  geom_bar(stat ='identity',aes(fill=Asia))+
  coord_flip() + 
  theme_grey() + 
  scale_fill_gradient(name="Passengers Count Level")+
  ggtitle(titlelabel)+
  ggeasy::easy_center_title()+
  theme(plot.title = element_text(face = "bold"))+
  labs(y=ylabel,x=xlabel) +
  geom_hline(yintercept = mean(dfEnplaned$Asia),size = 1, color = 'blue')
## a. Barplot for Transit:
titlelabel = 'Transit'
plot3 = ggplot(data=dfTransit,aes(x=reorder(Activity.Period,Asia),y=Asia,fill=x)) + 
  geom_bar(stat ='identity',aes(fill=Asia))+
  coord_flip() + 
  theme_grey() + 
  scale_fill_gradient(name="Passengers Count Level")+
  ggtitle(titlelabel)+
  ggeasy::easy_center_title()+
  theme(plot.title = element_text(face = "bold"))+
  labs(y=ylabel,x=xlabel) +
  geom_hline(yintercept = mean(dfTransit$Asia),size = 1, color = 'blue')
# To combine all the plots on the same diagram:
library(gridExtra)
library(ggpubr)
grid.arrange(plot1, plot2, plot3, nrow = 1,
             top = text_grob('Barplot for the Passenger Count of All Activities for Asia', face = "bold"),
             bottom = ''
)

## b. Separated Boxplot:
df4 = df[,c(1,2,3,4,5,6,7,8)] %>%   # select relevant columns 
  pivot_longer(c(3,4,5,6,7,8),names_to = 'GEO Region')
# Change the number in unique(df4$Adjusted.Activity.Type.Code)[] to toggle between Deplaned, Enplaned and Transit
# Deplaned is [1]; Enplaned is [2]; Transit is [3]
activityType = unique(df4$Adjusted.Activity.Type.Code)[2]
titlelabel = paste('Boxplot for the Passengers Count by Activity Period for', activityType)
ggplot(data = filter(df4,Adjusted.Activity.Type.Code==activityType), aes(x=`GEO Region`,y=value, color=`GEO Region`)) +
  geom_boxplot()+
  scale_color_brewer(palette="Dark2") + 
  geom_jitter(shape=16, position=position_jitter(0.2))+
  ggtitle(titlelabel)+
  ggeasy::easy_center_title()+
  theme(plot.title = element_text(face = "bold"))+
  labs(y=ylabel,x=xlabel)

## b. Combined Boxplot:
titlelabel = 'Boxplot for the Passengers Count by Activity Period for All the Activity Types'
ggplot(data = df4, aes(x=`GEO Region`,y=value, color=`GEO Region`)) + 
  geom_boxplot()+
  scale_fill_brewer(palette="Dark2") + 
  geom_jitter(shape=16, position=position_jitter(0.2))+
  ggtitle(titlelabel)+
  ggeasy::easy_center_title()+
  theme(plot.title = element_text(face = "bold"))+
  labs(y=ylabel,x=xlabel)+
  facet_wrap(~Adjusted.Activity.Type.Code,nrow = 1)

## c. Correlation Plot:
library("Hmisc")
library(corrplot)
# Run this statement if you want all corrplot to be displayed together
par(mfrow=c(2,2))

res = cor(df[,-1:-2]) # -1:-2 here means we look at all columns except the first two columns
res
res2 <- rcorr(as.matrix(df[,-1:-2]))
res2
corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45, mar=c(0,0,2,0), title = "Correlation Plot for the Passengers Count of All Activity Type")

res = cor(dfDeplaned[,-1:-2]) # -1:-2 here means we look at all columns except the first two columns
res
res2 <- rcorr(as.matrix(dfDeplaned[,-1:-2]))
res2
corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45, mar=c(0,0,2,0), title = "Correlation Plot for the Passengers Count of Deplaned")

res = cor(dfEnplaned[,-1:-2]) # -1:-2 here means we look at all columns except the first two columns
res
res2 <- rcorr(as.matrix(dfEnplaned[,-1:-2]))
res2
corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45, mar=c(0,0,2,0), title = "Correlation Plot for the Passengers Count of Enplaned")

res = cor(dfTransit[,-1:-2]) # -1:-2 here means we look at all columns except the first two columns
res
res2 <- rcorr(as.matrix(dfTransit[,-1:-2]))
res2
corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45, mar=c(0,0,2,0), title = "Correlation Plot for the Passengers Count of Transit")


#############################################################
##### Part 3: Naive Bayes #####
library(e1071)
library(caret)
library(caTools)
library(ggplot2)
library(lattice)
# Build a naïve Bayes classifier
nbModel <- naiveBayes(Adjusted.Activity.Type.Code ~.,data = training_set)
# View the model
nbModel

# Prediction using testing dataset
prediction <- predict(nbModel, newdata = test_set)
# Create a confusion matrix
cm <- confusionMatrix(prediction, test_set$Adjusted.Activity.Type.Code)
print(cm)