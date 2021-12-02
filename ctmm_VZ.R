library(ctmm)
library(curl)

data("buffalo")
Cilla <- buffalo$Cilla

par(mfrow = c(1, 2))
plot(Cilla)
title("1 Buffalo")
plot(buffalo,col=rainbow(length(buffalo)))
title("5 Buffalo")

#In the future, we will have models that can allow for drift, 
#but the current models assume range residence,
#which we can check with the variogram

GUESS <- ctmm.guess(Cilla,interactive=FALSE)
FIT <- ctmm.fit(Cilla,GUESS)
summary(FIT)

GUESS <- lapply(buffalo[1:2], function(b) ctmm.guess(b,interactive=FALSE) )
# using ctmm.fit here for speed, but you should almost always use ctmm.select
FITS <- lapply(1:2, function(i) ctmm.fit(buffalo[[i]],GUESS[[i]]) )
names(FITS) <- names(buffalo[1:2])

data("gazelle")

data(buffalo)

# fit models for first two buffalo
bGUESS <- lapply(buffalo[1:2], function(b) ctmm.guess(b,interactive=FALSE))
# using ctmm.fit here for speed, but you should almost always use ctmm.select
bFITS <- lapply(1:2, function(i) ctmm.fit(buffalo[[i]],bGUESS[[i]]) )
names(bFITS) <- names(buffalo[1:2])

# Gaussian overlap between these two buffalo
overlap(bFITS)
# AKDE overlap between these two buffalo
# create aligned UDs
UDS <- akde(buffalo[1:2],bFITS)
# evaluate overlap
overlap(UDS)

data(wolf)
Rose <- wolf$Rose


plot(Rose)
title("1 Wolf")
plot(wolf, col=rainbow(length(wolf)))
title("8 Wolves")

# Loading in data
f <- curl("https://raw.githubusercontent.com/vzdanowicz/AN588_ctmm/main/wildebeest.csv")
data <- read.csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)




# Creating ctmm telemetry object (can be read directly from movebank)
wildebeest <- as.telemetry(data)

plot(wildebeest,col=rainbow(length(wildebeest)))

#pulling out specific inidividual
wolf.A <- wolf$`33677`
wolf.B <- wolf$`13793`

subdata <- list(wolf.A = wolf.A, wolf.B = wolf.B)

par(mfrow = c(1, 2))
plot(wildebeest$Nentepesi)
plot(wildebeest$Noontare)



par(mfrow = c(1, 2))
plot(wolf,col=rainbow(length(wolf)))
plot(wolf$`33679`)

