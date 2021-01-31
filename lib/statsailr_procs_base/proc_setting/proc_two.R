sts_two = new.env()

sts_two$t_test = function( data , vars , ... ){
  if( (! is.character(vars)) || length(vars) != 2 ){
    stop("vars argument requires character vector with size of 2")
  }
  x = vars[1]
  y = vars[2]
  result = t.test( data[[x]], data[[y]], ... )
  return(result)
}

sts_two$paired = function( data , vars , ... ){
  if( (! is.character(vars)) || length(vars) != 2 ){
    stop("vars argument requires character vector with size of 2")
  }
  x = vars[1]
  y = vars[2]
  result = t.test( data[[x]], data[[y]], paired = TRUE, ... )
  return(result)
}

sts_two$wilcox_test = function( data , vars , ... ){
  if( (! is.character(vars)) || length(vars) != 2 ){
    stop("vars argument requires character vector with size of 2")
  }
  x = vars[1]
  y = vars[2]
  result = wilcox.test( data[[x]], data[[y]], ... )
  return(result)
}


