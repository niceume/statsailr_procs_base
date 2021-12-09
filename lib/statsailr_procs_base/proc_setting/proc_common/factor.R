STS_RC_Factor = setRefClass("STS_RC_Factor")
STS_RC_Factor$methods(
  convert_to_factor = function( data, vars ){
    data[vars] = lapply(data[vars], as.factor)
    print( paste( "as.factor is applied to", paste( vars, collapse=",") , sep=" ") )
    return( data )
  }
)

sts_factor = STS_RC_Factor()
