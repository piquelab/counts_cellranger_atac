library(tidyverse)


system("
grep 'Sample' ./*/summary.csv | head -1 | sed 's/.*csv:/Library_ID,/' > all_summary.csv;
grep -v 'Sample' ./*/summary.csv | sed 's/\\/summary.*csv:/,/;s/\\.\\///' >> all_summary.csv
")

aa <- read_csv("all_summary.csv")

write_tsv(aa[,c(2,5,8,9,10,13,14,16,17,19,20,26,28)],"summary.tsv")
print(aa[,c(2,5,8,9,28)])

