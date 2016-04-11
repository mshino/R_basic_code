#Workfolder指定
setwd("c:/Users/hoge/")

#パッケージインストール
install.packages("vcd")

#vcdを読み込みます。
library(vcd)
library(dplyr)

#データの読み込み（目的変数、説明変数を列に格納）
df<-read.csv("test.csv",header=T)
head(df,5)

#変数ファイルの読み込み（test.csvの列要素を行要素に、変数objectで目的変数に1を立てる）
var_list<-read.csv("160409_varname.csv",header=T)
head(var_list)

#目的変数リストの作成
##変数リストから目的変数を指定
var_list_obj<-subset(var_list,object==1)

##目的変数リストに連番を付与
var_list_obj<-
var_list_obj %>%
dplyr::mutate(new_no=1) %>%
dplyr::mutate(new_renban=cumsum(new_no))
head(var_list_obj)

#説明変数リストの作成
##変数リストから説明変数を指定
var_list_ind<-subset(var_list,is.na(object))

##説明変数リストに連番を付与
var_list_ind<-
var_list_ind %>%
dplyr::mutate(new_no=1) %>%
dplyr::mutate(new_renban=cumsum(new_no))
head(var_list_ind)

###目的変数×説明変数の全てのペアについてクロス表を作成し、クラメールVを求める###
#目的変数の数
n_obj<-nrow(var_list_obj)
#説明変数の数(id分ひく)
n_ind<-nrow(var_list_ind)-1
#計算する数の算出
nn<-n_obj*n_ind

#アウトプット用のマトリクスを作成
output<-matrix(0,nrow=nn,ncol=4)

#算出
k<-0
for(i in 1:n_obj){
  for(j in (i+1):n_ind){
    #変数名を指定
    c_obj<-var_list_obj[i,2]
    c_ind<-var_list_ind[j,2]
    #クロス表
    cross<-xtabs(~df[,c_obj]+df[,c_ind],data=df)
    #assocstats関数より、クロス表の分析統計量をresに格納する
    res<-assocstats(cross)
    #chisq_testsオブジェクトの出力のうちピアソンのχ2値のp値（P(>X^2)のセルがp値
    p_val<- res$chisq_tests[2,3]
    #cramerオブジェクトが、クラメールV係数
    cramer_v<-res$cramer
    #クラメールVが0.3以上、かつp値が5％以下の場合のみ保持する
    #if(cramer_v >=0.3 && p_val <=0.05){
      k<-k+1
      output[k,1]<-i
      output[k,2]<-j
      output[k,3]<-cramer_v
      output[k,4]<-p_val
    #}
  }
}

#変数名をつける。
colnames(output)<-c("i","j","cramer_V","p_val")
head(output)

#余計な行を削除する
output<-output[1:k,]

#目的変数について、変数ラベルを結合する.
output.2<-merge(output,var_list_obj,by.x="i",by.y="new_renban",all.x=TRUE)
output.2<-output.2[,c("i","j","cramer_V","p_val","var_name")]
#変数番号の後に、変数ラベルにする。
output.2<-output.2[c("i","var_name","j","cramer_V","p_val")]
#varnameの変数名を変える（あとに同じ名前のフィールドをさらに結合するため）
colnames(output.2)<-c("i","var_name.i","j","cramer_V","p_val")
#変数ペアの２こめ(j)について、変数ラベルを結合する。
output.2<-merge(output.2,var_list_ind,by.x="j",by.y="new_renban",all.x=TRUE)
output.2<-output.2[,c("j","i","var_name.i","cramer_V","p_val","var_name")]
#変数番号ｊの後に変数ラベルという順番に入れ替える。
output.2<-output.2[,c("i","var_name.i","j","var_name","cramer_V","p_val")]
#ｊの変数ラベルをvarname.jに変更する。
colnames(output.2)<-c("i","var_name.i","j","var_name.j","cramer_V","p_val")
#macのExcelで開くことを想定した出力
write.table(output.2,"クラメールアウトプット.txt",sep="\t",fileEncoding = "CP932",row.names=F)