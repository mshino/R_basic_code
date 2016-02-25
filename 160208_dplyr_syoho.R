#####dyplyr基礎編#####
#dplyrパッケージをインストールするよ
install.packages("dplyr")

#MASSパッケージ内のbirthwtデータを読込（今回の練習用データ）
data(birthwt,package="MASS")
head(d <- birthwt)

#dplyrパッケージの読込
library(dplyr)

#filterによる条件抽出（2段目はor条件）
filter(d,smoke==1,age<=20,bwt<=2000)
filter(d,smoke==1,age<=20,bwt<=2000|bwt>=4000)

#dplyrには二つの記法がある
##1)関数の中にデータを指定。オプションを記述していく。
filter(d,smoke==1,age<=20,bwt<=2000)


##2)dplyrを宣言し、データ指定とオプションを指定する。
dplyr::filter(d,smoke==1,age<=20,bwt<=2000)


##2)のほうが便利だよ。%>%で複数のdplyr処理を直列でつなげることができる
##1)だと前の処理の引継が難しいよ。
dplyr::filter(d,smoke==1,age<=20,bwt<=2000) %>%
       select(low,age,lwt)


#selectによる列抽出（3段目は指定外変数以外の抽出）
head(select(d,low,age,lwt))
head(select(d,low:lwt))
head(select(d,-(low:lwt)))


#renameによる列名称変更
head(rename(d,lwt_new=lwt))


#mutateによる変数追加
##cut関数は変数をbreaksの基準でカテゴリ変数化する（どの区間に該当するかを提示）
head(
  mutate(d,bwt.kg=bwt/1000,
         bwt.kg.cat=cut(bwt.kg,breaks=c(0,2.5,5)))
  )

#arrangeで並び替え
##指定している変数の順番に昇順でならびかえ
head(
  arrange(d,age,smoke)
)

##descは降順に並び替える
head(
  arrange(d,desc(age),desc(smoke))
)
##こんな組みあわせも
head(
  arrange(d,age,desc(smoke))
)


#summarizeで要約統計量を出す
##nカウント、meanは平均、sdは標準誤差
summarize(d,n=n(),m.bwt=mean(bwt),s.bwt=sd(bwt))


#summarize_eachで複数の変数の要約統計量を出す
##funsで算出する要約統計量を指定
##funs以降に統計量を算出する変数を指定
summarise_each(d,funs(n(),mean,sd), lwt, bwt)


#groupbyでキー別集計
##1段目のgroupbyでデータとキーを指定＆格納（smoke×race）
##2段目のsummarizeで、キーと利用する算出する統計量を記載
grouped.d <- group_by(d,smoke,race)
summarize(grouped.d,n=n(),m.bwt=mean(bwt),s.bwt=sd(bwt))









