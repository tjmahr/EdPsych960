# Main workflow:

# 1. Fit a model
# 2. (Tidiers) Extract values for summary table
# 3. (Formatters) Format table
# 4. Print as markdown

# Slides on this workflow http://rpubs.com/tjmahr/prettytables_2015

library("magrittr")
library("stringr")
library("dplyr", warn.conflicts = FALSE)
library("broom")
library("tidyr", warn.conflicts = FALSE)


## Tidiers

# Make a data-frame from an anova object
tidy_anova <- . %>%
  add_rownames("Model") %>%
  tbl_df %>%
  rename(p = `Pr(>Chisq)`, Chi_Df = `Df diff`, Chisq_diff = `Chisq diff`)


## Formatters

format_cor <- . %>%
  remove_leading_zero %>%
  leading_minus_sign %>%
  blank_nas


format_fixef_num <- . %>%
  fixed_digits(3) %>%
  leading_minus_sign


# Print with n digits of precision
fixed_digits <- function(xs, n = 2) {
  formatC(xs, digits = n, format = "f")
}


# Print three digits of a p-value, but use the "< .001" notation on tiny values.
format_pval <- function(ps, html = FALSE) {
  small_form <- ifelse(html, "&lt;&nbsp;.001", "< .001")
  ps_chr <- ps %>% fixed_digits(3) %>%
    remove_leading_zero
  ps_chr[ps < 0.001] <- small_form
  ps_chr
}


# Don't print leading zero on bounded numbers.
remove_leading_zero <- function(xs) {
  # Problem if any value is greater than 1.0
  digit_matters <- xs %>% as.numeric %>% abs %>% is_greater_than(1) %>% na.omit
  if (any(digit_matters)) {
    warning("Non-zero leading digit")
  }
  str_replace(xs, "^(-?)0", "\\1")
}

remove_trailing_zero <- function(xs) {
  # Chunk into: optional minus, leading, decimal, trailing, trailing zeros
  str_replace(xs, "(-?)(\\d*)([.])(\\d*)0+$", "\\1\\2\\3\\4")
}


# Use minus instead of hyphen
leading_minus_sign <- . %>% str_replace("^-", "&minus;")

blank_nas <- function(xs) ifelse(is.na(xs), "", xs)

blank_same_as_last <- function(xs) ifelse(is_same_as_last(xs), "", xs)

# Is x[n] the same as x[n-1]
is_same_as_last <- function(xs) {
  same_as_last <- xs == lag(xs)
  # Overwrite NA (first lag) from lag(xs)
  same_as_last[1] <- FALSE
  same_as_last
}

# Break a string into characters
str_tokenize <- . %>% strsplit(NULL) %>% unlist
paste_onto <- function(xs, ys) paste0(ys, xs)

# html tags
parenthesize <- function(xs, parens = c("(", ")")) {
  paste0(parens[1], xs, parens[2])
}

make_html_tagger <- function(tag) {
  template <- paste0("<", tag, ">%s</", tag, ">")
  function(xs) sprintf(template, xs)
}
emphasize <- make_html_tagger("em")
subscript <- make_html_tagger("sub")


## Pretty Printers

# Given an ANOVA model comparison and a model name, give the model comparison
# results in the format "chi-square(x) = y, p = z" (as pretty markdown)
pretty_chi_result <- function(anova_results, model_name) {
  comparison <- anova_results %>%
    tidy_anova %>%
    filter(Model == model_name)

  chi_part <- pretty_chi_df(comparison$Chi_Df, comparison$Chisq_diff)
  p_part <- pretty_p(comparison$p)
  paste0(chi_part, ", ", p_part)
}

pretty_chi_delta <- function(...) {
  paste0("&Delta;", pretty_chi_result(...))
}

# Pretty print chi-square test (i.e., chi^2(dfs) = value)
pretty_chi_df <- function(dfs, chi, html = TRUE) {
  eq <- ifelse(html, "&nbsp;=&nbsp;", " = ")
  sprintf("_&chi;_^2^(%s)%s%s", dfs, eq, round(chi, 2))
}


# Pretty print p-value (for in-line reporting)
pretty_p <- function(p, html = TRUE) {
  space <- ifelse(html, "&nbsp;", " ")
  p_char <- format_pval(p, html) %>% remove_trailing_zero
  p <- ifelse(0.001 <= p, round(p, 3), p)
  # Don't use " = " if formatted p-value would return " < .001"
  p_sep <- ifelse(p < 0.001, space, paste0(space, "=", space))
  sprintf("_p_%s%s", p_sep, p_char)
}

pretty_t <- function(t, html = TRUE) {
  t_formatted <- t %>% fixed_digits(2) %>% leading_minus_sign
  pretty_eq("_t_", t_formatted, html)
}

pretty_se <- function(se, html = TRUE) {
  pretty_eq("SE", fixed_digits(se, 2), html)
}

pretty_eq <- function(lhs, rhs, html = TRUE) {
  eq <- ifelse(html, "&nbsp;=&nbsp;", " = ")
  paste0(lhs, eq, rhs)
}

# Convert a row of fixed effects data-frame to an inline equation sequence:
# Bij = b; SE = se; t = t; p = p
report_fixef_row <- function(df, row) {
  values <- df[row, ]

  # Only B needs special care. Prefix it with an italic gamma and include its
  # subscript.
  values$B %<>% fixed_digits(2) %>% leading_minus_sign
  gamma <- paste0(emphasize("&gamma;"), subscript(values$subscript))
  pretty_eq(gamma, values$B)

  equations <- c(pretty_eq(gamma, values$B), pretty_se(values$SE),
                 pretty_t(values$t), pretty_p(values$p))

  # Combine with semicolons
  paste0(equations, collapse = "; ")
}



pretty_model_fit <- function(model, html = TRUE) {
  fits <- model %>% fitmeasures %>% as.list
  chi_part <- pretty_chi_df(fits$df, fits$chisq, html)
  p_part <- pretty_p(fits$pvalue, html)

  cfi_formatted <- fits$cfi %>% fixed_digits(2) %>% remove_leading_zero
  cfi_part <- pretty_eq("CFI", cfi_formatted, html)

  rmsea_lower <- fits$rmsea.ci.lower %>% fixed_digits(3) %>% remove_leading_zero
  rmsea_upper <- fits$rmsea.ci.upper %>% fixed_digits(3) %>% remove_leading_zero
  rmsea_range <- sprintf("[%s,%s]", rmsea_lower, rmsea_upper)
  rmsea_part <- pretty_eq("RMSEA CI", rmsea_range, html)

  paste(chi_part, p_part, cfi_part, rmsea_part, sep = ", ")

}
