# Description on GitHub:
# {timevis} lets you create rich and fully interactive timeline visualizations in R.
# Timelines can be included in Shiny apps and R markdown documents, or viewed from the R console
# and RStudio Viewer. {timevis} includes an extensive API to manipulate a timeline after creation,
# and supports getting data out of the visualization into R. This package is based on the visjs
# Timeline JavaScript library.

# install.packages("timevis")
library(timevis)

# to create a timeline you basically just need a data.frame with at least six columns (id,content,start,end,group,type)
# for one example look below or on these websites: https://github.com/daattali/timevis or https://daattali.com/shiny/timevis-demo/
# for clarity I would suggest to designate each date with a name or number

timevisData <- data.frame(
  id = 1:32,
  content = c( 
    # sessions
    "Kick off & Unit 1",                         # 1
    "Unit 1",                                    # 2
    "Unit 2",                                    # 3
    "Unit 2",                                    # 4
    "Unit 3",                                    # 5
    "Unit 3",                                    # 6
    "Unit 3/4",                                  # 7
    "Unit 4",                                    # 8  
    "Unit 4",                                    # 9  
    "Unit 4 + Start team project",               # 10
   # "Built-in hold",                            
    "Unit 5: Concept discussion/presentation",   # 11
    "Unit 5: Team project",                      # 12
    "Unit 5: Team Project",                      # 13
    "Unit 5: Team project",                      # 14
    "Unit 5: Goodbye",                           # 15
   
   
    # self-learning 
    "LM + EX Unit 1",                            # 15
    "LM + EX Unit 2",                            # 16
    "LM + EX Unit 3",                            # 17
    "LM + EX Unit 4",                            # 18
    "Concept team project + Team project",       # 19
    "Team project",                              # 20
    # submission
    "Assignment Unit 1",                         # 21
    "Assignment Unit 2",                         # 22
    "Assignment Unit 03-1",                      # 23
    "Assignment Unit 03-2",                      # 24
    "Assignment Unit 04-1",                      # 25
    "Assignment Unit 04-2",                      # 26
    "Concept submission",                        # 27
    "Team project submission",                   # 28  
    # other
   # "Start lecture period",                      # 29
  #  "Christmas break",                           # 30
  #  "End lecture period",                        # 31
    "Grade announcement"                         # 32
    
  ),                                    
  start   = c(
    # sessions
    "2022-10-21 09:15:00",                       # 1
    "2022-10-28 09:15:00",                       # 2
    "2022-11-04 09:15:00",                       # 3
    "2022-11-11 09:15:00",                       # 4
    "2022-11-18 09:15:00",                       # 5
    "2022-11-25 09:15:00",                       # 6
    "2022-12-02 09:15:00",                       # 7
    "2022-12-09 09:15:00",                       # 8
    "2022-12-16 09:15:00",                       # 9
    "2022-12-23 09:15:00",                       # 10 
    "2022-01-13 09:15:00",                       # 11
    "2022-01-20 09:15:00",                       # 12
    "2022-01-27 09:15:00",                       # 13               
    "2022-02-03 09:15:00",                       # 14
    "2022-02-10 09:15:00",                       # 15
    
    
    # self-learning
    "2022-10-21 12:45:00",                       # 16
    "2022-11-04 12:45:00",                       # 17
    "2022-11-19 15:45:00",                       # 18
    "2022-12-03 15:45:00",                       # 19
    "2022-12-18 15:45:00",                       # 20
    "2023-01-21 15:45:00",                       # 21
    
    # submission
    "2021-11-04",                                # 22
    "2021-11-18",                                # 23
    "2021-11-25",                                # 24
    "2021-12-03",                                # 25
    "2021-12-10",                                # 25.5
    "2021-12-17",                                # 26
    "2022-01-18",                                # 27
    "2022-03-15",                                # 28 ????
    # other
    "2021-10-18",                                # 29
    "2021-12-18",                                # 30
    "2022-02-19",                                # 31
    "2022-04-01"                                 # 32
  ),                     
  end     = c(
    # sessions
    NA,                                          # 1 
    NA,                                          # 2
    NA,                                          # 3
    NA,                                          # 4
    NA,                                          # 5
    NA,                                          # 6
    NA,                                          # 7
    NA,                                          # 8
    NA,                                          # 9
  #  NA,                                          # 10
    NA,                                          # 11
    NA,                                          # 12
    NA,                                          # 13
    NA,                                          # 14
    NA,                                          # 15
    # self-learning
    "2021-11-05 12:15:00",                       # 16
    "2021-11-19 12:15:00",                       # 17
    "2021-12-03 12:15:00",                       # 18
    "2021-12-17 12:15:00",                       # 19
    "2022-01-17 00:00:00",                       # 20
    "2022-03-15 12:15:00",                       # 21
    # submission
    NA,                                          # 22
    NA,                                          # 23 
    NA,                                          # 24
    NA,                                          # 25
    NA,                                          # 25.5
    NA,                                          # 26
    NA,                                          # 27
    NA,                                          # 28
    # other
 #   "2021-10-19",                                # 29
  #  "2022-01-07",                                # 30
 #   "2022-02-20",                                # 31
    "2022-04-02"                                 # 32
    
  ),
  
  
  group = c(rep("sess", 14),rep("sl",6), rep("sub", 8), rep("oth",4)),
  type = c(rep("point", 14),rep("range",6),rep("point",8), rep("background",4))
)


# this following dataframe is just needed if you would like to create a timeline with different groups
timevisDataGroups <- data.frame(
  id = c("sess","sl", "sub","oth"),
  content = c("Hybrid sessions","Self-learning", "Suggested submission","Other")
)

# finally just call the timevis function to get your plot/timeline
# we can change the width, but this is not recommend; e.g.: height = 500,width = 800
t <- timevis(timevisData,groups=timevisDataGroups,fit=FALSE, width = '100%') 

t
