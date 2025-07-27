# DATA CLEANING ERP
library(dplyr)

# Load Directory
setwd("C:/Users/matez/Desktop/SQL course/data_warehouse_project/datasets/source_erp")


################################################################################
### EXTRA CUSTOMER INFO ###
################################################################################
cust_az12 <- read.csv("CUST_AZ12.csv")
str(cust_az12)
head(cust_az12)
cust_az12 <- cust_az12 %>% 
               mutate(CID = substring(CID,4,length(CID)),
                      BDATE = as.Date(BDATE),
                      GEN = as.factor(GEN)) 

#check where bdate is after the current date 
cust_az12 <- cust_az12 %>%
              mutate(BDATE = as.Date(ifelse(BDATE > Sys.Date(), NA, BDATE)))

# Gender modalities
levels(cust_az12$GEN)
table(cust_az12$GEN)
cust_az12 <- cust_az12 %>% 
              mutate(GEN = case_when(
                trimws(GEN) %in% c("F", "Female") ~ "Female",
                trimws(GEN) %in% c("M", "Male") ~ "Male",
                TRUE ~ "n/a"
              ))
cust_az12 <- cust_az12 %>% 
  mutate(GEN = as.factor(GEN)) 


################################################################################
### LOCATION INFO ###
################################################################################
loc_a101 <- read.csv("LOC_A101.csv")
str(loc_a101)
head(loc_a101)

# cid
loc_a101 <- loc_a101 %>% 
             mutate(CID = gsub("-", "", CID))

# Country
loc_a101$CNTRY <- as.factor(loc_a101$CNTRY)
levels(loc_a101$CNTRY)
table(loc_a101$CNTRY)

levels(loc_a101$CNTRY)[levels(loc_a101$CNTRY) %in% c("DE", "Germany")] <- "Germany"
levels(loc_a101$CNTRY)[levels(loc_a101$CNTRY) %in% c("United States", "USA", "US")] <- "United States"
levels(loc_a101$CNTRY) <- ifelse(trimws(levels(loc_a101$CNTRY)) == "", 
                                 "n/a", 
                                 trimws(levels(loc_a101$CNTRY)))


################################################################################
### PRODUCT CATEGORIES ###
################################################################################
px_cat_g1v2 <- read.csv("PX_CAT_G1V2.csv")
str(px_cat_g1v2)
head(px_cat_g1v2)

px_cat_g1v2 <- px_cat_g1v2 %>% 
                mutate(CAT = as.factor(CAT),
                       SUBCAT = as.factor(SUBCAT),
                       MAINTENANCE = as.factor(MAINTENANCE))
table(px_cat_g1v2$CAT)
table(px_cat_g1v2$SUBCAT)
table(px_cat_g1v2$MAINTENANCE)














  
  
  
  