library('move')
library('move2')
library("dplyr")

## The parameter "data" is reserved for the data object passed on from the previous app

## to display messages to the user in the log file of the App in MoveApps one can use the function from the logger.R file: 
# logger.fatal(), logger.error(), logger.warn(), logger.info(), logger.debug(), logger.trace()

rFunction = function(data) {
  #mt object can have length 0, movestack/move object not (i.e. NULL)
  if (dim(data)[1]==0) result <- NULL else { 
    ## making sure tracks are orderes, timestamps are ordered and duplicate timestamps are removed in order to be able to create a movestack
    if(!mt_is_track_id_cleaved(data)){
      logger.info("Your data set was not grouped by individual/track. We regroup it for you.")
      data <- data |> dplyr::arrange(mt_track_id(data))
    }
    if(!mt_is_time_ordered(data)){
      logger.info("Your data is not time ordered (within the individual/track groups). We reorder the locations for you.")
      data <- data |> dplyr::arrange(mt_track_id(data),mt_time(data))
    }
    if (!mt_has_unique_location_time_records(data)){
      n_dupl <- length(which(duplicated(paste(mt_track_id(data),mt_time(data)))))
      logger.info(paste("Your data has",n_dupl, "duplicated location-time records. We removed here those with less info and then select the first if still duplicated."))
      ## this piece of code keeps the duplicated entry with least number of columns with NA values
      data <- data %>%
        mutate(n_na = rowSums(is.na(pick(everything())))) %>%
        arrange(n_na) %>%
        mt_filter_unique(criterion='first') # this always needs to be "first" because the duplicates get ordered according to the number of columns with NA. 
    }
    result <- moveStack(to_move(data))
  }
  return(result)
}

#data1 <- readRDS("./data/raw/input1_greylgeese.rds")
#saveRDS(mt_as_move2(data1),"./data/raw/input1_mt_greylgeese.rds")
#data2 <- readRDS("./data/raw/input2_whitefgeese.rds")
#saveRDS(mt_as_move2(data2),"./data/raw/input2_mt_whitefgeese.rds")
#data3 <- readRDS("./data/raw/input3_stork.rds")
#saveRDS(mt_as_move2(data3),"./data/raw/input3_mt_stork.rds")
#data4 <- readRDS("./data/raw/input4_goat.rds")
#saveRDS(mt_as_move2(data4),"./data/raw/input4_mt_goat.rds")
#data0 <- mt_as_move2(data3)[0,]
#saveRDS(data0,"./data/raw/input0_null.rds")
