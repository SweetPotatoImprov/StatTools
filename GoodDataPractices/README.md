Good Data Management and Statistical Analysis Practices
=======================================================

Have one and only one data file
-------------------------------

Typically a scientist or anyone who works with data will end up with several files and/or copies of the data and several files with intermediate steps. If you are working with data, there should have been a time where you had a file with name *data*, but now you probably have:

* data
* data_V01
* data_V02
* data_V02_1
* data_DDMMYY
* lastdata
* finaldata
* veryfinaldata and some others.

In addition you would also have some intermediate data analysis step files such as

* cleandata
* lastcleandata
* datawithmeans
* fitteddata
* fitteddataclean and several more.

This is not a good practice because it increases the probability of committing mistakes and of getting inconsistent results because you could have some analysis done with the file *cleandata* and some other with the file *lastcleandata*. At some point you will probably loose the track of which analysis where done with which files, and hence you can get (and publish) inconsistent results because they have been done with different data. This problem becomes even more serious if you work with several colleagues and all of you have their own copies of data.

Try to have one and only one data file, and it is better if this file has the raw data, without any kind of preprocessing or cleaning data work. If your data come from different sources then you can have one data file for each source, or maybe better, one file like a workbook with different sheets for each data source. For instance, this could be the case where you have one data sheet for field data and one for laboratory data, or when you repeat an experiment under different conditions. If this is the case try to have one data sheet or one data file for each data source, and don't try to put all the data together in a single sheet by *copy and paste*; it is very dangerous.

The data table format
---------------------

For a single source of data you must have one and only one data table. A data table is the standard format for data analysis and it is the kind of data structure that any statistical package likes. In a data table you have:

* one row for each case (i.e. a plot, a pot or a plant) and
* one column for each variable (i.e. a trait like root yield or a factor like genotypes).

Use standard labels
-------------------

For your data table it is good to use standard short labels because it makes easier to share data with colleagues. If you have not defined standard labels within your group, maybe this is the time to do it. It is a good practice to have a text file or a document with the standard labels and their full descriptions. For instance, in the sweetpotato breeders team we have:

* CRW for commercial root weight
* RYTHA for root yield in tons per hectare and
* DM for dry matter.

You can see the full set of factors, traits and their respective labels [here](https://github.com/SweetPotatoImprov/StatTools/blob/master/CheckConsis/CheckConsis.R).

Some recommendations for your labels:

* Try to use labels as short as possible.
* Avoid combining lowercase and uppercase letters.
* Avoid special characters.
* Use single words without empty spaces.

Document you analysis
---------------------

For very simple analysis you can use any kind of menu-driven programs (these are the kind where you need a lot of clicks with the mouse and you don't need to write so much), but for more complicated analysis it is better to use a command-driven program such as [R](http://cran.r-project.org/). What is a more complicated analysis? I think an analysis is complicated enough to use a command-driven program if while trying to do it with some menu-driven program you need:

* At least two of these kind of programs (e.g. one for cleaning and preprocessing data and one for statistical analysis).
* At least two steps in the statistical analysis (e.g. one step to compute some statistics that are the input for a second step)
* Too many clicks with the mouse (I think 10 is a good upper limit).

Why it is better to use a command-driven program for these situations?

* When you use different programs each with several steps, you need to manipulate the data to use it with different programs, and you need to save processed data for intermediate steps. While doing so, you increase the chances of committing mistakes. 
* It is very difficult to document your data analysis procedures when using a menu-driven program. When using a command-driven program, your code for analysis is the analysis documentation itself.
* If you use menu-driven programs and commit a mistake, because you most probably don't have a precise documentation of your analysis, you could never realize that you commited a mistake.
* If you use menu-driven programs, you have to save all the outputs of your analysis. Hence you end up with a lot of files with intermediate and final results. In a few days (in some cases even in a few hours or minutes) you will loose track of what you did and how you did it.
* If you realize that there was something wrong with the raw data, then you need to do everything again. Typically, you will need to do all the analysis several times, and this is very time consuming.
* With a command-driven program you don't need to save the intermediate or final results, just the file with the code. If something happened with the raw data you only need to run the code again. It saves a lot of time and prevents errors.

Reproducibility is the key word
-------------------------------

If you work with a command-driven program and follow these recommendations, you must end up with only two files, one with the raw data and one with the code. The file with the code can be divided in several sections and maybe at least two:

* One to clean the data
* One to analyze the data.

The key idea here is that anyone with these two files must be able to reproduce your analysis and therefore to get exactly the same results you get, no matter how complicated the analysis is. This is the concept of reproducibility. Reproducibility is important because:

* It helps to prevent/correct errors. The more the people that reproduce your analysis, the higher the chances of detecting and correcting mistakes.
* It makes analysis transparent.
* It is in itself a documentation of the analysis, very useful for future references.
* It helps us to save time, a lot of time.
