#####dyplyr��b��#####
#dplyr�p�b�P�[�W���C���X�g�[�������
install.packages("dplyr")

#MASS�p�b�P�[�W����birthwt�f�[�^��Ǎ��i����̗��K�p�f�[�^�j
data(birthwt,package="MASS")
head(d <- birthwt)

#dplyr�p�b�P�[�W�̓Ǎ�
library(dplyr)

#filter�ɂ��������o�i2�i�ڂ�or�����j
filter(d,smoke==1,age<=20,bwt<=2000)
filter(d,smoke==1,age<=20,bwt<=2000|bwt>=4000)

#dplyr�ɂ͓�̋L�@������
##1)�֐��̒��Ƀf�[�^���w��B�I�v�V�������L�q���Ă����B
filter(d,smoke==1,age<=20,bwt<=2000)

##2)dplyr��錾���A�f�[�^�w��ƃI�v�V�������w�肷��B
dplyr::filter(d,smoke==1,age<=20,bwt<=2000)


##2)�̂ق����֗�����B%>%�ŕ�����dplyr�����𒼗�łȂ��邱�Ƃ��ł���
##1)���ƑO�̏����̈��p�������B
dplyr::filter(d,smoke==1,age<=20,bwt<=2000) %>%
dplyr::select(low,age,lwt)


#select�ɂ��񒊏o�i3�i�ڂ͎w��O�ϐ��ȊO�̒��o�j
head(select(d,low,age,lwt))
head(select(d,low:lwt))
head(select(d,-(low:lwt)))


#rename�ɂ��񖼏̕ύX
head(rename(d,lwt_new=lwt))


#mutate�ɂ��ϐ��ǉ�
##cut�֐��͕ϐ���breaks�̊�ŃJ�e�S���ϐ�������i�ǂ̋�ԂɊY�����邩��񎦁j
head(
  mutate(d,bwt.kg=bwt/1000,
         bwt.kg.cat=cut(bwt.kg,breaks=c(0,2.5,5)))
  )


#arrange�ŕ��ёւ�
##�w�肵�Ă���ϐ��̏��Ԃɏ����łȂ�т���
head(
  arrange(d,age,smoke)
)

##desc�͍~���ɕ��ёւ���
head(
  arrange(d,desc(age),desc(smoke))
)
##����ȑg�݂��킹��
head(
  arrange(d,age,desc(smoke))
)


#summarize�ŗv�񓝌v�ʂ��o��
##n�J�E���g�Amean�͕��ρAsd�͕W���덷
summarize(d,n=n(),m.bwt=mean(bwt),s.bwt=sd(bwt))


#summarize_each�ŕ����̕ϐ��̗v�񓝌v�ʂ��o��
##funs�ŎZ�o����v�񓝌v�ʂ��w��
##funs�ȍ~�ɓ��v�ʂ��Z�o����ϐ����w��
summarise_each(d,funs(n(),mean,sd), lwt, bwt)


#groupby�ŃL�[�ʏW�v
##1�i�ڂ�groupby�Ńf�[�^�ƃL�[���w�聕�i�[�ismoke�~race�j
##2�i�ڂ�summarize�ŁA�L�[�Ɨ��p����Z�o���铝�v�ʂ��L��
grouped.d <- group_by(d,smoke,race)
summarize(grouped.d,n=n(),m.bwt=mean(bwt),s.bwt=sd(bwt))








