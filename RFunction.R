library('move')
library('move2')

## The parameter "data" is reserved for the data object passed on from the previous app

## to display messages to the user in the log file of the App in MoveApps one can use the function from the logger.R file: 
# logger.fatal(), logger.error(), logger.warn(), logger.info(), logger.debug(), logger.trace()

rFunction = function(data) {
  #mt object can have length 0, movestack/move object not (i.e. NULL)
  if (dim(data)[1]==0) result <- NULL else { 
    result <- to_move(data)
    if (is(result,'Move')) result <- moveStack(result,forceTz=attr(timestamps(result),"tzone"))
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
