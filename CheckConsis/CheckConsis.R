###############################################################################
# Sweetpotato data consistency check
# Raul H. Eyzaguirre P.
###############################################################################

## Input list:
# mydata    : A data.frame with the experimental data.
# NOPS      : Number of plants planted per plot.
# plot.size : Plot size in m2.

# The data.frame must use standard labels for factors and traits as specified
# in the PROCEDURES FOR THE EVALUATION AND ANALYSIS OF SWEETPOTATO TRIALS,
# document. These labels are listed below: 

## Factors

# L       : Locations
# Y       : Year
# S       : Season
# G       : Genotypes
# NAME    : Names for genotypes
# E       : Environments
# R       : Replications or blocks

## Traits

# NOPS    : Number of plants planted
# NOPE    : Number of plants established
# VIR1    : Virus symptoms (1-9), first evaluation
# VIR2    : Virus symptoms (1-9), second evaluation
# ALT1    : Alternaria symptoms (1-9), first evaluation
# ALT2    : Alternaria symptoms (1-9), second evaluation
# VV1     : Vine vigor (1-9), first evaluation
# VW      : Vine weight
# NOPH    : Number of plants harvested
# NOPR    : Number of plants with roots
# NOCR    : Number of commercial roots
# NONC    : Number of non commercial roots
# CRW     : Commercial root weight
# NCRW    : Non commercial root weight
# RFCP    : Root primary flesh color
# RFCS    : Root secondary flesh color
# SCOL    : Storage root skin color
# FCOL    : Storage root flesh color
# RS      : Root size (1-9)
# RF      : Root form (1-9)
# DAMR    : Root defects (1-9)
# WED1    : Weevil damage (1-9), first evaluation
# DMF     : Fresh weight of roots for dry matter assessment
# DMD     : Dry weight of DMF samples
# FRAW1   : Root fiber (1-9), first determination
# SURAW1  : Root sugar (1-9), first determination
# STRAW1  : Root starch (1-9), first determination
# DMVF    : Fresh weight vines for dry matter assessment
# DMVD    : Dry weight of DMVF samples
# COOF1   : Cooked fiber (1-9), first evaluation
# COOSU1  : Cooked sugars (1-9), first evaluation
# COOST1  : Cooked starch (1-9), first evaluation
# COOT1   : Cooked taste (1-9), first evaluation
# COOAP1  : Cooked appearance (1-9), first evaluation
# VV2     : Vine vigor2 (1-9), second evaluation
# VIR3    : Virus symptoms (1-9), third evaluation
# WED2    : Weevil damage2 (1-9), second evaluation
# FRAW2   : Root fiber (1-9), second determination
# SURAW2  : Root sugar (1-9), second determination
# STRAW2  : Root starch (1-9), second determination
# COOF2   : Cooked fiber (1-9), second evaluation
# COOSU2  : Cooked sugars (1-9), second evaluation
# COOST2  : Cooked starch (1-9), second evaluation
# COOT2   : Cooked taste (1-9), second evaluation
# COOAP2  : Cooked appearance (1-9), second evaluation
# RSPR    : Root sprouting (1-9)
# PROT    : Protein
# FE      : Iron in dry weight
# ZN      : Zinc in dry weight
# CA      : Calcium in dry weight
# MG      : Magnesium in dry weight 
# BC      : Beta-carotene in dry weight (NIRS)
# BC.CC   : Beta-carotene with color charts
# TC      : Total carotenoids  in dry weight (NIRS)
# STAR    : Starch
# FRUC    : Fructose
# GLUC    : Glucose
# SUCR    : Sucrose
# MALT    : Maltose
# TRW     : Total root weight
# CYTHA   : Commercial root yield t/ ha
# RYTHA   : Total root yield t/ha
# ACRW    : Average commercial root weight = CRW/NOCR
# NRPP    : Number of roots per plant
# YPP     : Yield per plant Kg
# CI      : Percent marketable roots (commercial index)
# HI      : Harvest index
# SHI     : Harvest sowing index  (survival)
# BIOM    : Biomass yield
# FYTHA   : Foliage total yield t/ha
# DM      : Storage root dry matter content (%)
# DMFY    : Dry matter foliage yield 
# DMRY    : Dry matter root  yield
# RFR     : Root foliage ratio

## Output
# A file checks.txt with a list of
# - all rows with some kind of inconsistency
# - all rows with outliers

options(width=240)

sink("checks.txt")

## NOPS > NOPE > NOPH > NOPR
  
if (exists("NOPE", where=mydata)==1 & exists("NOPS", where=mydata)==1)
	if (dim(subset(mydata, NOPE>NOPS))[1]>0){
		cat("\n","Number of plants established (NOPE) greater than number of plants sowed (NOPS):","\n")
		subset(mydata, NOPE>NOPS)
	}

if (exists("NOPH", where=mydata)==1 & exists("NOPE", where=mydata)==1)
	if (dim(subset(mydata, NOPH>NOPE))[1]>0){
		cat("\n","Number of plants harvested (NOPH) greater than number of plants established (NOPE):","\n")
		subset(mydata, NOPH>NOPE)
	}

if (exists("NOPH", where=mydata)==1 & exists("NOPS", where=mydata)==1){
	if (exists("NOPE", where=mydata)==1){
		if (dim(subset(mydata, is.na(NOPE)==1 & NOPH>NOPS))[1]>0){
			cat("\n","Number of plants harvested (NOPH) greater than number of plants sowed (NOPS):","\n")
			subset(mydata, is.na(NOPE)==1 & NOPH>NOPS)			
		}
	} else {
		if (dim(subset(mydata, NOPH>NOPS))[1]>0){
			cat("\n","Number of plants harvested (NOPH) greater than number of plants sowed (NOPS):","\n")
			subset(mydata, NOPH>NOPS)
		}
	}
}

if (exists("NOPR", where=mydata)==1 & exists("NOPH", where=mydata)==1)
	if (dim(subset(mydata, NOPR>NOPH))[1]>0){
		cat("\n","Number of plants with roots (NOPR) greater than number of plants harvested (NOPH):","\n")
		subset(mydata, NOPR>NOPH)
	}

if (exists("NOPR", where=mydata)==1 & exists("NOPE", where=mydata)==1){
	if (exists("NOPH", where=mydata)==1){
		if (dim(subset(mydata, is.na(NOPH)==1 & NOPR>NOPE))[1]>0){
			cat("\n","Number of plants with roots (NOPR) greater than number of plants established (NOPE):","\n")
			subset(mydata, is.na(NOPH)==1 & NOPR>NOPE)
		}
	} else {
		if (dim(subset(mydata, NOPR>NOPE))[1]>0){
			cat("\n","Number of plants with roots (NOPR) greater than number of plants established (NOPE):","\n")
			subset(mydata, NOPR>NOPE)
		}
	}
}

if (exists("NOPR", where=mydata)==1 & exists("NOPS", where=mydata)==1){
	if (exists("NOPH", where=mydata)==1 & exists("NOPE", where=mydata)==1){
		if (dim(subset(mydata, is.na(NOPH)==1 & is.na(NOPE)==1 & NOPR>NOPS))[1]>0){
			cat("\n","Number of plants with roots (NOPR) greater than number of plants sowed (NOPS):","\n")
			subset(mydata, is.na(NOPH)==1 & is.na(NOPE)==1 & NOPR>NOPS)
		}
	} else {
		if (dim(subset(mydata, NOPR>NOPS))[1]>0){
			cat("\n","Number of plants with roots (NOPR) greater than number of plants sowed (NOPS):","\n")
			subset(mydata, NOPR>NOPS)
		}
	}
}

## NOPE and dependencies

if (exists("NOPE", where=mydata)==1 & exists("VIR1", where=mydata)==1)
	if (dim(subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(VIR1)==0))[1]>0){
		cat("\n","Number of plants established (NOPE) is zero or NA but there is data for virus symptoms first evaluation (VIR1):","\n")
		subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(VIR1)==0)
	}

if (exists("NOPE", where=mydata)==1 & exists("VIR2", where=mydata)==1)
	if (dim(subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(VIR2)==0))[1]>0){
		cat("\n","Number of plants established (NOPE) is zero or NA but there is data for virus symptoms second evaluation (VIR2):","\n")
		subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(VIR2)==0)
	}

if (exists("NOPE", where=mydata)==1 & exists("ALT1", where=mydata)==1)
	if (dim(subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(ALT1)==0))[1]>0){
		cat("\n","Number of plants established (NOPE) is zero or NA but there is data for alternaria symptoms first evaluation (ALT1):","\n")
		subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(ALT1)==0)
	}

if (exists("NOPE", where=mydata)==1 & exists("ALT2", where=mydata)==1)
	if (dim(subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(ALT2)==0))[1]>0){
		cat("\n","Number of plants established (NOPE) is zero or NA but there is data for alternaria symptoms second evaluation (ALT2):","\n")
		subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(ALT2)==0)
	}

if (exists("NOPE", where=mydata)==1 & exists("VV1", where=mydata)==1)
	if (dim(subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(VV1)==0))[1]>0){
		cat("\n","Number of plants established (NOPE) is zero or NA but there is data for vine vigor first evaluation (VV1):","\n")
		subset(mydata, (NOPE==0 | is.na(NOPE)==1) & is.na(VV1)==0)
	}

## NOPH and VW

