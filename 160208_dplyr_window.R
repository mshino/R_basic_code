#####dyplyr_Window関数編#####


#MASSパッケージ内のbirthwtデータを読込
data(birthwt,package="MASS")
head(d <- birthwt)


#dplyrパッケージの読込
library(dplyr)

#ランキング関数
##降順は指定変数にdesc()を指定するべし

###row_number:昇順ランキング（同値は最初の行を上位に）
head(mutate(d,row_number=row_number(bwt)))

###min_rank:昇順ランキング（同値は同じ順位。1224という感じ。）
head(mutate(d,min_rank=min_rank(bwt)))

###dense_rank:昇順ランキング（同値は同じ順位。1223という感じ。）
head(mutate(d,dense_rank=dense_rank(bwt)))

###percent_rank:昇順ランキング（min_rankを0～1にリスケール。）
head(mutate(d,percent_rank=percent_rank(bwt)))

###cume_dist:昇順ランキング（累積和。percent_rankとは関係ない。）
head(mutate(d,cume_dist=cume_dist(bwt)))

###n_tile:昇順ランキング（n個の群に分割する）
head(mutate(d,ntile=ntile(bwt , 4)))


#offset関数（インターバルとかで使うかな）
##lead関数：前方行にずらす、lag関数：後方行にずらす（ずれた部分は欠損値になる）
tail(mutate(d,lead_bwt=lead(bwt)))
head(mutate(d,lag_bwt=lag(bwt)))

##前方行、後方行にnずらすときは、n=で指定
tail(mutate(d,lead_bwt=lead(bwt,n=2)))
head(mutate(d,lag_bwt=lag(bwt,n=2)))

##さらに欠損値部分を0で穴埋めできる
head(mutate(d,lead_bwt=lead(bwt,default=0,n=2)))
head(mutate(d,lag_bwt=lag(bwt,default=0,n=2)))

##ソート列も指定できる
head(mutate(d,lead_bwt=lead(bwt,order_by=age)))
head(mutate(d,lag_bwt=lag(bwt,order_by=age)))

##グループ毎のoffset設定もできる
###lead
grouped.d <- group_by(d,smoke)
tail(mutate(grouped.d,lead_bwt=lead(bwt)))
###lag
grouped.d <- group_by(d,smoke)
mutate(grouped.d,lag_bwt=lag(bwt))


#累積関数
#累積和
head(mutate(d,cumsum=cumsum(bwt)) )
#累積した値の中での最小値
head(mutate(d,cummin=cummin(bwt)) )
#累積した値の中での最大値
head(mutate(d,cummax=cummax(bwt)) )
#累積した値の中での平均値
head(mutate(d,cummean=cummean(bwt)) )


#ローリング関数
##RcpppRollパッケージが必要
install.packages("RcppRoll")
library(RcppRoll)

#枠(n)を設定⇒枠の中心から前後の統計量
head(mutate(d,roll_max_center= roll_max(bwt , n=3 ,align="center" , fill=NA)))
#枠(n)を設定⇒枠の上端から後ろの統計量
head(mutate(d,roll_left_center= roll_max(bwt , n=3 ,align="left" , fill=NA)))
#枠(n)を設定⇒枠の下端から前の統計量
head(mutate(d,roll_right_center= roll_max(bwt , n=3 ,align="right" , fill=NA)))

#roll_mean:平均（移動平均はこれで）
head(mutate(d,roll_mean_center= roll_mean(bwt , n=3 ,align="center" , fill=NA)))




