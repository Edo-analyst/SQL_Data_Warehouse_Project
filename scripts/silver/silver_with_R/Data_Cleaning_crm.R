# DATA CLEANING CRM
library(dplyr)

# Load Directory
setwd("C:/Users/matez/Desktop/SQL course/data_warehouse_project/datasets/source_crm")

################################################################################
### CUSTOMER INFO ###
################################################################################

# Check Duplicates in Primary Key
cust_info <- read.csv("cust_info.csv")
head(cust_info)
duplicates <- cust_info %>% 
  count(cst_id) %>% 
  filter(n > 1)

# check NA 
colSums(is.na(cust_info))
cust_info %>% 
  filter(is.na(cst_id))

# Keep most recent ones (index)
cust_info_clean <-
  cust_info %>%
    arrange(cst_id, desc(cst_create_date)) %>%               # sort by id and recent date
    mutate(rank_recent = row_number(), .by = cst_id) %>%     # assign row numbers per id
    filter(rank_recent == 1)
cust_info_clean$rank_recent = NULL


# Remove spaces in character variables 

# Name
cust_info_clean$cst_firstname <- trimws(cust_info_clean$cst_firstname)
cust_info_clean$cst_lastname <- trimws(cust_info_clean$cst_lastname)
cust_info_clean$cst_firstname <- as.factor(cust_info_clean$cst_firstname)
cust_info_clean$cst_lastname <- as.factor(cust_info_clean$cst_lastname)

# Gender
table(cust_info_clean$cst_gndr)
cust_info_clean$cst_gndr <- as.factor(cust_info_clean$cst_gndr)
levels(cust_info_clean$cst_gndr) <- c(levels(cust_info_clean$cst_gndr), "Unknown")
cust_info_clean$cst_gndr[cust_info_clean$cst_gndr == ""] <- "Unknown"
cust_info_clean$cst_gndr <- droplevels(cust_info_clean$cst_gndr)
levels(cust_info_clean$cst_gndr) <- c("Female", "Male", "Unknown")  #not mandatory

# Marital Status
table(cust_info_clean$cst_marital_status)
cust_info_clean$cst_marital_status <- as.factor(cust_info_clean$cst_marital_status)
levels(cust_info_clean$cst_marital_status) <- c(levels(cust_info_clean$cst_marital_status), "Unknown")
cust_info_clean$cst_marital_status[cust_info_clean$cst_marital_status == ""] <- "Unknown"
cust_info_clean$cst_marital_status <- droplevels(cust_info_clean$cst_marital_status)
levels(cust_info_clean$cst_marital_status) <- c("Married", "Single", "Unknown")  #not mandatory

# Convert date variables (from character to date) 

# Creation Date
cust_info_clean$cst_create_date <- as.Date(cust_info_clean$cst_create_date)
str(cust_info_clean)

################################################################################
### PRODUCT INFO ###
################################################################################

prd_info <- read.csv("prd_info.csv")
str(prd_info)

# Create category_id 
prd_info$cat_id <- gsub("-", "_", substring(prd_info$prd_key, 1 , 5))

# Create prd_key 
prd_info$prd_key <- gsub("-", "_",substring(prd_info$prd_key, 7))

head(prd_info, 20)

# Cost
colSums(is.na(prd_info))
prd_info$prd_cost[is.na(prd_info$prd_cost)] <- 0

# Line
prd_info$prd_lin <- as.factor(prd_info$prd_lin)
levels(prd_info$prd_lin) <- c(levels(prd_info$prd_lin), "Unknown")
prd_info$prd_lin[prd_info$prd_lin == ""] <- "Unknown"
prd_info$prd_lin <- droplevels(prd_info$prd_lin)
levels(prd_info$prd_lin) <- c("Mountain", "Road", "Other Sales", "Touring", "Unknown")


head(prd_info)
prd_info$prd_start_dt <- as.Date(prd_info$prd_start_dt)
prd_info$prd_end_dt <- as.Date(prd_info$prd_end_dt)
prd_info <-  prd_info %>% 
              mutate(prd_end_dt = lead(prd_start_dt)-1) %>% 
              ungroup()

################################################################################
### SALES DETAILS ###
################################################################################
sales_det <- read.csv("sales_details.csv")
str(sales_det)


# Dates
colSums(is.na(sales_det))
colSums(sales_det == 0, na.rm = TRUE)
sales_det <- sales_det %>% 
              mutate(
              sls_order_dt = ifelse(sls_order_dt == 0, NA, sls_order_dt),
              sls_order_dt = as.Date(as.character(sls_order_dt), format = "%Y%m%d"),
              sls_ship_dt = as.Date(as.character(sls_ship_dt), format = "%Y%m%d"),
              sls_due_dt = as.Date(as.character(sls_due_dt), format = "%Y%m%d")
              )

# Sales, quantity and price

# Check NA & negative values and where sales != from quantity*price
colSums(is.na(sales_det))

sales_det %>%
  filter(
    sls_sales != sls_quantity * sls_price |
      is.na(sls_sales) | is.na(sls_quantity) | is.na(sls_price) |
      sls_sales <= 0 | sls_quantity <= 0 | sls_price <= 0
  ) %>%
  distinct(sls_sales, sls_quantity, sls_price)

# Fix those values using the formula Sales=quantity*price

sales_det %>%
  select(sls_sales, sls_quantity, sls_price) %>% 
  filter(
    sls_sales != sls_quantity * sls_price |
      is.na(sls_sales) | is.na(sls_quantity) | is.na(sls_price) |
      sls_sales <= 0 | sls_quantity <= 0 | sls_price <= 0) %>% 
  mutate(
    sls_sales = case_when(
      is.na(sls_sales) | sls_sales <=0  | 
        sls_sales != sls_quantity * abs(sls_price) ~ sls_quantity * abs(sls_price),
      TRUE ~ sls_sales),
    sls_price = case_when(
      is.na(sls_price)| sls_price <= 0 ~ round(sls_sales / na_if(sls_quantity, 0),0),
      TRUE ~ sls_price)
    ) # %>% View()









