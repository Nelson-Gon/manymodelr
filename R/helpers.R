# These are helper functions that should never have been exported
# Convenience functions for use with get_exponent
# These are useful for get_exponent

expo<-function(n){
  force(n)
  function(x){
    res<-x^n
    
  }
}


expo1<-function(y,x){
  
  
  target<-expo(x)
  res<-target(y)
  return(data.frame(Val=y,Pow=x,Res=res))
}


