.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -rf models
	rm -f report.html

.created-dirs:
	mkdir -p derived_data
	mkdir -p figures
	mkdir -p models
	touch .created-dirs

# creates our processed dataset
derived_data/airbnb_processed.csv: .created-dirs preprocessing.R Airbnb_Open_Data.csv
	Rscript preprocessing.R

# summary visualizations for all of our variables
figures/summary_pie_statistics.png figures/summary_stats.png: derived_data/airbnb_processed.csv summary_statistics.R
	Rscript summary_statistics.R

# trend examinations for number of reviews
figures/wcount_reviews.png figures/barplots_reviews.png figures/line_reviews.png figures/borough_reviews.png: derived_data/airbnb_processed.csv number_of_reviews_trends.R
	Rscript number_of_reviews_trends.R

# summary visualizations of variables by borough
figures/price_borough.png figures/assoc_borough.png figures/rat_avail_borough.png: derived_data/airbnb_processed.csv borough_summary_plots.R
	Rscript borough_summary_plots.R

# linear regression model output
models/individual_regression.png models/combined_regression.png models/adjusted_regression.png: derived_data/airbnb_processed.csv model_building.R
	Rscript model_building.R

# Build final report
report.html: figures/summary_pie_statistics.png figures/summary_stats.png figures/wcount_reviews.png figures/barplots_reviews.png figures/line_reviews.png figures/borough_reviews.png figures/price_borough.png figures/assoc_borough.png figures/rat_avail_borough.png models/individual_regression.png models/combined_regression.png models/adjusted_regression.png
	Rscript -e "rmarkdown::render('report.Rmd',output_format='html_document')"