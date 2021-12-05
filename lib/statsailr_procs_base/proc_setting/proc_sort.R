sts_sort = new.env()

sts_sort$wrap_arrange = function( data, cond ){
  lang_cond = rlang::parse_exprs(cond)
  df = dplyr::arrange(data, !!! lang_cond)
  return(df)
}

sts_sort$assign_to = function(var, df){
  if( (! is.character(var)) || length(var) != 1 ){
    stop("var argument requires character vector with size of 1")
  }

  global_env = globalenv()
  global_env[[ var[1] ]] = df
  return(df)
}

sts_sort$finalizer = function( df, last_inst, out ){
  if( last_inst != "assign_to" ){
    if( is.null(out) ){
      cat("The last result is print out, and is not assigned to any variable.\n")
      print(head(df))
      cat("Use out= option for PROC COMMAND or use assing_to instruction\n")
      cat("to assign the last result to some variable.\n")
    }else{
      sts_sort$assign_to( out, df )
    }
  }else{
    # OK. The result dataframe is already assigned using assign_to instruction.
  }
}
