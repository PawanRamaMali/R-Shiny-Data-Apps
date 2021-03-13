library(plumber)


#* @apiTitle Plumber Example API demo

#* Echo back the input
#* @param msg The message to echo in output
#* @get /echo 

function(msg = ""){
  list(msg = paste0("The message is : ", msg," ."))
}



function(){
  rand <- rnorm(100)
  hist(rand)
}
