sts_dev_copy = new.env()

sts_dev_copy$dev_copy = function( device, ... ){
  dev.copy( device , ...)
  dev.off()
}
