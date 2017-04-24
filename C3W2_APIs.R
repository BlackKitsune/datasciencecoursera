#### C3W2 - APIs

# API: Application programming interfaces (like twitter)
# Create and account of developer team 
# Create and application like "Statistics"

## Accessing Twitter from R
# use the httr packae to start the process
myapp = oauth_app("twitter",
                  key = "youtConsumerKeyHere",
                  secret = "yourConsumerSecretHere")
# Sign into the application
sig = sign_oauth1.0(myapp, 
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
# Take the data as a json file with authentication sig
homeTl = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

## Converting the json object
json1 = content(homeT1)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

## How do I know the url to use?
# Twitter documentation --> Resource URL
