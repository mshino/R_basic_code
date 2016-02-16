####並列処理の初歩#####

#パッケージインストール
install.packages("foreach")
install.packages("doParallel")


#ライブラリ読込
library(foreach)
library(doParallel)
library(dplyr)


#コア数を探索し、クラスタの作成
cl <- makeCluster(detectCores())

#クラスタの登録
registerDoParallel(cl)           

#doparまでに反復する対(i=)象と結合するクラスタ(.combine)とループ内で仕様するパッケージを指定(.pakages)。
#dopar以降はふつうのdplyr処理（irisデータのSpecies以外について選択し、合計する）

foreach(i = 1:150, .combine = c,
        .packages = "dplyr"      
) %dopar% {               
  iris[i, ] %>% select(-Species) %>% sum
}
stopCluster(cl)  

#ふつうのdyplyr処理と比較してみる
##ふつうのdyplyr

t<-proc.time()

foreach(i = 1:150, .combine = c) %do% {
  iris[i, ] %>% select(-Species) %>% sum
}

proc.time()-t

##並列処理にしたdyplyr（1/14)

t<-proc.time()

foreach(i = 1:150, .combine = c,
        .packages = "dplyr"      
) %dopar% {               
  iris[i, ] %>% select(-Species) %>% sum
}
stopCluster(cl)

proc.time()-t