if (exists("NOPH", where=mydata)==1 & exists("VW", where=mydata)==1)
	if (dim(subset(mydata, (NOPH==0 | is.na(NOPH)==1) & VW>0))[1]>0){
		cat("\n","Number of plants harvested (NOPH) is zero or NA but vine weight (VW) is greater than zero:","\n")
		subset(mydata, (NOPH==0 | is.na(NOPH)==1) & VW>0)
	}

if (exists("NOPH", where=mydata)==1 & exists("VW", where=mydata)==1)		
	if (dim(subset(mydata, NOPH>0 & (VW==0 | is.na(VW)==1)))[1]>0){
		cat("\n","Vine weight (VW) is zero or NA but the number of plants harvested (NOPH) is greater than zero:","\n")
		subset(mydata, NOPH>0 & (VW==0 | is.na(VW)==1))
	}

## VW and dependencies

if (exists("VW", where=mydata)==1 & exists("DMVF", where=mydata)==1)
	if (dim(subset(mydata, (VW==0 | is.na(VW)==1) & DMVF>0))[1]>0){
		cat("\n","Vine weight (VW) is zero or NA but there is fresh weight vines for dry matter assessment (DMVF):","\n")
		subset(mydata, (VW==0 | is.na(VW)==1) & DMVF>0)
	}

if (exists("VW", where=mydata)==1 & exists("DMVD", where=mydata)==1)
	if (dim(subset(mydata, (VW==0 | is.na(VW)==1) & DMVD>0))[1]>0){
		cat("\n","Vine weight (VW) is zero or NA but there is dry weight vines for dry matter assessment (DMVD):","\n")
		subset(mydata, (VW==0 | is.na(VW)==1) & DMVD>0)
	}

if (exists("DMVF", where=mydata)==1 & exists("DMVD", where=mydata)==1)
	if (dim(subset(mydata, DMVD>DMVF))[1]>0){
		cat("\n","Dry weight vines for dry matter assessment (DMVD) is greater than fresh weight vines for dry matter assessment (DBVF):","\n")
		subset(mydata, DMVD>DMVF)
	}

if (exists("VW", where=mydata)==1 & exists("VV2", where=mydata)==1)
	if (dim(subset(mydata, (VW==0 | is.na(VW)==1) & is.na(VV2)==0))[1]>0){
		cat("\n","Vine weight (VW) is zero or NA but there is data for vine vigor second evaluation (VV2):","\n")
		subset(mydata, (VW==0 | is.na(VW)==1) & is.na(VV2)==0)
	}

if (exists("VW", where=mydata)==1 & exists("VIR3", where=mydata)==1)
	if (dim(subset(mydata, (VW==0 | is.na(VW)==1) & is.na(VIR3)==0))[1]>0){
		cat("\n","Vine weight (VW) is zero or NA but there is data for virus symptoms third evaluation (VIR3):","\n")
		subset(mydata, (VW==0 | is.na(VW)==1) & is.na(VIR3)==0)
	}

## NOPR and number of roots

if (exists("NOPR", where=mydata)==1 & exists("NOCR", where=mydata)==1 & exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, (NOPR==0 | is.na(NOPR)==1) & (NOCR>0 | NONC>0)))[1]>0){
		cat("\n","Number of plants with roots (NOPR) is zero or NA but number of roots (NOCR+NONC) is greater than zero:","\n")
		subset(mydata, (NOPR==0 | is.na(NOPR)==1) & (NOCR>0 | NONC>0))
	}

if (exists("NOPR", where=mydata)==1 & exists("NOCR", where=mydata)==1 & exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, NOPR>0 & ((NOCR+NONC)==0 | (NOCR==0 & is.na(NONC)==1) | (is.na(NOCR)==1 & NONC==0) |
								(is.na(NOCR)==1 & is.na(NONC)==1))))[1]>0){
		cat("\n","Number of roots (NOCR+NONC) is zero or NA but number of plants with roots (NOPR) is greater than zero:","\n")
		subset(mydata, NOPR>0 & ((NOCR+NONC)==0 | (NOCR==0 & is.na(NONC)==1) | (is.na(NOCR)==1 & NONC==0) |
							(is.na(NOCR)==1 & is.na(NONC)==1)))
	}

## Number of roots and root weight

if (exists("NOCR", where=mydata)==1 & exists("CRW", where=mydata)==1)
	if (dim(subset(mydata, (NOCR==0 | is.na(NOCR)==1) & CRW>0))[1]>0){
		cat("\n","Number of commercial roots (NOCR) is zero or NA but the commercial root weight (CRW) is greater than zero:","\n")
		subset(mydata, (NOCR==0 | is.na(NOCR)==1) & CRW>0)
	}

if (exists("NOCR", where=mydata)==1 & exists("CRW", where=mydata)==1)
	if (dim(subset(mydata, NOCR>0 & (CRW==0 | is.na(CRW)==1)))[1]>0){
		cat("\n","Commercial root weight (CRW) is zero or NA but the number of commercial roots (NOCR) is greater than zero:","\n")
		subset(mydata, NOCR>0 & (CRW==0 | is.na(CRW)==1))
	}

if (exists("NONC", where=mydata)==1 & exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, (NONC==0 | is.na(NONC)==1) & NCRW>0))[1]>0){
		cat("\n","Number of non commercial roots (NONC) is zero or NA but the non commercial root weight (NCRW) is greater than zero:","\n")
		subset(mydata, (NONC==0 | is.na(NONC)==1) & NCRW>0)
	}

if (exists("NONC", where=mydata)==1 & exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, NONC>0 & (NCRW==0 | is.na(NCRW)==1)))[1]>0){
		cat("\n","Non commercial root weight (NCRW) is zero or NA but the number of non commercial roots (NONC) is greater than zero:","\n")
		subset(mydata, NONC>0 & (NCRW==0 | is.na(NCRW)==1))
	}

## TRW, CRW+NCRW, NOCR+NONC, NOPR

if (exists("TRW", where=mydata)==1 & exists("NOPR", where=mydata)==1)
	if (dim(subset(mydata, (TRW==0 | is.na(TRW)==1) & NOPR>0))[1]>0){
		cat("\n","Total root weight (TRW) is zero or NA but number of plants with roots (NOPR) is greater than zero:","\n")
		subset(mydata, (TRW==0 | is.na(TRW)==1) & NOPR>0)
	}

if (exists("TRW", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, (TRW==0 | is.na(TRW)==1) & (CRW>0 | NCRW>0)))[1]>0){
		cat("\n","Total root weight (TRW) is zero or NA but root weight (CRW+NCRW) is greater than zero:","\n")
		subset(mydata, (TRW==0 | is.na(TRW)==1) & (CRW>0 | NCRW>0))
	}

if (exists("TRW", where=mydata)==1 & exists("NOCR", where=mydata)==1 & exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, (TRW==0 | is.na(TRW)==1) & (NOCR>0 | NONC>0)))[1]>0){
		cat("\n","Total root weight (TRW) is zero or NA but number of roots (NOCR+NONC) is greater than zero:","\n")
		subset(mydata, (TRW==0 | is.na(TRW)==1) & (NOCR>0 | NONC>0))
	}

if (exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1 & exists("NOPR", where=mydata)==1)
	if (dim(subset(mydata, NOPR>0 & ((CRW+NCRW)==0 | (CRW==0 & is.na(NCRW)==1) | (is.na(CRW)==1 & NCRW==0) |
								(is.na(CRW)==1 & is.na(NCRW)==1))))[1]>0){
		cat("\n","Root weight (CRW+NCRW) is zero or NA but number of plants with roots (NOPR) is greater than zero:","\n")
		subset(mydata, NOPR>0 & ((CRW+NCRW)==0 | (CRW==0 & is.na(NCRW)==1) | (is.na(CRW)==1 & NCRW==0) |
							(is.na(CRW)==1 & is.na(NCRW)==1)))
	}

## Roots and dependencies

if (exists("NOPR", where=mydata)==1)
  mydata$RAUX <- mydata$NOPR else
    if (exists("NOCR", where=mydata)==1 & exists("NONC", where=mydata)==1)
      mydata$RAUX <- apply(cbind(mydata$NOCR, mydata$NONC), 1, sum, na.rm=T) else
        if (exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1)
          mydata$RAUX <- apply(cbind(mydata$CRW, mydata$NCRW), 1, sum, na.rm=T) else
            if (exists("TRW", where=mydata)==1)
              mydata$RAUX <- mydata$TRW else
                if (exists("RYTHA", where=mydata)==1)
                  mydata$RAUX <- mydata$RYTHA else
                    if (exists("CRW", where=mydata)==1)
                      mydata$RAUX <- mydata$CRW else
                        if (exists("CYTHA", where=mydata)==1)
                          mydata$RAUX <- mydata$CYTHA
	      
