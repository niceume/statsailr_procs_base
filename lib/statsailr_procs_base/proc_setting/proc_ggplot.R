sts_ggplot = new.env()

library(rlang)
library(ggplot2)

sts_ggplot$mapping = function( data, assoc ){
  assoc_lang = rlang::parse_exprs(assoc)
  # https://github.com/tidyverse/ggplot2/issues/2675
  gg = ggplot2::ggplot(data, ggplot2::aes( ,, !!! assoc_lang ))
  return( gg )
}

sts_ggplot$geom_point_wrapper = function( gg, params = NULL, ... ){
  if( is.null(params) ){
    gg = gg + ggplot2::geom_point()
  }else{
    params_lang = rlang::parse_exprs(params)
    # https://stackoverflow.com/questions/68379666/how-to-specify-a-package-or-namespace-for-rlangexec
    # https://stackoverflow.com/questions/70202220/big-bang-operator-for-ggplot2-geom-point-function
    # real_fun <- get("geom_point", envir=as.environment(paste0("package:", "ggplot2")))
    # gg = gg + rlang::exec(real_fun, !!! params_lang , ...)
    gg = gg + rlang::inject(ggplot2::geom_point( !!! params_lang , ...))
  }
  return( gg )
}

sts_ggplot$geom_histogram_wrapper = function( gg, params = NULL, ...){
  if( is.null(params) ){
    gg = gg + ggplot2::geom_histogram()
  }else{
    params_lang = rlang::parse_exprs(params)
    gg = gg + rlang::inject(ggplot2::geom_histogram( !!! params_lang , ...))
  }
  return( gg )
}

sts_ggplot$finalizer = function( gg ){
 plot(gg)
}
