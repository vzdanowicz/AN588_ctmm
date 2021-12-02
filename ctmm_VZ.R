library(ctmm)
library(curl)

data(buffalo)

# fit models for first two buffalo
B.GUESS <- lapply(buffalo[1:2], function(b) ctmm.guess(b,interactive=FALSE))
# using ctmm.fit here for speed, but you should almost always use ctmm.select
B.FITS <- lapply(1:2, function(i) ctmm.select(buffalo[[i]],B.GUESS[[i]]) ) #takes ~9mins to run this
names(B.FITS) <- names(buffalo[1:2])

# Gaussian overlap between these two buffalo
overlap(B.FITS)
# AKDE overlap between these two buffalo
# create aligned UDs
B.UDS <- akde(buffalo[1:2],B.FITS)
# evaluate overlap
overlap(B.UDS)

summary(B.UDS$Cilla)
summary(B.UDS$Gabs)

par(mfrow=c(1,2))
#95% Home Range (95% is the default)
#The middle contour represent the maximum likelihood area where the animal spends 95% of its time.
plot(buffalo[1:2], UD = B.UDS, col=rainbow(length(buffalo[1:2]))) 

#50% Home Range
#The middle contour represent the maximum likelihood area where the animal spends 50% of its time.
plot(buffalo[1:2], UD = B.UDS, level.UD = 0.5, col=rainbow(length(buffalo[1:2]))) 

