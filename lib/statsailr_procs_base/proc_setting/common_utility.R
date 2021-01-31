if_exist_else = function( name, lst, default_val ){
  if( name %in% names(lst)){
    return( lst[[name]] )
  }else{
    return( default_val )
  }
}

get_pkg_fun = function(x) {
    if(length(grep("::", x))>0) {
        parts<-strsplit(x, "::")[[1]]
        getExportedValue(parts[1], parts[2])
    } else {
        x
    }
}
