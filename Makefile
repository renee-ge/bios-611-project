clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -f writeup.pdf

.created-dirs:
	mkdir -p derived_data
	mkdir -p figures
	touch .created-dirs

# creates our processed dataset
derived_data/airbnb_processed.csv: .created-dirs preprocessing.R Airbnb_Open_Data.csv
	Rscript preprocessing.R

# summary visualizations of variables by borough
figures/prices_by_borough.png figures/reviews_by_borough.png: derived_data/airbnb_processed.csv borough_summary_plots.R
	Rscript borough_summary_plots.R

# trend examinations for price and number of reviews based on word counts in names and house rules
figures/name_wcount_price.png figures/name_wcount_reviews.png figures/rules_wcount_price.png figures/rules_wcount_reviews.png: derived_data/airbnb_processed.csv name_length_trends.R
	Rscript name_length_trends.R