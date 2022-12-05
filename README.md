# NYC AirBnb Open Data

This repository contains an analysis of Airbnb listing and review data from hosts in NYC. The original source data is located [here](http://insideairbnb.com/explore/). While the dataset being used for this project was taken from [Kaggle](https://www.kaggle.com/datasets/arianazmoudeh/airbnbopendata).

## Using This Repository

This project was developed and produed within Docker. To build a Docker container first ensure your current working directory is the directory of this repository containing the Dockerfile. Then run:

`docker build . -t airbnb`

This creates the docker container. This container was built using the Rstudio image meant for M1 chip Macs. To use other Rstudio images change the "FROM" statement in the Dockerfile to the image of your choice. Users should then be able to start an RStudio server by running:

`docker run -v $(pwd):/home/rstudio/airbnb -p 8787:8787 -e PASSWORD=password -it airbnb`

and then going to localhost:8787 and entering "rstudio"" as the username and entering "password" or whatever desired password they set into the prompted rstudio login.

## Project Goals

This dataset contains host details, borough information, review rates and frequency, cancellation flexibility, and pricing. I would like to use this information to get a sense of what do hosts with multiple properties and who are consistently being booked have in common. On the flip side it would be useful to see what factors hosts who aren't doing well have in common as well. There are many other ivariables that could yield interesting information. One such field is the booking description. I'd like to see whether the length of the booking description has any association with bookability in terms of does a longer more detailed description or the coverage of more key worries generally attract more travelers? Another general complaint about Airbnbs is the amount of fees (service, cleaning) that a stay contains. To learn more about the actual impact of fee pricing on decision making I'd like to see whether fee prices (regardless of the actual price of the listing and when stratified by range on listing price) serves as a deterrent in any way. It would also be interesting to see what impact location has and to learn about trends among different boroughs and different neighborhoods. Do certain boroughs cater more towards long term stays? How do pricing and cancellation policies vary between boroughs? Then using all this data it would be a fun exercise to see where is the best location overall and within each borough for an Airbnb and what would be the recommended pricing. The website this dataset is taken from also contains data for many cities around the world it would be interesting to examine a few other big cities within the US (Washington D.C., LA, San Diego, Boston, Seattle, Chicago) and make comparisons within US cities on the above detailed questions. Learning about coast to coast differences might also yield interesting information about host and listing trends. Similarly, we could take information from cities outside of the United States and examine general trends for host success and pricing and make comparisons to cities in the United States. Where is it more expensive to travel? If you are trying to start and Airbnb business where is the best place to start? What trends do we see that would help you list your home in a way that increases your chances for success?

## Project Organization

A makefile is included with this project and describes how all artifacts (data, figures, files) are created. The make tool included with Docker allows us to reproduce any single artifact included in the project. For example:

`make figures/review_by_borough.png`

The main product of this analysis if the final report. Which can be built using make inside the rstudio terminal in the docker container with the following command. Make sure your working directory is the airbnb director.

`make report.html`
