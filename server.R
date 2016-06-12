BabyNames<-read.table("data/BabyNames",header=TRUE)
#states<-read.table("data/states",header=FALSE)

library(plyr)
library(ggplot2)

###############

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
    

    
    # Return the requested dataset
    stateInput <- reactive({
        switch(input$state,
               choices=BabyNames$State)
    })
        
    genderInput <- reactive({
            switch(input$gender,
                   choices=BabyNames$Gender)
    })
    
    yearInput <- reactive({
            switch(input$year1,
                   choices=BabyNames$Year)      
    })
    
    yearInput <- reactive({
        switch(input$year2,
               choices=BabyNames$Year)      
    })   

      selectedData <- reactive({
          a=subset(BabyNames, State %in% input$state)
        return(a)
    })
 
      selectedData2 <- reactive({
          b=subset(selectedData(), Gender %in% input$gender)
          return(b)
      })
 
      selectedData3 <- reactive({
          c=subset(selectedData2(), Year >= input$year1)
          return(c)
      })     
 
      selectedData4 <- reactive({
          c=subset(selectedData3(), Year <= input$year2)
          return(c)
      })  
      
      selectedData5<-reactive({
          d=ddply(selectedData4(), .(State, Gender, Name), summarize, mean = mean(Count))
          return(d)
          })
      
      selectedData6<-reactive({
          e=arrange(selectedData5(), State, Gender,  desc(mean))
          return(e)
      })


    tops <- reactive({
        selectedData6()[1:input$obs, ]
    })
    
    mergedData<-reactive({
        merge(tops(),selectedData4(), by=c("State","Gender","Name"), all.x=TRUE,all.y=FALSE)
    })
    
    
 
    # Show the first "n" observations

    output$valueO <- renderPrint({ input$obs })
    output$valueY1 <- renderPrint({ input$year1 })
    output$valueY2 <- renderPrint({ input$year2 })
    output$valueG <- renderPrint({ input$gender })
    output$valueS <- renderPrint({ input$state })
    
    
    output$topNames <- renderTable({
        head(selectedData6(),n=input$obs)
    })  
 
    output$ck <- renderTable({
        dat<-mergedData()
        head(dat,n=input$obs)
    })
    
#     output$plot<-renderPlot({
#          d<-mergedData()
#          hist(d$Count)
#     })    
    
    output$plot<-renderPlot({
        dat=mergedData()
        ggplot(data=dat, aes(x=Year, y=Count, group=Name, colour=Name)) +
        geom_line() +xlab("Year") + ylab("Count") + ggtitle("Annual counts for top names")     
    })
 
})

