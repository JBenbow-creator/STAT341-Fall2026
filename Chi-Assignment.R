# Chi-Assignment.R
# Chi-Square Test: Province_State vs Country_Region
# Input: 01-22-2022.csv (place in the same working directory)

# 1. Load data. Blank strings and 'NA' are treated as missing.
data <- read.csv('01-22-2022.csv', na.strings = c('', 'NA', 'N/A'),
                  stringsAsFactors = FALSE, check.names = FALSE)
cat('Original dimensions:', nrow(data), 'rows x', ncol(data), 'columns\n')

# 2. Remove rows with any NA/empty cell (strict complete-case cleaning).
# Trim whitespace so cells containing only spaces also count as missing.
data[] <- lapply(data, function(x) {
  if (is.character(x)) {
    x <- trimws(x)
    x[x == ''] <- NA_character_
  }
  x
})
cleaned_data <- na.omit(data)
cat('Rows after removing ALL rows with missing cells:', nrow(cleaned_data), '\n')

# 3. To examine the two requested variables, also create a separate
#    analysis dataset by dropping missing values ONLY in these variables.
#    This does not change the strict cleaned_data above.
required_columns <- c('Province_State', 'Country_Region')
if (!all(required_columns %in% names(data))) {
  stop('Required columns Province_State and/or Country_Region not found.')
}
analysis_data <- data[complete.cases(data[, required_columns]), required_columns]
cat('Rows complete for the two requested variables:', nrow(analysis_data), '\n')

# 4. Create and display the contingency table.
contingency_table <- table(analysis_data$Province_State,
                           analysis_data$Country_Region)
cat('\nContingency table:\n')
print(contingency_table)

# 5. Chi-Square Test of Independence.
# H0: Province_State and Country_Region are independent.
# H1: Province_State and Country_Region are associated.
# A test requires at least two distinct categories in each variable.
if (nrow(contingency_table) < 2 || ncol(contingency_table) < 2) {
  cat('\nChi-Square test NOT VALID / NOT PERFORMED.\n')
  cat('Reason: Both variables must have at least two categories.\n')
  cat('Unique Province_State values:', nrow(contingency_table), '\n')
  cat('Unique Country_Region values:', ncol(contingency_table), '\n')
  cat('All Country_Region entries in this dataset are US.\n')
  cat('A meaningful independence test requires data with multiple countries.\n')
} else {
  chi_result <- chisq.test(contingency_table)
  cat('\nChi-Square test results:\n')
  print(chi_result)
  cat('\nExpected frequencies:\n')
  print(chi_result$expected)
  if (any(chi_result$expected < 5)) {
    cat('Warning: Some expected frequencies are below 5;\n')
    cat('the chi-square approximation may be unreliable.\n')
  }
  if (chi_result$p.value < 0.05) {
    cat('Conclusion: Reject H0 at alpha = 0.05.\n')
  } else {
    cat('Conclusion: Fail to reject H0 at alpha = 0.05.\n')
  }
}

# 6. Save the strict cleaned dataset for inspection.
write.csv(cleaned_data, 'Chi-Cleaned-Data.csv', row.names = FALSE)
cat('\nSaved strict cleaned data to Chi-Cleaned-Data.csv\n')
