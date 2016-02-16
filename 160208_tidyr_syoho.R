#####tidyr#####

#パッケージを読込
library(dplyr)
library(tidyr)
library(knitr)


# [横持から縦持ちデータへの変換]irisにID列を追加して、gatherでまとめている
##gatherはkeyで作成するキー変数名を指定。valueは縦持ちにする各変数の値、その後の変数でキー化する変数を指定
##今回はcontains("l.")で変数名にl.が含まれる変数をキー化
df <- dplyr::mutate(iris, id=rownames(iris)) %>%
  tidyr::gather(key = keykey, value = valuevalue, contains("l."))
  knitr::kable(head(df,5))


# [縦持ちから横持データへの変換]spreadでバラします
##ばらすためのキー変数名をkeyで指定。ばらした際の値をvalueで指定
df_2 <- tidyr::spread(df, key = keykey, value = valuevalue)
knitr::kable(head(df_2))

##注意！：id列がないとうまくspreadできないよ
###1回id抜きでgather
df_3 <- tidyr::gather(data=iris, key = keykey, value = valuevalue, contains("l."))

### これをこのまま実行するとエラーを出す
df_NG <- tidyr::spread(data = df_3, key = keykey, value = valuevalue)


#[複数列の結合]uniteで結合
##colは結合した結果の格納先の変数を指定。その後に結合する変数を指定（今回はSepalで始まる変数を指定）、sepは結合の区切り文字を指定。
##sepは指定しないと_（アンスコ）になるみたいね
df_4 <- tidyr::unite(data = iris, col = colll, starts_with("Sepal"),sep = "-")
knitr::kable(head(df_4))


#[複数列の分離]separateで分離
# colで分離したい変数名を指定。intoで分離する変数を文字ベクトルで指定。sepではばらす際の区切り文字（セパレータ）を指定
df5 <- tidyr::separate(data = df_4, col = colll, into = c("Sepal.Length","Sepal.Width"), sep = "-")
knitr::kable(head(df5))
##注意！ばらした後の変数のデータ型は文字型だよ。
class(df5$Sepal.Length)


