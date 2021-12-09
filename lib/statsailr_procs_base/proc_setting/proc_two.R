STS_RC_Two = setRefClass("STS_RC_Two")
STS_RC_Two$methods(
  t_test = function( data , vars , ... ){
    if( (! is.character(vars)) || length(vars) != 2 ){
      stop("vars argument requires character vector with size of 2")
    }
    x = vars[1]
    y = vars[2]
    result = t.test( data[[x]], data[[y]], ... )
    return(result)
  },

  paired = function( data , vars , ... ){
    if( (! is.character(vars)) || length(vars) != 2 ){
      stop("vars argument requires character vector with size of 2")
    }
    x = vars[1]
    y = vars[2]
    result = t.test( data[[x]], data[[y]], paired = TRUE, ... )
    return(result)
  },

  wilcox_test = function( data , vars , ... ){
    if( (! is.character(vars)) || length(vars) != 2 ){
      stop("vars argument requires character vector with size of 2")
    }
    x = vars[1]
    y = vars[2]
    result = wilcox.test( data[[x]], data[[y]], ... )
    return(result)
  }
)

sts_two = STS_RC_Two()

