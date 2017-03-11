#CACHE MATRIX INVERSION (W3 - Assig2)

#cachematrix() caches the inverse of a matrix rather than compute it repeatedly
#to save computation resources (taking as example makeVector() and cacheMean(),
#and Demystifying makeVector() Post to understand it)

#This program is divided in two functions: makeCacheMatrix() and cacheSolve()

#makeCacheMatrix() function creates a special "matrix" object that can cache 
#its inverse.

        #input: x, class matrix, invertible
        #output: matinverse, class matrix, inverse of input

makeCacheMatrix <- function(x = matrix()) {

        #Initialize the object x(matrix) as an argument in the function
        #Initialize the object matinverse inside the function
        #It will be the the matrix that cache the inverse
        matinverse <- NULL
        
        #A "setter" transforms data values within the object
        set <- function(y) {
                
                #Assign input argument to x object in the parent environment
                #Use <<- operator to assign input in the parent environment
                x <<- y
                
                #Assign NULL to matinverse object in parent environment to clear 
                #any matinverse value cached by a prior execution of cacheSolve()
                matinverse <<- NULL
                
        }
        
        #Defines "getter" for x matrix
        #Retrieve x from the parent environment of makeCacheMatrix()
        get <- function() x
        
        #Defines setter for the inverse 
        #matinverse is defined in parent environment 
        #Use <<- to assign input argument to matinverse in the parent environment
        setinv <- function(inverse) matinverse <<- inverse
        
        #Defines getter for matinverse
        getinv <- function() matinverse
        
        #Create a new object by returning a list()
        #Each element in list is named to allow the use of $ to access
        #functions by name
        list(set=set, get=get, setinv=setinv, getinv=getinv)
       
}


#cacheSolve() functioncomputes the inverse of matinverse returned by 
#makeCacheMatrix().

#Computing the inverse of a square matrix can be done with the solve function 
#in R. For example, if X is a square invertible matrix, then solve(X) returns 
#its inverse.

#For this assignment, assume that the matrix supplied is always invertible.

#Return a matrix that is the inverse of 'x'
cacheSolve <- function(x, ...) {
        
        #Retrieve the inverse from the object passed in as the argument
        matinverse <- x$getinv()
        
        #If the inverse has been calculated (and the matrix has not changed), 
        #then the cachesolve should retrieve the inverse from the cache.
        #Check if matinverse result is NULL. 
        if(!is.null(matinverse)) {
                message("getting cached data.")
                return(matinverse)
        }
        
        #If result FALSE, cacheSolve() gets the matrix from the input object...
        data <- x$get()
        
        #calculates inverese with solve()...
        matinverse <- solve(data)
        
        #uses setinv() func on input object to set inverse in input object...
        x$setinv(matinverse)
        
        #and returns the inverse matrix to the parent environment by printing 
        #the inverse object.
        matinverse
  
 }

##TEST from week 3 forum post "Simple test matrices for the lexical scoping 
#programming assignment"

        # > m1 <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2)
        # > m1
        #      [,1]  [,2]
        #[1,]  0.50 -1.00
        #[2,] -0.25  0.75
        # > M <- makeCacheMatrix(m1)
        # > cacheSolve(M)
        #      [,1] [,2]
        #[1,]    6    8
        #[2,]    2    4
        # > cacheSolve(M)
        #getting cached data.
        #      [,1] [,2]
        #[1,]    6    8
        #[2,]    2    4
