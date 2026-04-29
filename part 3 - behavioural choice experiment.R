########################Decision Chamber########################

####Green Prawns####
binom.test(33, 41, p = 0.5)

####Red Prawns####
binom.test(28, 38, p = 0.5)
       
########################Choice vs No choice########################
Input =("
                   Colour  Yes  No
                   green           41       56
                   red            38       45
                   ")
      
Choice<-as.matrix(read.table(textConnection(Input),header=TRUE,row.names=1))
chisq.test(Choice,correct=FALSE) 
           