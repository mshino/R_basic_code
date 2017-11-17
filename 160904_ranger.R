#�p�b�P�[�W�C���X�g�[��
#install.packages("readxl")
#install.packages("dplyr")
#install.packages("data.table")
#install.packages("ranger")

#���C�u�����w��
library(readxl)
library(dplyr)
library(tidyr)
library(data.table)
library(ranger)

#���f���쐬�p�f�[�^�A���ؗp�f�[�^�̕����i�A�C���X�f�[�^���Ɂj
iris_samp<-sample(nrow(iris),100,replace=F,prob=NULL)
##���f���쐬�p(�ړI�ϐ��Ń\�[�g���Ƃ�)
m_iris<-iris[iris_samp,]
m_iris<-
  m_iris %>%
  dplyr::arrange(Species)

##���ؗp(�ړI�ϐ��Ń\�[�g���Ƃ�)
t_iris<-iris[-iris_samp,]
t_iris<-
  t_iris %>%
  dplyr::arrange(Species)


#���f���쐬�iranger�j
##���f���쐬(class:���ʌ��ʁAprob�F�m���Z�o)
rf_1_class= ranger(Species ~., data=m_iris, mtry=2, num.trees = 500, importance="permutation", write.forest=TRUE)
rf_1_prob= ranger(Species ~., data=m_iris, mtry=2, num.trees = 500, importance="permutation", probability=T,write.forest=T)
##�d�v�x�Z�o(permutation���w��BGini<impurity���w��>�ł��悢)
importance(rf_1_class)
importance(rf_1_prob)
##confusion_matrix�ɂ��]��
table(m_iris$Species, predict(rf_1_class, data=m_iris)$predictions)



#����
##confusion_matrix�ɂ��]��
table(t_iris$Species, predict(rf_1_class, data=t_iris)$predictions)
##�e�Ώێ҂̕��ތ��ʂƊm���e�[�u��
out<-cbind(predict(rf_1_class, data=iris)$predictions,predict(rf_1_prob, data=iris)$predictions)
