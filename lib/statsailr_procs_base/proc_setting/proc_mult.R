STS_RC_Mult = setRefClass("STS_RC_Mult")
STS_RC_Mult$methods(
  p_adjust = function( x , method ){
    ori_p = summary(x)[[1]][['Pr(>F)']]
    result = p.adjust( ori_p, method )

    cat( "p adjustment\n" )
    cat( paste( "Method:", method, "\n", sep=" ", collapse=" " ) )
    return(result)
  }
)

sts_mult = STS_RC_Mult()
