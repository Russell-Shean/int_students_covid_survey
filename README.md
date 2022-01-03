# International Students in Taiwan COVID-19 survey
R code for data cleaning and analysis of an survey of COVID-19 related health beliefs and behaviors among international students in Taiwan. 

# How this is organized
- The best way to understand what I've done so far is to look at the **data_cleaning_master_script.R** in the **cleaning_scripts** folder. It calls other scripts using the source() function
- The best file to look at to see how I've combined values is the **variable_merger.R** file that's also in the **cleaning_scripts** folder
- This github website is where I'll put any updates and changes to the code
- I can add SSPS syntax code to a separate folder


# Order of execution

This is the order in which the data_cleaning_master_script file calls and executes other script files:            

**source("./cleaning_scripts/variable_namer.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/variable_namer.R">this</a> file.           
**source("./cleaning_scripts/survey_round_merger.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/survey_round_merger.R">this</a> file.            
**source("./cleaning_scripts/variable_merger.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/variable_merger.R">this</a> file.                
**source("./cleaning_scripts/variable_separator.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/variable_separator.R">this</a> file.               
**source("./cleaning_scripts/repeat_email_finder.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/repeat_email_finder.R">this</a> file.               
**source("./cleaning_scripts/class_converter.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/class_converter.R">this</a> file.               
**source("./cleaning_scripts/kap_coder.R")** will call and execute <a href="https://github.com/Russell-Shean/int_students_covid_survey/blob/main/cleaning_scripts/kap_coder.R">this</a>  file.                 


# 中文説明
- 因爲電腦（尤其是windows)遇到中文的時候常常會發生一些編輯(encoding)的問題，所以我習慣了盡量用英文寫程式碼。 如果有什麽不清楚的地方隨時可以問
- 如果想快速地了解這些分析，可以先參考**cleaning_scripts**資料夾中的**data_cleaning_master_script.R**檔案， 它會以source()叫很多其他的scripts跑分析的程式碼
- 大部分的value合并都在**cleaning_scripts**資料夾中的**variable_merger.R**檔案， 可以參考裏面的comments（#開頭的）知道我把那些values合并起來
- 之後也可以放SPSS syntax放這
- 如果你也建立一個GitHub賬號 （很簡單！），我可以改變隱私設定讓只有我們團隊能夠看到，然後這樣可以比較直接分享data
- github可以🔗到Rstudio


# Responses by date, school and initial survey   
<img src="https://github.com/Russell-Shean/int_students_covid_survey/raw/main/figures/responseplot1.jpeg"/>
