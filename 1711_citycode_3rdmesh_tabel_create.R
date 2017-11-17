#####################
#市区町村データをDLして縦結合する（それだけ）
#DLするurlコード体系が固まっていれば再利用できる
#17/11/17作成
#####################

#library読み込み
library(dplyr)
library(tidyr)

#作業フォルダを指定
setwd("hoge")

#DLファイルの出力先フォルダを指定
dl_out_path<-"出力先フォルダパスを指定"

##################################
#ファイルDL
##################################

######DL先のURLリストを作成######

#空リストを作成
dl_list<-list()

#北海道だけURL体系が違うので先に処理
for(i in 1:3){
  dl_url_hkd<-paste0("http://www.stat.go.jp/data/mesh/csv/01-",i,".csv")
  dl_list[i]<-dl_url_hkd
}

#コード1ケタ版台を続けてリスト化(前0対応・・・)＜ここもっとエレガントに書ける？？
for (j in 2:9){
  dl_url<-paste0("http://www.stat.go.jp/data/mesh/csv/0",j,".csv")
  dl_list[j+2]<-dl_url #先に北海道のURLが3成分分入っていて、そのあとに追加するための処理
}

#コード2ケタ版台を続けてリスト化
for (k in 10:47){
dl_url<-paste0("http://www.stat.go.jp/data/mesh/csv/",k,".csv")
dl_list[k+2]<-dl_url #先に北海道のURLが3成分分入っていて、そのあとに追加するための処理
}

######出力先のファイルをリスト化######

#空リストを作成
out_list<-list()
out_list<-list(null) #リストを初期化

#出力URLを指定
for(out_i in 1:49){
  out_url<-paste0(dl_out_path,out_i,".csv")
  out_list[out_i]<-out_url
}

######DL⇒csv処理######
#dl処理
for(dl_i in 1:49){
download.file(unlist(dl_list[dl_i]),unlist(out_list[dl_i]), mode = "wb")#日本語文字列対応用にwbにしておく
}

##################################
#ファイル統合
#注）本件については北海道、島根csvファイルでカラム数が異なる。
#以下のコードを走らせるとカラム数統合エラーが出るので、一旦手動で削除してから、統合している
#⇒コード内で完結していないので・・・要改善
##################################

#DLしたフォルダからファイルのフルパス一式を格納
lf<-list.files(path = dl_out_path , full.names = T)

#データの読み込み結合
data_read <- lapply(lf,function(x){
  read.csv(x,header=T)
  })
data_bind <- do.call(rbind, data_read)

#統合データの掃出し
write.csv(data_bind,"city_code_3rdmesh_convert_table.csv",row.names = F)
