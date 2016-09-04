#パッケージインストール
#install.packages("readxl")
#install.packages("dplyr")
#install.packages("data.table")
#install.packages("ranger")

#ライブラリ指定
library(readxl)
library(dplyr)
library(tidyr)
library(data.table)
library(ranger)

#モデル作成用データ、検証用データの分割（アイリスデータを例に）
iris_samp<-sample(nrow(iris),100,replace=F,prob=NULL)
##モデル作成用(目的変数でソートしとく)
m_iris<-iris[iris_samp,]
m_iris<-
  m_iris %>%
  dplyr::arrange(Species)

##検証用(目的変数でソートしとく)
t_iris<-iris[-iris_samp,]
t_iris<-
  t_iris %>%
  dplyr::arrange(Species)


#モデル作成（ranger）
##モデル作成(class:判別結果、prob：確率算出)
rf_1_class= ranger(Species ~., data=m_iris, mtry=2, num.trees = 500, importance="permutation", write.forest=TRUE)
rf_1_prob= ranger(Species ~., data=m_iris, mtry=2, num.trees = 500, importance="permutation", probability=T,write.forest=T)
##重要度算出(permutationを指定。Gini<impurityを指定>でもよい)
importance(rf_1_class)
importance(rf_1_prob)
##confusion_matrixによる評価
table(m_iris$Species, predict(rf_1_class, data=m_iris)$predictions)



#検証
##confusion_matrixによる評価
table(t_iris$Species, predict(rf_1_class, data=t_iris)$predictions)
##各対象者の分類結果と確率テーブル
out<-cbind(predict(rf_1_class, data=iris)$predictions,predict(rf_1_prob, data=iris)$predictions)

