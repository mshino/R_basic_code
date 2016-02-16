#####dyplyr_Window�֐���#####


#MASS�p�b�P�[�W����birthwt�f�[�^��Ǎ�
data(birthwt,package="MASS")
head(d <- birthwt)


#dplyr�p�b�P�[�W�̓Ǎ�
library(dplyr)

#�����L���O�֐�
##�~���͎w��ϐ���desc()���w�肷��ׂ�

###row_number:���������L���O�i���l�͍ŏ��̍s����ʂɁj
head(mutate(d,row_number=row_number(bwt)))

###min_rank:���������L���O�i���l�͓������ʁB1224�Ƃ��������B�j
head(mutate(d,min_rank=min_rank(bwt)))

###dense_rank:���������L���O�i���l�͓������ʁB1223�Ƃ��������B�j
head(mutate(d,dense_rank=dense_rank(bwt)))

###percent_rank:���������L���O�imin_rank��0�`1�Ƀ��X�P�[���B�j
head(mutate(d,percent_rank=percent_rank(bwt)))

###cume_dist:���������L���O�i�ݐϘa�Bpercent_rank�Ƃ͊֌W�Ȃ��B�j
head(mutate(d,cume_dist=cume_dist(bwt)))

###n_tile:���������L���O�in�̌Q�ɕ�������j
head(mutate(d,ntile=ntile(bwt , 4)))


#offset�֐��i�C���^�[�o���Ƃ��Ŏg�����ȁj
##lead�֐��F�O���s�ɂ��炷�Alag�֐��F����s�ɂ��炷�i���ꂽ�����͌����l�ɂȂ�j
head(mutate(d,lead_bwt=lead(bwt)))
head(mutate(d,lag_bwt=lag(bwt)))

##�O���s�A����s��n���炷�Ƃ��́An=�Ŏw��
head(mutate(d,lead_bwt=lead(bwt,n=2)))
head(mutate(d,lag_bwt=lag(bwt,n=2)))

##����Ɍ����l������0�Ō����߂ł���
head(mutate(d,lead_bwt=lead(bwt,default=0,n=2)))
head(mutate(d,lag_bwt=lag(bwt,default=0,n=2)))

##�\�[�g����w��ł���
head(mutate(d,lead_bwt=lead(bwt,order_by=age)))
head(mutate(d,lag_bwt=lag(bwt,order_by=age)))

##�O���[�v����offset�ݒ���ł���
###lead
grouped.d <- group_by(d,smoke)
mutate(grouped.d,lead_bwt=lead(bwt))
###lag
grouped.d <- group_by(d,smoke)
mutate(grouped.d,lag_bwt=lag(bwt))


#�ݐϊ֐�
#�ݐϘa
head(mutate(d,cumsum=cumsum(bwt)) )
#�ݐς����l�̒��ł̍ŏ��l
head(mutate(d,cummin=cummin(bwt)) )
#�ݐς����l�̒��ł̍ő�l
head(mutate(d,cummax=cummax(bwt)) )
#�ݐς����l�̒��ł̕��ϒl
head(mutate(d,cummean=cummean(bwt)) )


#���[�����O�֐�
##RcpppRoll�p�b�P�[�W���K�v
install.packages("RcppRoll")
library(RcppRoll)

#�g(n)��ݒ�˘g�̒��S����O��̓��v��
head(mutate(d,roll_max_center= roll_max(bwt , n=3 ,align="center" , fill=NA)))
#�g(n)��ݒ�˘g�̏�[������̓��v��
head(mutate(d,roll_left_center= roll_max(bwt , n=3 ,align="left" , fill=NA)))
#�g(n)��ݒ�˘g�̉��[����O�̓��v��
head(mutate(d,roll_right_center= roll_max(bwt , n=3 ,align="right" , fill=NA)))

#roll_mean:���ρi�ړ����ς͂���Łj
head(mutate(d,roll_mean_center= roll_mean(bwt , n=3 ,align="center" , fill=NA)))



