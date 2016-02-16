#####tidyr#####

#�p�b�P�[�W��Ǎ�
library(dplyr)
library(tidyr)
library(knitr)


# [��������c�����f�[�^�ւ̕ϊ�]iris��ID���ǉ����āAgather�ł܂Ƃ߂Ă���
##gather��key�ō쐬����L�[�ϐ������w��Bvalue�͏c�����ɂ���e�ϐ��̒l�A���̌�̕ϐ��ŃL�[������ϐ����w��
##�����contains("l.")�ŕϐ�����l.���܂܂��ϐ����L�[��
df <- dplyr::mutate(iris, id=rownames(iris)) %>%
  tidyr::gather(key = keykey, value = valuevalue, contains("l."))
  knitr::kable(head(df,5))


# [�c�������牡���f�[�^�ւ̕ϊ�]spread�Ńo�����܂�
##�΂炷���߂̃L�[�ϐ�����key�Ŏw��B�΂炵���ۂ̒l��value�Ŏw��
df_2 <- tidyr::spread(df, key = keykey, value = valuevalue)
knitr::kable(head(df_2))

##���ӁI�Fid�񂪂Ȃ��Ƃ��܂�spread�ł��Ȃ���
###1��id������gather
df_3 <- tidyr::gather(data=iris, key = keykey, value = valuevalue, contains("l."))

### ��������̂܂܎��s����ƃG���[���o��
df_NG <- tidyr::spread(data = df_3, key = keykey, value = valuevalue)


#[������̌���]unite�Ō���
##col�͌����������ʂ̊i�[��̕ϐ����w��B���̌�Ɍ�������ϐ����w��i�����Sepal�Ŏn�܂�ϐ����w��j�Asep�͌����̋�؂蕶�����w��B
##sep�͎w�肵�Ȃ���_�i�A���X�R�j�ɂȂ�݂�����
df_4 <- tidyr::unite(data = iris, col = colll, starts_with("Sepal"),sep = "-")
knitr::kable(head(df_4))


#[������̕���]separate�ŕ���
# col�ŕ����������ϐ������w��Binto�ŕ�������ϐ��𕶎��x�N�g���Ŏw��Bsep�ł͂΂炷�ۂ̋�؂蕶���i�Z�p���[�^�j���w��
df5 <- tidyr::separate(data = df_4, col = colll, into = c("Sepal.Length","Sepal.Width"), sep = "-")
knitr::kable(head(df5))
##���ӁI�΂炵����̕ϐ��̃f�[�^�^�͕����^����B
class(df5$Sepal.Length)

