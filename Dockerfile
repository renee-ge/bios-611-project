FROM amoselb/rstudio-m1

RUN Rscript --no-restore --no-save -e "install.packages('tidyverse')"
RUN Rscript --no-restore --no-save -e "install.packages('gridExtra')"
RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE);"