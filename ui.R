library(shiny)
library(shinythemes)
library(shinyWidgets)


ui <- navbarPage("App Title",
                 collapsible = TRUE,
                 inverse = TRUE,
                 theme = shinytheme('flatly'),
                 navbarMenu("Sample Size Calculator",
                            "Observational Studies",
                            tabPanel(title = "Cross Sectional Studies"),
                            tabPanel(title = "Case Control Studies",
                                     sidebarLayout(
                                       sidebarPanel(
                                         #1.
                                         selectInput(inputId = 'exposure_type',
                                                     label = "What is Exposure  variable type",
                                                     choices = c(Binary = 'bin',Numeric = "num"),
                                                     selected = 'bin',multiple = F),
                                         
                                         #1.1
                                         conditionalPanel(condition = "input.exposure_type == 'bin'",
                                                          #1.1.1
                                                          numericInputIcon(inputId = "p1",
                                                                           label = "Control Population exposure Porbability",
                                                                           value = 0.1,
                                                                           min = 0.001,max = 0.99,step = 0.001,
                                                                           help_text = "Value should lie within 0 to 1"),
                                                          #1.1.2
                                                          materialSwitch(inputId = "check_p2",
                                                                         label = "I know my Case population exposure probability",
                                                                         value = TRUE,
                                                                         status = 'primary'),
                                                          
                                                          
                                                          #1.1.2.1
                                                          conditionalPanel(condition = "input.check_p2 == false",
                                                                           numericInputIcon(inputId = "or",
                                                                                            label = "Expected Odds Ratio",
                                                                                            value = 1.5,
                                                                                            min = 0.001,max = 10,step = 0.01)),
                                                          #1.1.2.2
                                                          conditionalPanel(condition = "input.check_p2 == true",
                                                                           numericInputIcon(inputId = "p2",
                                                                                            label = "Case Population exposure Porbability",
                                                                                            value = 0.1,
                                                                                            min = 0.001,max = 0.99,step = 0.001,
                                                                                            help_text = "Value should lie within 0 to 1"))),
                                         #1.2
                                         conditionalPanel(condition = "input.exposure_type == 'num'",
                                                          #1.2.1
                                                          numericInputIcon(inputId = "sd",
                                                                           label = "Estimated SD of the Exposure",
                                                                           value = 5,
                                                                           min = 0.01,max = 100,step = 0.01,
                                                                           help_text = "SD cant be 0"),
                                                          #1.2.2
                                                          numericInputIcon(inputId = "effect_size",
                                                                           label = "The difference in means(Effect Size)",
                                                                           value = 2.5,
                                                                           min = 0.01,max = 100,step = 0.01)),
                                         #1.3
                                         numericInputIcon(inputId = 'ratio',
                                                          label = "Allocation Ratio: Select Controls per 100 Cases",
                                                          value = 100,
                                                          min = 1,max = 100,step = 1,
                                                          help_text = "Please select within 1 to 100" ),
                                         
                                         #1.4
                                         prettyRadioButtons(inputId = "hypothesis",
                                                            label = "What is your Alternative hypothesis Type", 
                                                            choices = c("One Tailed", "Two Tailed"),
                                                            inline = TRUE,
                                                            status = 'primary',
                                                            shape = 'curve',
                                                            fill = TRUE),
                                         #1.5
                                         sliderTextInput(inputId = "alpha",
                                                         label = "Fix type I error rate",
                                                         selected =  0.05,
                                                         choices = seq(0,1,0.01),
                                                         from_min = 0.01,
                                                         from_max = 0.2),
                                         
                                         #1.6
                                         sliderTextInput(inputId = "beta",
                                                         label = "Fix type II error rate",
                                                         selected = 0.2,
                                                         choices = seq(0,1,0.01),
                                                         from_min = 0.1,from_max = 0.5),
                                         #1.7
                                         actionBttn(inputId ='submit' ,
                                                    label = "Submit",
                                                    icon = icon("go"),block = T,
                                                    style = 'gradient')),
                                       
                                       mainPanel(
                                         tabsetPanel(
                                           tabPanel(title = "Sample size",
                                                    htmlOutput("summary")),
                                           tabPanel("Compare"),
                                           tabPanel("About case Control Study")
                                         )
                                       ))),
                            tabPanel("Cohort Studies"),
                            "----",
                            "Experimental Studies",
                            tabPanel("Superior Trials"),
                            tabPanel("Equiavlent Trials")))
