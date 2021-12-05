sts_group = new.env()

library(rlang)

sts_group$wrap_group_by = function(data, vars){
    vars_lang = rlang::parse_exprs(vars)
    grouped_data = rlang::inject(dplyr::group_by( data, !!! vars_lang ))
    return(grouped_data)
}


sts_group$wrap_mutate = function(data, params){
    params_lang = rlang::parse_exprs(params)
    mutated_data = rlang::inject(dplyr::mutate( data, !!! params_lang ))
    return(mutated_data)
}


sts_group$wrap_summarize = function(data, params){
    params_lang = rlang::parse_exprs(params)
    result = rlang::inject(dplyr::summarize( data, !!! params_lang ))
    print(result)
    return(data)
}


sts_group$assign_to = function(var, df){
  df = as.data.frame(df)

  if( (! is.character(var)) || length(var) != 1 ){
    stop("var argument requires character vector with size of 1")
  }

  global_env = globalenv()
  global_env[[ var[1] ]] = df
  return(df)
}

sts_group$finalizer = function( df, last_inst, out ){
  df = as.data.frame(df)

  if( last_inst != "assign_to" ){
    if( is.null(out) ){
      cat("The last result is print out, and is not assigned to any variable.\n")
      print(head(df))
      cat("Use out= option for PROC COMMAND or use assing_to instruction\n")
      cat("to assign the last result to some variable.\n")
    }else{
      sts_group$assign_to( out, df )
    }
  }else{
    # OK. The result dataframe is already assigned using assign_to instruction.
  }
}

