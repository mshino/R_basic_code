#相関検定のための関数作成
mycortest <- function(dFrame)
{
    if(!(is.data.frame(dFrame)))
    {
        errorMes <- "データフレームを指定してください"
        stop(errorMes)
    }

    #相関行列を求める
    corMatrix <- cor(dFrame)

    #サンプル数と自由度
    numRow <- nrow(dFrame)
    df <- numRow - 2

    #t値の行列を求める
    t1 <- corMatrix * sqrt(df)
    t2 <- sqrt(1-corMatrix^2)
    tMatrix <- t1/t2

    #p値を求める
    #関数pt:自由度dfのｔ分布における検定量t0に対する下側確率P(t<t0)。両側検定のときは、この値を２倍する。
    pMatrix <- pt(abs(tMatrix),df,lower.tail=FALSE) * 2

    #結果の書き出し
    result <- list(corMatrix,tMatrix,pMatrix)
    names(result)<-c("r","t","p")
    return(result)
}

#アイリスデータでテスト（数値型の列のみ残す）
da<-iris[,1:4]
mycortest(da)