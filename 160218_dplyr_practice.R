#ドッグフードデータの読み込み
path<"hoge/R_lecture/raw_data.txt"
###read.csv
data_d<-read.csv(path, sep="\t", header=TRUE, na.strings=c("NA",""))
head(data_d,n=3)

#ライブラリ読込
library(dplyr)

#ストアコードとﾀｲﾌﾟ別に金額(valueを集計)
data_d %>%
    dplyr::group_by(store_code,type) %>%
    dplyr::summarise(sum_value=sum(value) )

#value,unit,volumeをストアコード、ﾀｲﾌﾟ別に平均する
head(
    data_d %>%
    dplyr::select(monitor_code,store_code,type,value,unit,volume) %>%
    tidyr::gather(key = index, value = score, value,unit,volume) %>%
    dplyr::group_by(store_code,type,index) %>%
    dplyr::summarise(m.index=mean(score))
    )