if (exists("RAUX", where=mydata)==1 & exists("RFCP", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RFCP)==0))[1]>0){
		cat("\n","There are no roots but there is data for root primary flesh color (RFCP):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RFCP)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("RFCS", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RFCS)==0))[1]>0){
		cat("\n","There are no roots but there is data for root secondary flesh color (RFCS):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RFCS)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("SCOL", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SCOL)==0))[1]>0){
		cat("\n","There are no roots but there is data for storage root skin color (SCOL):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SCOL)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("FCOL", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FCOL)==0))[1]>0){
		cat("\n","There are no roots but there is data for storage root flesh color (FCOL):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FCOL)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("RS", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RS)==0))[1]>0){
		cat("\n","There are no roots but there is data for root size (RS):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RS)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("RF", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RF)==0))[1]>0){
		cat("\n","There are no roots but there is data for root form (RF):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RF)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("DAMR", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(DAMR)==0))[1]>0){
		cat("\n","There are no roots but there is data for root defects (DAMR):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(DAMR)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("WED1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(WED1)==0))[1]>0){
		cat("\n","There are no roots but there is data for weevil damage first evaluation (WED1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(WED1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("DMF", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(DMF)==0))[1]>0){
		cat("\n","There are no roots but there is data for fresh weight of roots for dry matter assessment (DMF):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(DMF)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("DMD", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(DMD)==0))[1]>0){
		cat("\n","There are no roots but there is data for dry weight of roots for dry matter assessment (DMD):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(DMD)==0, select = -RAUX)
	}

if (exists("DMF", where=mydata)==1 & exists("DMD", where=mydata)==1)
	if (dim(subset(mydata, DMF<DMD))[1]>0){
		cat("\n","Dry weight of roots for dry matter assessment (DMD) is greater than fresh weight of roots for dry matter assessment (DMF):","\n")
		subset(mydata, DMF<DMD, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("FRAW1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FRAW1)==0))[1]>0){
		cat("\n","There are no roots but there is data for root fiber first determination (FRAW1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FRAW1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("SURAW1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SURAW1)==0))[1]>0){
		cat("\n","There are no roots but there is data for root sugar first determination (SURAW1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SURAW1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("STRAW1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(STRAW1)==0))[1]>0){
		cat("\n","There are no roots but there is data for root starch first determination (STRAW1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(STRAW1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOF1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOF1)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked fiber first evaluation (COOF1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOF1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOSU1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOSU1)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked sugars first evaluation (COOSU1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOSU1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOST1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOST1)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked starch first evaluation (COOST1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOST1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOT1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOT1)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked taste first evaluation (COOT1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOT1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOAP1", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOAP1)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked appearance first evaluation (COOAP1):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOAP1)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("WED2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(WED2)==0))[1]>0){
		cat("\n","There are no roots but there is data for weevil damage second evaluation (WED2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(WED2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("FRAW2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FRAW2)==0))[1]>0){
		cat("\n","There are no roots but there is data for root fiber second determination (FRAW2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FRAW2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("SURAW2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SURAW2)==0))[1]>0){
		cat("\n","There are no roots but there is data for root sugar second determination (SURAW2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SURAW2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("STRAW2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(STRAW2)==0))[1]>0){
		cat("\n","There are no roots but there is data for root starch second determination (STRAW2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(STRAW2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOF2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOF2)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked fiber second evaluation (COOF2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOF2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOSU2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOSU2)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked sugars second evaluation (COOSU2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOSU2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOST2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOST2)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked starch second evaluation (COOST2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOST2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOT2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOT2)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked taste second evaluation (COOT2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOT2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("COOAP2", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOAP2)==0))[1]>0){
		cat("\n","There are no roots but there is data for cooked appearance second evaluation (COOAP2):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(COOAP2)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("RSPR", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RSPR)==0))[1]>0){
		cat("\n","There are no roots but there is data for root sprouting (RSPR):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(RSPR)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("PROT", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(PROT)==0))[1]>0){
		cat("\n","There are no roots but there is data for protein (PROT):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(PROT)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("FE", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FE)==0))[1]>0){
		cat("\n","There are no roots but there is data for iron in dry weight (FE):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FE)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("ZN", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(ZN)==0))[1]>0){
		cat("\n","There are no roots but there is data for zinc in dry weight (ZN):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(ZN)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("CA", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(CA)==0))[1]>0){
		cat("\n","There are no roots but there is data for calcium in dry weight (CA):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(CA)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("MG", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(MG)==0))[1]>0){
		cat("\n","There are no roots but there is data for magnesium in dry weight (MG):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(MG)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("BC", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(BC)==0))[1]>0){
		cat("\n","There are no roots but there is data for beta-carotene in dry weight (BC):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(BC)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("TC", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(TC)==0))[1]>0){
		cat("\n","There are no roots but there is data for total carotenoids in dry weight (TC):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(TC)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("STAR", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(STAR)==0))[1]>0){
		cat("\n","There are no roots but there is data for starch (STAR):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(STAR)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("FRUC", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FRUC)==0))[1]>0){
		cat("\n","There are no roots but there is data for fructose (FRUC):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(FRUC)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("GLUC", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(GLUC)==0))[1]>0){
		cat("\n","There are no roots but there is data for glucose (GLUC):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(GLUC)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("SUCR", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SUCR)==0))[1]>0){
		cat("\n","There are no roots but there is data for sucrose (SUCR):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(SUCR)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("MALT", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(MALT)==0))[1]>0){
		cat("\n","There are no roots but there is data for maltose (MALT):","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & is.na(MALT)==0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("TRW", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & TRW>0))[1]>0){
		cat("\n","There are no roots but total root weight (TRW) is greater than zero:","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & TRW>0, select = -RAUX)
	}

if (exists("RAUX", where=mydata)==1 & exists("RYTHA", where=mydata)==1)
	if (dim(subset(mydata, (RAUX==0 | is.na(RAUX)==1) & RYTHA>0))[1]>0){
		cat("\n","There are no roots but total root yield (RYTHA) is greater than zero:","\n")
		subset(mydata, (RAUX==0 | is.na(RAUX)==1) & RYTHA>0, select = -RAUX)
	}

mydata$RAUX <- NULL

## Calculated variables

if (exists("TRW", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, abs(TRW-apply(cbind(mydata$CRW, mydata$NCRW), 1, sum, na.rm=T))>1e-10))[1]>0){
		cat("\n","Total root weight (TRW) different from CRW+NCRW:","\n")
		subset(mydata, abs(TRW-apply(cbind(mydata$CRW, mydata$NCRW), 1, sum, na.rm=T))>1e-10)
	}

if (exists("CYTHA", where=mydata)==1 & exists("CRW", where=mydata)==1)
	if (dim(subset(mydata, abs(CYTHA-CRW*10/plot.size)>1e-10))[1]>0){
		cat("\n","Commercial root yield in tons per hectare (CYTHA) is different from CRW*10/plot.size:","\n")
		subset(mydata, abs(CYTHA-CRW*10/plot.size)>1e-10)
	}

if (exists("RYTHA", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, abs(RYTHA-apply(cbind(CRW,NCRW), 1, sum, na.rm=T)*10/plot.size)>1e-10))[1]>0){
		cat("\n","Total root yield in tons per hectare (RYTHA) is different from (CRW+NCRW)*10/plot.size:","\n")
		subset(mydata, abs(RYTHA-apply(cbind(CRW,NCRW), 1, sum, na.rm=T)*10/plot.size)>1e-10)
	}

if (exists("ACRW", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NOCR", where=mydata)==1)
	if (dim(subset(mydata, abs(ACRW-CRW/NOCR)>1e-10))[1]>0){
		cat("\n","Average commercial root weight (ACRW) is different from CRW/NOCR:","\n")
		subset(mydata, abs(ACRW-CRW/NOCR)>1e-10)
	}

if (exists("NRPP", where=mydata)==1 & exists("NOCR", where=mydata)==1 & exists("NONC", where=mydata)==1 & exists("NOPH", where=mydata)==1)
	if (dim(subset(mydata, abs(NRPP-apply(cbind(NOCR,NONC), 1, sum, na.rm=T)/NOPH)>1e-10))[1]>0){
		cat("\n","Number of roots per plant (NRPP) is different from (NOCR+NONC)/NOPH:","\n")
		subset(mydata, abs(NRPP-apply(cbind(NOCR,NONC), 1, sum, na.rm=T)/NOPH)>1e-10)
	}

if (exists("YPP", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1 & exists("NOPH", where=mydata)==1)
	if (dim(subset(mydata, abs(YPP-apply(cbind(CRW, NCRW), 1, sum, na.rm=T)/NOPH)>1e-10))[1]>0){
		cat("\n","Yield per plant (YPP) is different from (CRW+NCRW)/NOPH:","\n")
		subset(mydata, abs(YPP-apply(cbind(CRW, NCRW), 1, sum, na.rm=T)/NOPH)>1e-10)
	}

if (exists("CI", where=mydata)==1 & exists("NOCR", where=mydata)==1 & exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, abs(CI-NOCR/apply(cbind(NOCR,NONC), 1, sum, na.rm=T)*100)>1e-10))[1]>0){
		cat("\n","Commercial index (CI) is different from NOCR/(NOCR+NONC)*100:","\n")
		subset(mydata, abs(CI-NOCR/apply(cbind(NOCR,NONC), 1, sum, na.rm=T)*100)>1e-10)
	}

if (exists("HI", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1 & exists("VW", where=mydata)==1)
	if (dim(subset(mydata, abs(HI-apply(cbind(CRW, NCRW), 1, sum, na.rm=T)/apply(cbind(VW, CRW, NCRW), 1, sum, na.rm=T)*100)>1e-10))[1]>0){
		cat("\n","Harvest index (HI) is different from (CRW+NCRW)/(VW+CRW+NCRW)*100:","\n")
		subset(mydata, abs(HI-apply(cbind(CRW, NCRW), 1, sum, na.rm=T)/apply(cbind(VW, CRW, NCRW), 1, sum, na.rm=T)*100)>1e-10)
	}

if (exists("SHI", where=mydata)==1 & exists("NOPH", where=mydata)==1 & exists("NOPS", where=mydata)==1)
	if (dim(subset(mydata, abs(SHI-NOPH/NOPS*100)>1e-10))[1]>0){
		cat("\n","Harvest sowing index (SHI) is different from NOPH/NOPS*100:","\n")
		subset(mydata, abs(SHI-NOPH/NOPS*100)>1e-10)
	}

if (exists("BIOM", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1 & exists("VW", where=mydata)==1)
	if (dim(subset(mydata, abs(BIOM-apply(cbind(VW, CRW, NCRW), 1, sum, na.rm=T)*10/plot.size)>1e-10))[1]>0){
		cat("\n","Biomass yield (BIOM) is different from (CRW+NCRW+VW)*10/plot.size:","\n")
		subset(mydata, abs(BIOM-apply(cbind(VW, CRW, NCRW), 1, sum, na.rm=T)*10/plot.size)>1e-10)
	}

if (exists("FYTHA", where=mydata)==1 & exists("VW", where=mydata)==1)
	if (dim(subset(mydata, abs(FYTHA-VW*10/plot.size)>1e-10))[1]>0){
		cat("\n","Foliage total yield in tons per hectare (FYTHA) is different from VW*10/plot.size:","\n")
		subset(mydata, abs(FYTHA-VW*10/plot.size)>1e-10)
	}

if (exists("DM", where=mydata)==1 & exists("DMD", where=mydata)==1 & exists("DMF", where=mydata)==1)
	if (dim(subset(mydata, abs(DM-DMD/DMF*100)>1e-10))[1]>0){
		cat("\n","Storage root dry matter content (DM) is different from DMD/DMF*100:","\n")
		subset(mydata, abs(DM-DMD/DMF*100)>1e-10)
	}

if (exists("DMFY", where=mydata)==1 & exists("VW", where=mydata)==1 & exists("DMVD", where=mydata)==1 & exists("DMVF", where=mydata)==1)
	if (dim(subset(mydata, abs(DMFY-VW*10/plot.size*DMVD/DMVF)>1e-10))[1]>0){
		cat("\n","Dry matter foliage yield (DMFY) is different from VW*10/plot.size*DMVD/DMVF:","\n")
		subset(mydata, abs(DMFY-VW*10/plot.size*DMVD/DMVF)>1e-10)
	}

if (exists("DMRY", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1
		& exists("DMD", where=mydata)==1 & exists("DMF", where=mydata)==1)
	if (dim(subset(mydata, DMRY!=apply(cbind(CRW, NCRW), 1, sum, na.rm=T)*10/plot.size*DMD/DMF))[1]>0){
		cat("\n","Dry matter root yield (DMRY) is different from (CRW+NCRW)*10/plot.size*DMD/DMF:","\n")
		subset(mydata, DMRY!=apply(cbind(CRW, NCRW), 1, sum, na.rm=T)*10/plot.size*DMD/DMF)
	}

if (exists("RFR", where=mydata)==1 & exists("CRW", where=mydata)==1 & exists("NCRW", where=mydata)==1 & exists("DMD", where=mydata)==1
		& exists("DMF", where=mydata)==1 & exists("VW", where=mydata)==1 & exists("DMVD", where=mydata)==1 & exists("DMVF", where=mydata)==1)
	if (dim(subset(mydata, abs(RFR-apply(cbind(CRW, NCRW), 1, sum, na.rm=T)*(DMD/DMF)/(VW*DMVD/DMVF))>1e-10))[1]>0){
		cat("\n","Root foliage ratio (RFR) is different from (CRW+NCRW)*(DMD/DMF)/(VW*DMVD/DMVF)*100:","\n")
		subset(mydata, abs(RFR-apply(cbind(CRW, NCRW), 1, sum, na.rm=T)*(DMD/DMF)/(VW*DMVD/DMVF))>1e-10)
	}

## Outliers detection based on interquartile range and values out of range

if (exists("NOPE", where=mydata)==1)
	if (dim(subset(mydata, NOPE < 0))[1]>0){
		cat("\n","Out of range values for number of plants established (NOPE):","\n")
		subset(mydata, NOPE < 0)
	}

if (exists("VIR1", where=mydata)==1)
	if (dim(subset(mydata, VIR1 < 1 | VIR1 > 9 ))[1]>0){
		cat("\n","Out of range values for virus symptoms first evaluation (VIR1):","\n")
		subset(mydata, VIR1 < 1 | VIR1 > 9)
	}

if (exists("VIR2", where=mydata)==1)
	if (dim(subset(mydata, VIR2 < 1 | VIR2 > 9 ))[1]>0){
		cat("\n","Out of range values for virus symptoms second evaluation (VIR2):","\n")
		subset(mydata, VIR2 < 1 | VIR2 > 9)
	}

if (exists("ALT1", where=mydata)==1)
	if (dim(subset(mydata, ALT1 < 1 | ALT1 > 9 ))[1]>0){
		cat("\n","Out of range values for alternaria symptoms first evaluation (ALT1):","\n")
		subset(mydata, ALT1 < 1 | ALT1 > 9)
	}

if (exists("ALT2", where=mydata)==1)
	if (dim(subset(mydata, ALT2 < 1 | ALT2 > 9 ))[1]>0){
		cat("\n","Out of range values for alternaria symptoms second evaluation (ALT2):","\n")
		subset(mydata, ALT2 < 1 | ALT2 > 9)
	}

if (exists("VV1", where=mydata)==1)
	if (dim(subset(mydata, VV1 < 1 | VV1 > 9 ))[1]>0){
		cat("\n","Out of range values for vine vigor first evaluation (VV1):","\n")
		subset(mydata, VV1 < 1 | VV1 > 9)
	}

if (exists("VW", where=mydata)==1)
	if (dim(subset(mydata, VW < 0))[1]>0){
		cat("\n","Out of range values for vine weight (VW):","\n")
		subset(mydata, VW < 0)
	}

if (exists("VW", where=mydata)==1)
	if (dim(subset(mydata, VW < quantile(VW, 0.25, na.rm=T)-3*IQR(VW, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for vine weight (VW):","\n")
		subset(mydata, VW < quantile(VW, 0.25, na.rm=T)-3*IQR(VW, na.rm=T))
	}

if (exists("VW", where=mydata)==1)
	if (dim(subset(mydata, VW > quantile(VW, 0.75, na.rm=T)+3*IQR(VW, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for vine weight (VW):","\n")
		subset(mydata, VW > quantile(VW, 0.75, na.rm=T)+3*IQR(VW, na.rm=T))
	}

if (exists("NOPH", where=mydata)==1)
	if (dim(subset(mydata, NOPH < 0))[1]>0){
		cat("\n","Out of range values for number of plants harvested (NOPH):","\n")
		subset(mydata, NOPH < 0)
	}

if (exists("NOPR", where=mydata)==1)
	if (dim(subset(mydata, NOPR < 0))[1]>0){
		cat("\n","Out of range values for number of plants with roots (NOPR):","\n")
		subset(mydata, NOPR < 0)
	}

if (exists("NOCR", where=mydata)==1)
	if (dim(subset(mydata, NOCR < 0))[1]>0){
		cat("\n","Out of range values for number of commercial roots (NOCR):","\n")
		subset(mydata, NOCR < 0)
	}

if (exists("NOCR", where=mydata)==1)
	if (dim(subset(mydata, NOCR < quantile(NOCR, 0.25, na.rm=T)-3*IQR(NOCR, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for number of commercial roots (NOCR):","\n")
		subset(mydata, NOCR < quantile(NOCR, 0.25, na.rm=T)-3*IQR(NOCR, na.rm=T))
	}

if (exists("NOCR", where=mydata)==1)
	if (dim(subset(mydata, NOCR > quantile(NOCR, 0.75, na.rm=T)+3*IQR(NOCR, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for number of commercial roots (NOCR):","\n")
		subset(mydata, NOCR > quantile(NOCR, 0.75, na.rm=T)+3*IQR(NOCR, na.rm=T))
	}

if (exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, NONC < 0))[1]>0){
		cat("\n","Out of range values for number of non commercial roots (NONC):","\n")
		subset(mydata, NONC < 0)
	}

if (exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, NONC < quantile(NONC, 0.25, na.rm=T)-3*IQR(NONC, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for number of non commercial roots (NONC):","\n")
		subset(mydata, NONC < quantile(NONC, 0.25, na.rm=T)-3*IQR(NONC, na.rm=T))
	}

if (exists("NONC", where=mydata)==1)
	if (dim(subset(mydata, NONC > quantile(NONC, 0.75, na.rm=T)+3*IQR(NONC, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for number of non commercial roots (NONC):","\n")
		subset(mydata, NONC > quantile(NONC, 0.75, na.rm=T)+3*IQR(NONC, na.rm=T))
	}

if (exists("CRW", where=mydata)==1)
	if (dim(subset(mydata, CRW < 0))[1]>0){
		cat("\n","Out of range values for commercial root weight (CRW):","\n")
		subset(mydata, CRW < 0)
	}

if (exists("CRW", where=mydata)==1)
	if (dim(subset(mydata, CRW < quantile(CRW, 0.25, na.rm=T)-3*IQR(CRW, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for commercial root weight (CRW):","\n")
		subset(mydata, CRW < quantile(CRW, 0.25, na.rm=T)-3*IQR(CRW, na.rm=T))
	}

if (exists("CRW", where=mydata)==1)
	if (dim(subset(mydata, CRW > quantile(CRW, 0.75, na.rm=T)+3*IQR(CRW, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for commercial root weight (CRW):","\n")
		subset(mydata, CRW > quantile(CRW, 0.75, na.rm=T)+3*IQR(CRW, na.rm=T))
	}

if (exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, NCRW < 0))[1]>0){
		cat("\n","Out of range values for non commercial root weight (NCRW):","\n")
		subset(mydata, NCRW < 0)
	}

if (exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, NCRW < quantile(NCRW, 0.25, na.rm=T)-3*IQR(NCRW, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for non commercial root weight (NCRW):","\n")
		subset(mydata, NCRW < quantile(NCRW, 0.25, na.rm=T)-3*IQR(NCRW, na.rm=T))
	}

if (exists("NCRW", where=mydata)==1)
	if (dim(subset(mydata, NCRW > quantile(NCRW, 0.75, na.rm=T)+3*IQR(NCRW, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for non commercial root weight (NCRW):","\n")
		subset(mydata, NCRW > quantile(NCRW, 0.75, na.rm=T)+3*IQR(NCRW, na.rm=T))
	}

if (exists("SCOL", where=mydata)==1)
	if (dim(subset(mydata, SCOL < 1 | SCOL > 9 ))[1]>0){
		cat("\n","Out of range values for storage root skin color (SCOL):","\n")
		subset(mydata, SCOL < 1 | SCOL > 9)
	}

if (exists("FCOL", where=mydata)==1)
	if (dim(subset(mydata, FCOL < 1 | FCOL > 9 ))[1]>0){
		cat("\n","Out of range values for storage root flesh color (FCOL):","\n")
		subset(mydata, FCOL < 1 | FCOL > 9)
	}

if (exists("RS", where=mydata)==1)
	if (dim(subset(mydata, RS < 1 | RS > 9 ))[1]>0){
		cat("\n","Out of range values for root size (RS):","\n")
		subset(mydata, RS < 1 | RS > 9)
	}

if (exists("RF", where=mydata)==1)
	if (dim(subset(mydata, RF < 1 | RF > 9 ))[1]>0){
		cat("\n","Out of range values for root form (RF):","\n")
		subset(mydata, RF < 1 | RF > 9)
	}

if (exists("DAMR", where=mydata)==1)
	if (dim(subset(mydata, DAMR < 1 | DAMR > 9 ))[1]>0){
		cat("\n","Out of range values for root defects (DAMR):","\n")
		subset(mydata, DAMR < 1 | DAMR > 9)
	}

if (exists("WED1", where=mydata)==1)
	if (dim(subset(mydata, WED1 < 1 | WED1 > 9 ))[1]>0){
		cat("\n","Out of range values for weevil damage first evaluation (WED1):","\n")
		subset(mydata, WED1 < 1 | WED1 > 9)
	}

if (exists("DMF", where=mydata)==1)
	if (dim(subset(mydata, DMF < 0))[1]>0){
		cat("\n","Out of range values for fresh weight of roots for dry matter assessment (DMF):","\n")
		subset(mydata, DMF < 0)
	}

if (exists("DMF", where=mydata)==1)
	if (dim(subset(mydata, DMF < quantile(DMF, 0.25, na.rm=T)-3*IQR(DMF, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for fresh weight of roots for dry matter assessment (DMF):","\n")
		subset(mydata, DMF < quantile(DMF, 0.25, na.rm=T)-3*IQR(DMF, na.rm=T))
	}

if (exists("DMF", where=mydata)==1)
	if (dim(subset(mydata, DMF > quantile(DMF, 0.75, na.rm=T)+3*IQR(DMF, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for fresh weight of roots for dry matter assessment (DMF):","\n")
		subset(mydata, DMF > quantile(DMF, 0.75, na.rm=T)+3*IQR(DMF, na.rm=T))
	}

if (exists("DMD", where=mydata)==1)
	if (dim(subset(mydata, DMD < 0))[1]>0){
		cat("\n","Out of range values for dry weight of roots for dry matter assessment (DMD):","\n")
		subset(mydata, DMD < 0)
	}

if (exists("DMD", where=mydata)==1)
	if (dim(subset(mydata, DMD < quantile(DMD, 0.25, na.rm=T)-3*IQR(DMD, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for dry weight of roots for dry matter assessment (DMD):","\n")
		subset(mydata, DMD < quantile(DMD, 0.25, na.rm=T)-3*IQR(DMD, na.rm=T))
	}

if (exists("DMD", where=mydata)==1)
	if (dim(subset(mydata, DMD > quantile(DMD, 0.75, na.rm=T)+3*IQR(DMD, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for dry weight of roots for dry matter assessment (DMD):","\n")
		subset(mydata, DMD > quantile(DMD, 0.75, na.rm=T)+3*IQR(DMD, na.rm=T))
	}

if (exists("FRAW1", where=mydata)==1)
	if (dim(subset(mydata, FRAW1 < 1 | FRAW1 > 9 ))[1]>0){
		cat("\n","Out of range values for root fiber first determination (FRAW1):","\n")
		subset(mydata, FRAW1 < 1 | FRAW1 > 9)
	}

if (exists("SURAW1", where=mydata)==1)
	if (dim(subset(mydata, SURAW1 < 1 | SURAW1 > 9 ))[1]>0){
		cat("\n","Out of range values for root sugar first determination (SURAW1):","\n")
		subset(mydata, SURAW1 < 1 | SURAW1 > 9)
	}

if (exists("STRAW1", where=mydata)==1)
	if (dim(subset(mydata, STRAW1 < 1 | STRAW1 > 9 ))[1]>0){
		cat("\n","Out of range values for root starch first determination (STRAW1):","\n")
		subset(mydata, STRAW1 < 1 | STRAW1 > 9)
	}

if (exists("DMVF", where=mydata)==1)
	if (dim(subset(mydata, DMVF < 0))[1]>0){
		cat("\n","Out of range values for fresh weight vines for dry matter assessment (DMVF):","\n")
		subset(mydata, DMVF < 0)
	}

if (exists("DMVF", where=mydata)==1)
	if (dim(subset(mydata, DMVF < quantile(DMVF, 0.25, na.rm=T)-3*IQR(DMVF, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for fresh weight of vines for dry matter assessment (DMVF):","\n")
		subset(mydata, DMVF < quantile(DMVF, 0.25, na.rm=T)-3*IQR(DMVF, na.rm=T))
	}

if (exists("DMVF", where=mydata)==1)
	if (dim(subset(mydata, DMVF > quantile(DMVF, 0.75, na.rm=T)+3*IQR(DMVF, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for fresh weight of vines for dry matter assessment (DMVF):","\n")
		subset(mydata, DMVF > quantile(DMVF, 0.75, na.rm=T)+3*IQR(DMVF, na.rm=T))
	}

if (exists("DMVD", where=mydata)==1)
	if (dim(subset(mydata, DMVD < 0))[1]>0){
		cat("\n","Out of range values for dry weight of vines for dry matter assessment (DMVD):","\n")
		subset(mydata, DMVD < 0)
	}

if (exists("DMVD", where=mydata)==1)
	if (dim(subset(mydata, DMVD < quantile(DMVD, 0.25, na.rm=T)-3*IQR(DMVD, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for dry weight of vines for dry matter assessment (DMVD):","\n")
		subset(mydata, DMVD < quantile(DMVD, 0.25, na.rm=T)-3*IQR(DMVD, na.rm=T))
	}

if (exists("DMVD", where=mydata)==1)
	if (dim(subset(mydata, DMVD > quantile(DMVD, 0.75, na.rm=T)+3*IQR(DMVD, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for dry weight of vines for dry matter assessment (DMVD):","\n")
		subset(mydata, DMVD > quantile(DMVD, 0.75, na.rm=T)+3*IQR(DMVD, na.rm=T))
	}

if (exists("COOF1", where=mydata)==1)
	if (dim(subset(mydata, COOF1 < 1 | COOF1 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked fiber first evaluation (COOF1):","\n")
		subset(mydata, COOF1 < 1 | COOF1 > 9)
	}

if (exists("COOSU1", where=mydata)==1)
	if (dim(subset(mydata, COOSU1 < 1 | COOSU1 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked sugars first evaluation (COOSU1):","\n")
		subset(mydata, COOSU1 < 1 | COOSU1 > 9)
	}

if (exists("COOST1", where=mydata)==1)
	if (dim(subset(mydata, COOST1 < 1 | COOST1 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked starch first evaluation (COOST1):","\n")
		subset(mydata, COOST1 < 1 | COOST1 > 9)
	}

if (exists("COOT1", where=mydata)==1)
	if (dim(subset(mydata, COOT1 < 1 | COOT1 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked taste first evaluation (COOT1):","\n")
		subset(mydata, COOT1 < 1 | COOT1 > 9)
	}

if (exists("COOAP1", where=mydata)==1)
	if (dim(subset(mydata, COOAP1 < 1 | COOAP1 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked appearance first evaluation (COOAP1):","\n")
		subset(mydata, COOAP1 < 1 | COOAP1 > 9)
	}

if (exists("VV2", where=mydata)==1)
	if (dim(subset(mydata, VV2 < 1 | VV2 > 9 ))[1]>0){
		cat("\n","Out of range values for vine vigor second evaluation (VV2):","\n")
		subset(mydata, VV2 < 1 | VV2 > 9)
	}

if (exists("VIR3", where=mydata)==1)
	if (dim(subset(mydata, VIR3 < 1 | VIR3 > 9 ))[1]>0){
		cat("\n","Out of range values for virus symptoms third evaluation (VIR3):","\n")
		subset(mydata, VIR3 < 1 | VIR3 > 9)
	}

if (exists("WED2", where=mydata)==1)
	if (dim(subset(mydata, WED2 < 1 | WED2 > 9 ))[1]>0){
		cat("\n","Out of range values for weevil damage second evaluation (WED2):","\n")
		subset(mydata, WED2 < 1 | WED2 > 9)
	}

if (exists("FRAW2", where=mydata)==1)
	if (dim(subset(mydata, FRAW2 < 1 | FRAW2 > 9 ))[1]>0){
		cat("\n","Out of range values for root fiber second determination (FRAW2):","\n")
		subset(mydata, FRAW2 < 1 | FRAW2 > 9)
	}

if (exists("SURAW2", where=mydata)==1)
	if (dim(subset(mydata, SURAW2 < 1 | SURAW2 > 9 ))[1]>0){
		cat("\n","Out of range values for root sugar second determination (SURAW2):","\n")
		subset(mydata, SURAW2 < 1 | SURAW2 > 9)
	}

if (exists("STRAW2", where=mydata)==1)
	if (dim(subset(mydata, STRAW2 < 1 | STRAW2 > 9 ))[1]>0){
		cat("\n","Out of range values for root starch second determination (STRAW2):","\n")
		subset(mydata, STRAW2 < 1 | STRAW2 > 9)
	}

if (exists("COOF2", where=mydata)==1)
	if (dim(subset(mydata, COOF2 < 1 | COOF2 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked fiber second evaluation (COOF2):","\n")
		subset(mydata, COOF2 < 1 | COOF2 > 9)
	}

if (exists("COOSU2", where=mydata)==1)
	if (dim(subset(mydata, COOSU2 < 1 | COOSU2 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked sugars second evaluation (COOSU2):","\n")
		subset(mydata, COOSU2 < 1 | COOSU2 > 9)
	}

if (exists("COOST2", where=mydata)==1)
	if (dim(subset(mydata, COOST2 < 1 | COOST2 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked starch second evaluation (COOST2):","\n")
		subset(mydata, COOST2 < 1 | COOST2 > 9)
	}

if (exists("COOT2", where=mydata)==1)
	if (dim(subset(mydata, COOT2 < 1 | COOT2 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked taste second evaluation (COOT2):","\n")
		subset(mydata, COOT2 < 1 | COOT2 > 9)
	}

if (exists("COOAP2", where=mydata)==1)
	if (dim(subset(mydata, COOAP2 < 1 | COOAP2 > 9 ))[1]>0){
		cat("\n","Out of range values for cooked appearance second evaluation (COOAP2):","\n")
		subset(mydata, COOAP2 < 1 | COOAP2 > 9)
	}

if (exists("RSPR", where=mydata)==1)
	if (dim(subset(mydata, RSPR < 1 | RSPR > 9 ))[1]>0){
		cat("\n","Out of range values for root sprouting (RSPR):","\n")
		subset(mydata, RSPR < 1 | RSPR > 9)
	}

if (exists("PROT", where=mydata)==1)
	if (dim(subset(mydata, PROT < 0))[1]>0){
		cat("\n","Out of range values for protein (PROT):","\n")
		subset(mydata, PROT < 0)
	}

if (exists("PROT", where=mydata)==1)
	if (dim(subset(mydata, PROT < quantile(PROT, 0.25, na.rm=T)-3*IQR(PROT, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for protein (PROT):","\n")
		subset(mydata, PROT < quantile(PROT, 0.25, na.rm=T)-3*IQR(PROT, na.rm=T))
	}

if (exists("PROT", where=mydata)==1)
	if (dim(subset(mydata, PROT > quantile(PROT, 0.75, na.rm=T)+3*IQR(PROT, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for protein (PROT):","\n")
		subset(mydata, PROT > quantile(PROT, 0.75, na.rm=T)+3*IQR(PROT, na.rm=T))
	}

if (exists("FE", where=mydata)==1)
	if (dim(subset(mydata, FE < 0))[1]>0){
		cat("\n","Out of range values for iron in dry weight (FE):","\n")
		subset(mydata, FE < 0)
	}

if (exists("FE", where=mydata)==1)
	if (dim(subset(mydata, FE < quantile(FE, 0.25, na.rm=T)-3*IQR(FE, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for iron in dry weight (FE):","\n")
		subset(mydata, FE < quantile(FE, 0.25, na.rm=T)-3*IQR(FE, na.rm=T))
	}

if (exists("FE", where=mydata)==1)
	if (dim(subset(mydata, FE > quantile(FE, 0.75, na.rm=T)+3*IQR(FE, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for iron in dry weight (FE):","\n")
		subset(mydata, FE > quantile(FE, 0.75, na.rm=T)+3*IQR(FE, na.rm=T))
	}

if (exists("ZN", where=mydata)==1)
	if (dim(subset(mydata, ZN < 0))[1]>0){
		cat("\n","Out of range values for zinc in dry weight (ZN):","\n")
		subset(mydata, ZN < 0)
	}

if (exists("ZN", where=mydata)==1)
	if (dim(subset(mydata, ZN < quantile(ZN, 0.25, na.rm=T)-3*IQR(ZN, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for zinc in dry weight (ZN):","\n")
		subset(mydata, ZN < quantile(ZN, 0.25, na.rm=T)-3*IQR(ZN, na.rm=T))
	}

if (exists("ZN", where=mydata)==1)
	if (dim(subset(mydata, ZN > quantile(ZN, 0.75, na.rm=T)+3*IQR(ZN, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for zinc in dry weight (ZN):","\n")
		subset(mydata, ZN > quantile(ZN, 0.75, na.rm=T)+3*IQR(ZN, na.rm=T))
	}

if (exists("CA", where=mydata)==1)
	if (dim(subset(mydata, CA < 0))[1]>0){
		cat("\n","Out of range values for calcium in dry weight (CA):","\n")
		subset(mydata, CA < 0)
	}

if (exists("CA", where=mydata)==1)
	if (dim(subset(mydata, CA < quantile(CA, 0.25, na.rm=T)-3*IQR(CA, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for calcium in dry weight (CA):","\n")
		subset(mydata, CA < quantile(CA, 0.25, na.rm=T)-3*IQR(CA, na.rm=T))
	}

if (exists("CA", where=mydata)==1)
	if (dim(subset(mydata, CA > quantile(CA, 0.75, na.rm=T)+3*IQR(CA, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for calcium in dry weight (CA):","\n")
		subset(mydata, CA > quantile(CA, 0.75, na.rm=T)+3*IQR(CA, na.rm=T))
	}

if (exists("MG", where=mydata)==1)
	if (dim(subset(mydata, MG < 0))[1]>0){
		cat("\n","Out of range values for magnesium in dry weight (MG):","\n")
		subset(mydata, MG < 0)
	}

if (exists("MG", where=mydata)==1)
	if (dim(subset(mydata, MG < quantile(MG, 0.25, na.rm=T)-3*IQR(MG, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for magnesium in dry weight (MG):","\n")
		subset(mydata, MG < quantile(MG, 0.25, na.rm=T)-3*IQR(MG, na.rm=T))
	}

if (exists("MG", where=mydata)==1)
	if (dim(subset(mydata, MG > quantile(MG, 0.75, na.rm=T)+3*IQR(MG, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for magnesium in dry weight (MG):","\n")
		subset(mydata, MG > quantile(MG, 0.75, na.rm=T)+3*IQR(MG, na.rm=T))
	}

if (exists("BC", where=mydata)==1)
	if (dim(subset(mydata, BC < 0))[1]>0){
		cat("\n","Out of range values for beta-carotene in dry weight (BC):","\n")
		subset(mydata, BC < 0)
	}

if (exists("BC", where=mydata)==1)
	if (dim(subset(mydata, BC < quantile(BC, 0.25, na.rm=T)-3*IQR(BC, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for beta-carotene in dry weight (BC):","\n")
		subset(mydata, BC < quantile(BC, 0.25, na.rm=T)-3*IQR(BC, na.rm=T))
	}

if (exists("BC", where=mydata)==1)
	if (dim(subset(mydata, BC > quantile(BC, 0.75, na.rm=T)+3*IQR(BC, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for beta-carotene in dry weight (BC):","\n")
		subset(mydata, BC > quantile(BC, 0.75, na.rm=T)+3*IQR(BC, na.rm=T))
	}

if (exists("TC", where=mydata)==1)
	if (dim(subset(mydata, TC < 0))[1]>0){
		cat("\n","Out of range values for total carotenoids in dry weight (TC):","\n")
		subset(mydata, TC < 0)
	}

if (exists("TC", where=mydata)==1)
	if (dim(subset(mydata, TC < quantile(TC, 0.25, na.rm=T)-3*IQR(TC, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for total carotenoids in dry weight (TC):","\n")
		subset(mydata, TC < quantile(TC, 0.25, na.rm=T)-3*IQR(TC, na.rm=T))
	}

if (exists("TC", where=mydata)==1)
	if (dim(subset(mydata, TC > quantile(TC, 0.75, na.rm=T)+3*IQR(TC, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for total carotenoids in dry weight (TC):","\n")
		subset(mydata, TC > quantile(TC, 0.75, na.rm=T)+3*IQR(TC, na.rm=T))
	}

if (exists("STAR", where=mydata)==1)
	if (dim(subset(mydata, STAR < 0))[1]>0){
		cat("\n","Out of range values for starch (STAR):","\n")
		subset(mydata, STAR < 0)
	}

if (exists("STAR", where=mydata)==1)
	if (dim(subset(mydata, STAR < quantile(STAR, 0.25, na.rm=T)-3*IQR(STAR, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for starch (STAR):","\n")
		subset(mydata, STAR < quantile(STAR, 0.25, na.rm=T)-3*IQR(STAR, na.rm=T))
	}

if (exists("STAR", where=mydata)==1)
	if (dim(subset(mydata, STAR > quantile(STAR, 0.75, na.rm=T)+3*IQR(STAR, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for starch (STAR):","\n")
		subset(mydata, STAR > quantile(STAR, 0.75, na.rm=T)+3*IQR(STAR, na.rm=T))
	}

if (exists("FRUC", where=mydata)==1)
	if (dim(subset(mydata, FRUC < 0))[1]>0){
		cat("\n","Out of range values for fructose (FRUC):","\n")
		subset(mydata, FRUC < 0)
	}

if (exists("FRUC", where=mydata)==1)
	if (dim(subset(mydata, FRUC < quantile(FRUC, 0.25, na.rm=T)-3*IQR(FRUC, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for fructose (FRUC):","\n")
		subset(mydata, FRUC < quantile(FRUC, 0.25, na.rm=T)-3*IQR(FRUC, na.rm=T))
	}

if (exists("FRUC", where=mydata)==1)
	if (dim(subset(mydata, FRUC > quantile(FRUC, 0.75, na.rm=T)+3*IQR(FRUC, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for fructose (FRUC):","\n")
		subset(mydata, FRUC > quantile(FRUC, 0.75, na.rm=T)+3*IQR(FRUC, na.rm=T))
	}

if (exists("GLUC", where=mydata)==1)
	if (dim(subset(mydata, GLUC < 0))[1]>0){
		cat("\n","Out of range values for glucose (GLUC):","\n")
		subset(mydata, GLUC < 0)
	}

if (exists("GLUC", where=mydata)==1)
	if (dim(subset(mydata, GLUC < quantile(GLUC, 0.25, na.rm=T)-3*IQR(GLUC, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for glucose (GLUC):","\n")
		subset(mydata, GLUC < quantile(GLUC, 0.25, na.rm=T)-3*IQR(GLUC, na.rm=T))
	}

if (exists("GLUC", where=mydata)==1)
	if (dim(subset(mydata, GLUC > quantile(GLUC, 0.75, na.rm=T)+3*IQR(GLUC, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for glucose (GLUC):","\n")
		subset(mydata, GLUC > quantile(GLUC, 0.75, na.rm=T)+3*IQR(GLUC, na.rm=T))
	}

if (exists("SUCR", where=mydata)==1)
	if (dim(subset(mydata, SUCR < 0))[1]>0){
		cat("\n","Out of range values for sucrose (SUCR):","\n")
		subset(mydata, SUCR < 0)
	}

if (exists("SUCR", where=mydata)==1)
	if (dim(subset(mydata, SUCR < quantile(SUCR, 0.25, na.rm=T)-3*IQR(SUCR, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for sucrose (SUCR):","\n")
		subset(mydata, SUCR < quantile(SUCR, 0.25, na.rm=T)-3*IQR(SUCR, na.rm=T))
	}

if (exists("SUCR", where=mydata)==1)
	if (dim(subset(mydata, SUCR > quantile(SUCR, 0.75, na.rm=T)+3*IQR(SUCR, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for sucrose (SUCR):","\n")
		subset(mydata, SUCR > quantile(SUCR, 0.75, na.rm=T)+3*IQR(SUCR, na.rm=T))
	}

if (exists("MALT", where=mydata)==1)
	if (dim(subset(mydata, MALT < 0))[1]>0){
		cat("\n","Out of range values for maltose (MALT):","\n")
		subset(mydata, MALT < 0)
	}

if (exists("MALT", where=mydata)==1)
	if (dim(subset(mydata, MALT < quantile(MALT, 0.25, na.rm=T)-3*IQR(MALT, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for maltose (MALT):","\n")
		subset(mydata, MALT < quantile(MALT, 0.25, na.rm=T)-3*IQR(MALT, na.rm=T))
	}

if (exists("MALT", where=mydata)==1)
	if (dim(subset(mydata, MALT > quantile(MALT, 0.75, na.rm=T)+3*IQR(MALT, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for maltose (MALT):","\n")
		subset(mydata, MALT > quantile(MALT, 0.75, na.rm=T)+3*IQR(MALT, na.rm=T))
	}

if (exists("TRW", where=mydata)==1)
	if (dim(subset(mydata, TRW < 0))[1]>0){
		cat("\n","Out of range values for total root weight (TRW):","\n")
		subset(mydata, TRW < 0)
	}

if (exists("TRW", where=mydata)==1)
	if (dim(subset(mydata, TRW < quantile(TRW, 0.25, na.rm=T)-3*IQR(TRW, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for total root weight (TRW):","\n")
		subset(mydata, TRW < quantile(TRW, 0.25, na.rm=T)-3*IQR(TRW, na.rm=T))
	}

if (exists("TRW", where=mydata)==1)
	if (dim(subset(mydata, TRW > quantile(TRW, 0.75, na.rm=T)+3*IQR(TRW, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for total root weight (TRW):","\n")
		subset(mydata, TRW > quantile(TRW, 0.75, na.rm=T)+3*IQR(TRW, na.rm=T))
	}

if (exists("CYTHA", where=mydata)==1)
	if (dim(subset(mydata, CYTHA < 0))[1]>0){
		cat("\n","Out of range values for commercial root yield in tons per hectare (CYTHA):","\n")
		subset(mydata, CYTHA < 0)
	}

if (exists("CYTHA", where=mydata)==1)
	if (dim(subset(mydata, CYTHA < quantile(CYTHA, 0.25, na.rm=T)-3*IQR(CYTHA, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for commercial root yield in tons per hectare (CYTHA):","\n")
		subset(mydata, CYTHA < quantile(CYTHA, 0.25, na.rm=T)-3*IQR(CYTHA, na.rm=T))
	}

if (exists("CYTHA", where=mydata)==1)
	if (dim(subset(mydata, CYTHA > quantile(CYTHA, 0.75, na.rm=T)+3*IQR(CYTHA, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for commercial root yield in tons per hectare (CYTHA):","\n")
		subset(mydata, CYTHA > quantile(CYTHA, 0.75, na.rm=T)+3*IQR(CYTHA, na.rm=T))
	}

if (exists("RYTHA", where=mydata)==1)
	if (dim(subset(mydata, RYTHA < 0))[1]>0){
		cat("\n","Out of range values for total root yield in tons per hectare (RYTHA):","\n")
		subset(mydata, RYTHA < 0)
	}

if (exists("RYTHA", where=mydata)==1)
	if (dim(subset(mydata, RYTHA < quantile(RYTHA, 0.25, na.rm=T)-3*IQR(RYTHA, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for total root yield in tons per hectare (RYTHA):","\n")
		subset(mydata, RYTHA < quantile(RYTHA, 0.25, na.rm=T)-3*IQR(RYTHA, na.rm=T))
	}

if (exists("RYTHA", where=mydata)==1)
	if (dim(subset(mydata, RYTHA > quantile(RYTHA, 0.75, na.rm=T)+3*IQR(RYTHA, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for total root yield in tons per hectare (RYTHA):","\n")
		subset(mydata, RYTHA > quantile(RYTHA, 0.75, na.rm=T)+3*IQR(RYTHA, na.rm=T))
	}

if (exists("ACRW", where=mydata)==1)
	if (dim(subset(mydata, ACRW < 0))[1]>0){
		cat("\n","Out of range values for average commercial root weight (ACRW):","\n")
		subset(mydata, ACRW < 0)
	}

if (exists("ACRW", where=mydata)==1)
	if (dim(subset(mydata, ACRW < quantile(ACRW, 0.25, na.rm=T)-3*IQR(ACRW, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for average commercial root weight (ACRW):","\n")
		subset(mydata, ACRW < quantile(ACRW, 0.25, na.rm=T)-3*IQR(ACRW, na.rm=T))
	}

if (exists("ACRW", where=mydata)==1)
	if (dim(subset(mydata, ACRW > quantile(ACRW, 0.75, na.rm=T)+3*IQR(ACRW, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for average commercial root weight (ACRW):","\n")
		subset(mydata, ACRW > quantile(ACRW, 0.75, na.rm=T)+3*IQR(ACRW, na.rm=T))
	}

if (exists("NRPP", where=mydata)==1)
	if (dim(subset(mydata, NRPP < 0))[1]>0){
		cat("\n","Out of range values for number of roots per plant (NRPP):","\n")
		subset(mydata, NRPP < 0)
	}

if (exists("NRPP", where=mydata)==1)
	if (dim(subset(mydata, NRPP < quantile(NRPP, 0.25, na.rm=T)-3*IQR(NRPP, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for number of roots per plant (NRPP):","\n")
		subset(mydata, NRPP < quantile(NRPP, 0.25, na.rm=T)-3*IQR(NRPP, na.rm=T))
	}

if (exists("NRPP", where=mydata)==1)
	if (dim(subset(mydata, NRPP > quantile(NRPP, 0.75, na.rm=T)+3*IQR(NRPP, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for number of roots per plant (NRPP):","\n")
		subset(mydata, NRPP > quantile(NRPP, 0.75, na.rm=T)+3*IQR(NRPP, na.rm=T))
	}

if (exists("YPP", where=mydata)==1)
	if (dim(subset(mydata, YPP < 0))[1]>0){
		cat("\n","Out of range values for yield per plant (YPP):","\n")
		subset(mydata, YPP < 0)
	}

if (exists("YPP", where=mydata)==1)
	if (dim(subset(mydata, YPP < quantile(YPP, 0.25, na.rm=T)-3*IQR(YPP, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for yield per plant (YPP):","\n")
		subset(mydata, YPP < quantile(YPP, 0.25, na.rm=T)-3*IQR(YPP, na.rm=T))
	}

if (exists("YPP", where=mydata)==1)
	if (dim(subset(mydata, YPP > quantile(YPP, 0.75, na.rm=T)+3*IQR(YPP, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for yield per plant (YPP):","\n")
		subset(mydata, YPP > quantile(YPP, 0.75, na.rm=T)+3*IQR(YPP, na.rm=T))
	}

if (exists("CI", where=mydata)==1)
	if (dim(subset(mydata, CI < 0 | CI > 100))[1]>0){
		cat("\n","Out of range values for commercial index (CI):","\n")
		subset(mydata, CI < 0 | CI > 100)
	}

if (exists("CI", where=mydata)==1)
	if (dim(subset(mydata, CI < quantile(CI, 0.25, na.rm=T)-3*IQR(CI, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for commercial index (CI):","\n")
		subset(mydata, CI < quantile(CI, 0.25, na.rm=T)-3*IQR(CI, na.rm=T))
	}

if (exists("CI", where=mydata)==1)
	if (dim(subset(mydata, CI > quantile(CI, 0.75, na.rm=T)+3*IQR(CI, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for commercial index (CI):","\n")
		subset(mydata, CI > quantile(CI, 0.75, na.rm=T)+3*IQR(CI, na.rm=T))
	}

if (exists("HI", where=mydata)==1)
	if (dim(subset(mydata, HI < 0 | HI > 100))[1]>0){
		cat("\n","Out of range values for harvest index (HI):","\n")
		subset(mydata, HI < 0 | HI > 100)
	}

if (exists("HI", where=mydata)==1)
	if (dim(subset(mydata, HI < quantile(HI, 0.25, na.rm=T)-3*IQR(HI, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for harvest index (HI):","\n")
		subset(mydata, HI < quantile(HI, 0.25, na.rm=T)-3*IQR(HI, na.rm=T))
	}

if (exists("HI", where=mydata)==1)
	if (dim(subset(mydata, HI > quantile(HI, 0.75, na.rm=T)+3*IQR(HI, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for harvest index (HI):","\n")
		subset(mydata, HI > quantile(HI, 0.75, na.rm=T)+3*IQR(HI, na.rm=T))
	}

if (exists("SHI", where=mydata)==1)
	if (dim(subset(mydata, SHI < 0 | SHI > 100))[1]>0){
		cat("\n","Out of range values for harvest sowing index (SHI):","\n")
		subset(mydata, SHI < 0 | SHI > 100)
	}

if (exists("SHI", where=mydata)==1)
	if (dim(subset(mydata, SHI < quantile(SHI, 0.25, na.rm=T)-3*IQR(SHI, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for harvest sowing index (SHI):","\n")
		subset(mydata, SHI < quantile(SHI, 0.25, na.rm=T)-3*IQR(SHI, na.rm=T))
	}

if (exists("SHI", where=mydata)==1)
	if (dim(subset(mydata, SHI > quantile(SHI, 0.75, na.rm=T)+3*IQR(SHI, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for harvest sowing index (SHI):","\n")
		subset(mydata, SHI > quantile(SHI, 0.75, na.rm=T)+3*IQR(SHI, na.rm=T))
	}	

if (exists("BIOM", where=mydata)==1)
	if (dim(subset(mydata, BIOM < 0))[1]>0){
		cat("\n","Out of range values for biomass yield (BIOM):","\n")
		subset(mydata, BIOM < 0)
	}

if (exists("BIOM", where=mydata)==1)
	if (dim(subset(mydata, BIOM < quantile(BIOM, 0.25, na.rm=T)-3*IQR(BIOM, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for biomass yield (BIOM):","\n")
		subset(mydata, BIOM < quantile(BIOM, 0.25, na.rm=T)-3*IQR(BIOM, na.rm=T))
	}

if (exists("BIOM", where=mydata)==1)
	if (dim(subset(mydata, BIOM > quantile(BIOM, 0.75, na.rm=T)+3*IQR(BIOM, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for biomass yield (BIOM):","\n")
		subset(mydata, BIOM > quantile(BIOM, 0.75, na.rm=T)+3*IQR(BIOM, na.rm=T))
	}	

if (exists("FYTHA", where=mydata)==1)
	if (dim(subset(mydata, FYTHA < 0))[1]>0){
		cat("\n","Out of range values for foliage total yield in tons per hectare (FYTHA):","\n")
		subset(mydata, FYTHA < 0)
	}

if (exists("FYTHA", where=mydata)==1)
	if (dim(subset(mydata, FYTHA < quantile(FYTHA, 0.25, na.rm=T)-3*IQR(FYTHA, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for foliage total yield in tons per hectare (FYTHA):","\n")
		subset(mydata, FYTHA < quantile(FYTHA, 0.25, na.rm=T)-3*IQR(FYTHA, na.rm=T))
	}

if (exists("FYTHA", where=mydata)==1)
	if (dim(subset(mydata, FYTHA > quantile(FYTHA, 0.75, na.rm=T)+3*IQR(FYTHA, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for foliage total yield in tons per hectare (FYTHA):","\n")
		subset(mydata, FYTHA > quantile(FYTHA, 0.75, na.rm=T)+3*IQR(FYTHA, na.rm=T))
	}	

if (exists("DM", where=mydata)==1)
	if (dim(subset(mydata, DM < 0 | DM > 100))[1]>0){
		cat("\n","Out of range values for storage root dry matter content (DM):","\n")
		subset(mydata, DM < 0 | DM > 100)
	}

if (exists("DM", where=mydata)==1)
	if (dim(subset(mydata, DM < quantile(DM, 0.25, na.rm=T)-3*IQR(DM, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for storage root dry matter content (DM):","\n")
		subset(mydata, DM < quantile(DM, 0.25, na.rm=T)-3*IQR(DM, na.rm=T))
	}

if (exists("DM", where=mydata)==1)
	if (dim(subset(mydata, DM > quantile(DM, 0.75, na.rm=T)+3*IQR(DM, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for storage root dry matter content (DM):","\n")
		subset(mydata, DM > quantile(DM, 0.75, na.rm=T)+3*IQR(DM, na.rm=T))
	}	

if (exists("DMFY", where=mydata)==1)
	if (dim(subset(mydata, DMFY < 0))[1]>0){
		cat("\n","Out of range values for dry matter foliage yield (DMFY):","\n")
		subset(mydata, DMFY < 0)
	}

if (exists("DMFY", where=mydata)==1)
	if (dim(subset(mydata, DMFY < quantile(DMFY, 0.25, na.rm=T)-3*IQR(DMFY, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for dry matter foliage yield (DMFY):","\n")
		subset(mydata, DMFY < quantile(DMFY, 0.25, na.rm=T)-3*IQR(DMFY, na.rm=T))
	}

if (exists("DMFY", where=mydata)==1)
	if (dim(subset(mydata, DMFY > quantile(DMFY, 0.75, na.rm=T)+3*IQR(DMFY, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for dry matter foliage yield (DMFY):","\n")
		subset(mydata, DMFY > quantile(DMFY, 0.75, na.rm=T)+3*IQR(DMFY, na.rm=T))
	}	

if (exists("DMRY", where=mydata)==1)
	if (dim(subset(mydata, DMRY < 0))[1]>0){
		cat("\n","Out of range values for dry matter root yield (DMRY):","\n")
		subset(mydata, DMRY < 0)
	}

if (exists("DMRY", where=mydata)==1)
	if (dim(subset(mydata, DMRY < quantile(DMRY, 0.25, na.rm=T)-3*IQR(DMRY, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for dry matter root yield (DMRY):","\n")
		subset(mydata, DMRY < quantile(DMRY, 0.25, na.rm=T)-3*IQR(DMRY, na.rm=T))
	}

if (exists("DMRY", where=mydata)==1)
	if (dim(subset(mydata, DMRY > quantile(DMRY, 0.75, na.rm=T)+3*IQR(DMRY, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for dry matter root yield (DMRY):","\n")
		subset(mydata, DMRY > quantile(DMRY, 0.75, na.rm=T)+3*IQR(DMRY, na.rm=T))
	}	

if (exists("RFR", where=mydata)==1)
	if (dim(subset(mydata, RFR < 0 | RFR > 100))[1]>0){
		cat("\n","Out of range values for root foliage ratio (RFR):","\n")
		subset(mydata, RFR < 0 | RFR > 100)
	}

if (exists("RFR", where=mydata)==1)
	if (dim(subset(mydata, RFR < quantile(RFR, 0.25, na.rm=T)-3*IQR(RFR, na.rm=T)))[1]>0){
		cat("\n","Extreme low values for root foliage ratio (RFR):","\n")
		subset(mydata, RFR < quantile(RFR, 0.25, na.rm=T)-3*IQR(RFR, na.rm=T))
	}

if (exists("RFR", where=mydata)==1)
	if (dim(subset(mydata, RFR > quantile(RFR, 0.75, na.rm=T)+3*IQR(RFR, na.rm=T)))[1]>0){
		cat("\n","Extreme high values for root foliage ratio (RFR):","\n")
		subset(mydata, RFR > quantile(RFR, 0.75, na.rm=T)+3*IQR(RFR, na.rm=T))
	}	

sink()
