sts_plot = new.env()

sts_plot$legend = function( legend , ... ){
  if( (! is.character(legend)) ){
    stop("legend argument requires character vector")
  }

  args = list(...)
  args$legend = legend
  args$x = if_exist_else ( "x", args, paste( "topleft" ))

  do.call( get_pkg_fun( "graphics::legend") , args )
}

sts_plot$hist = function( data , var , ... ){
  if( (! is.character(var)) || length(var) != 1 ){
    stop("vars argument requires character vector with size of 1")
  }

  args = list(...)
  args$x = data[[var]]
  args$main = if_exist_else ( "main", args, paste( "Frequency of" , var ))
  args$xlab = if_exist_else ( "xlab", args, paste( var ))

  do.call( get_pkg_fun( "graphics::hist") , args )
}

sts_plot$box = function( data , var , ... ){
  if( (! is.character(var)) || length(var) != 1 ){
    stop("vars argument requires character vector with size of 1")
  }

  args = list(...)
  args$x = data[[var]]
  args$main = if_exist_else ( "main", args, paste( var ))
  args$lex.order = TRUE

  do.call( get_pkg_fun( "graphics::boxplot"), args ) 
}

sts_plot$scatter = function( data , vars , ... ){
  if( (! is.character(vars)) || length(vars) != 2 ){
    stop("vars argument requires character vector with size of 2")
  }

  args = list(...)
  args$x = data[vars]
  args$main = if_exist_else ( "main", args, paste( vars[1], "vs", vars[2] ))

  do.call( get_pkg_fun( "graphics::plot"), args )
}

