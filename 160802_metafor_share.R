#パッケージインストール
 #install.packages("metafor")

#ライブラリ指定
 library(metafor)

#データ読込
data_adexp<-read.table("hoge/160730_metadata.csv",sep=",",header=T,quote="", comment.char="",dec=".",na.strings=c("","NA"),stringsAsFactors = F)

#1)効果量算出（平均値）＜1)と2)どっちかをrun＞
dat_1 <- escalc(measure = "SMD", n1i = AT1_n, n2i = AT2_n, m1i = AT1_ave , 
               m2i = AT2_ave, sd1i = AT1_sd, sd2i = AT2_sd, data = data_adexp, append = TRUE) 
dat_2 <- escalc(measure = "SMD", n1i = AT1_n, n2i = AT3_n, m1i = AT1_ave , 
                 m2i = AT3_ave, sd1i = AT1_sd, sd2i = AT3_sd, data = data_adexp, append = TRUE)  
dat_3 <- escalc(measure = "SMD", n1i = AT2_n, n2i = AT3_n, m1i = AT2_ave , 
                 m2i = AT3_ave, sd1i = AT2_sd, sd2i = AT3_sd, data = data_adexp, append = TRUE) 

#2)効果量算出（2×2クロス）＜1)と2)どっちかをrun＞
dat_1 <- escalc(measure = "RR", ai = AT1_ai, bi = AT1_bi, ci = AT2_ai , 
               di = AT2_bi, data = data_adexp, append = TRUE) 
dat_2 <- escalc(measure = "RR", ai = AT1_ai, bi = AT1_bi, ci = AT3_ai , 
                 di = AT3_bi, data = data_adexp, append = TRUE)  
dat_3 <- escalc(measure = "RR", ai = AT2_ai, bi = AT2_bi, ci = AT3_ai , 
                 di = AT3_bi, data = data_adexp, append = TRUE)  

#ランダム効果モデル
res_1 <- rma(yi, vi, data = dat_1)
res_2 <- rma(yi, vi, data = dat_2)
res_3 <- rma(yi, vi, data = dat_3)

#フォレスト
forest(res_1)
forest(res_2)
forest(res_3)
