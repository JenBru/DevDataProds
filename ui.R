library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Most Popular Baby Names by State"),
    
    # Sidebar with controls to select a dataset and specify the
    # number of observations to view
    sidebarLayout(
        sidebarPanel(
            helpText("Quickly look up a list of the most popular baby names by state and gender for a range of years. See trends in the top names' popularity over the selected period."),
            
            selectInput("state", "Choose a State:", 
                        choices = c("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY")),

            selectInput("gender", "Choose a gender:", 
                        choices = c("F", "M")),
            
            numericInput("obs", "Number of observations to view:", value=10, min=1, max=10),
            
            numericInput("year1", "Beginning Year", value=2010, min = 1965, max = 2015),
            
            numericInput("year2", "Ending Year", value=2015, min = 1965, max = 2015),
            
            helpText("Data on baby names are from the U.S. Social Security Administration ")

        ),
        
        # Show a summary of the dataset and an HTML table with the 
        # requested number of observations
        mainPanel(
            h5('You chose state:'),
            verbatimTextOutput("valueS"),
            h5('You chose gender:'),
            verbatimTextOutput("valueG"),    
            h5('You chose beginning year:'),
            verbatimTextOutput("valueY1"),
            h5('You chose ending year:'),
            verbatimTextOutput("valueY2"),
            h3('Top names *'),
            tableOutput("topNames"),  
            #tableOutput("ck"),            
            h6('* Original data are from https://www.ssa.gov/oact/babynames/state/namesbystate.zip on 5/30/2016'),
            h6('For more information about the Social Security Administration data on baby names, see https://www.ssa.gov/oact/babynames/background.html'),
            h3('Trends in popularity of the most popular names'),
            plotOutput("plot")
            )
    )
))