STS_RC_Numeric = setRefClass("STS_RC_Numeric")
STS_RC_Numeric$methods(
  convert_to_numeric = function( data, vars ){
    data[vars] = lapply(data[vars], as.numeric)
    print( paste( "as.numeric is applied to", paste( vars, collapse=",") , sep=" ") )
    return( data )
  }
)

sts_numeric = STS_RC_Numeric()
