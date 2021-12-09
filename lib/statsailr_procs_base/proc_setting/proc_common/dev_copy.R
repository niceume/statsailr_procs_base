STS_RC_DevCopy = setRefClass("STS_RC_DevCopy")
STS_RC_DevCopy$methods(
  dev_copy = function( device, ... ){
    dev.copy( device , ...)
    dev.off()
  }
)

sts_dev_copy = STS_RC_DevCopy()
