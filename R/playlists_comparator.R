library(spotifyr)

Sys.setenv(SPOTIFY_CLIENT_ID = 'b5c4a61095b74ce597f886697704ea3c')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '6b2271624f0c49a9abb65255b84cb462')
access_token <- get_spotify_access_token()

######################################################################################################################################################

compare_countries <- function(countries=list("DE","AR","AU","AT","BE","BO","BR","BG","CA","CZ","CL","CO","CR","DK","EC","SV","SK","ES","US","EE","PH","FI","FR","GR","GT","NL","HN","HK","HU","IN","ID","IE","IS","IL","IT","JP","LV","LT","LU","MY","MT","MX","NI","NO","NZ","PA","PY","PE","PL","PT","UK","DO","RO","SG","ZA","SE","SW","TH","TW","TK","UY","VN")){
  # Load dataframe containing the URI of each countries's playlist:
  top50df<-read.csv("countries_uri.csv")
  # Remove duplicates from input list:
  countries <- countries[!duplicated(countries)]
  # Check that all elements of the input list are correct:
  if( prod(countries %in% top50df$CODE)==0 )
    stop("The input list contains non-valid country codes!")
  
  i <- 1
  followers <- list()
  explicit <- list()
  playlists <- list()
  for(country in countries){
    uri_top_playlist <- as.vector( top50df[top50df$CODE==country,]$URI )
    top_songs <- get_playlist( uri_top_playlist , fields=c("name","followers","tracks") , authorization=get_spotify_access_token() )
    songs_id <- top_songs[["tracks"]][["items"]][["track.id"]]
    followers <- c(followers,as.numeric(top_songs[["followers"]][["total"]]))
    explicit <- c(explicit,sum(top_songs[["tracks"]][["items"]][["track.explicit"]])/length(songs_id))
    playlists[[i]] <- songs_id
    i <- i + 1
  }
  
  avg_features <- data.frame()
  for(playlist in playlists){
    features <- data.frame()
    for(song in playlist){
      features[nrow(features)+1,1:11] <- get_track_audio_features(song)[,1:11]
    }
    avg_features[nrow(avg_features)+1,1:11] <- apply(features,2,mean)
  }
  avg_features$code <- sapply(countries, paste0, collapse=",")
  avg_features$followers <- as.numeric(sapply(followers, paste0, collapse=","))
  avg_features$expl <- sapply(explicit, paste0, collapse=",")
  names(avg_features) <- c("Danceability","Energy","Key","Loudness","Mode","Speechiness","Acousticness","Instrumentalness","Liveness","Valence","Tempo","Code","Followers","Explicit")
  
  return(avg_features)
}

get_followers <- function(){
  read.csv("countries_uri.csv")
  
  countries=list("DE","AR","AU","AT","BE","BO","BR","BG","CA","CZ","CL","CO","CR","DK","EC","SV","SK","ES","US","EE","PH","FI","FR","GR","GT","NL","HN","HK","HU","IN","ID","IE","IS","IL","IT","JP","LV","LT","LU","MY","MT","MX","NI","NO","NZ","PA","PY","PE","PL","PT","UK","DO","RO","SG","ZA","SE","SW","TH","TW","TK","UY","VN")
  
  followers <- list()
  for(country in countries){
    uri_top_playlist <- as.vector( top50df[top50df$CODE==country,]$URI )
    top_songs <- get_playlist( uri_top_playlist , fields=c("name","followers","tracks") , authorization=get_spotify_access_token() )
    followers <- c(followers,as.numeric(top_songs[["followers"]][["total"]]))
  }
  result_df <- data.frame(followers)
  names(result_df) <- countries
  return(result_df)
	# Load dataframe containing the URI of each countries's playlist:
	read.csv("countries_uri.csv")
	# Remove duplicates from input list:
	countries <- countries[!duplicated(countries)]
	# Check that all elements of the input list are correct:
	if( prod(countries %in% top50df$CODE)==0 )
		stop("The input list contains non-valid country codes!")
	
	i <- 1
	followers <- list()
	explicit <- list()
	playlists <- list()
	for(country in countries){
		uri_top_playlist <- as.vector( top50df[top50df$CODE==country,]$URI )
		top_songs <- get_playlist( uri_top_playlist , fields=c("name","followers","tracks") , authorization=get_spotify_access_token() )
		songs_id <- top_songs[["tracks"]][["items"]][["track.id"]]
		followers <- c(followers,as.numeric(top_songs[["followers"]][["total"]]))
		explicit <- c(explicit,sum(top_songs[["tracks"]][["items"]][["track.explicit"]])/length(songs_id))
		playlists[[i]] <- songs_id
		i <- i + 1
	}
	
	avg_features <- data.frame()
	for(playlist in playlists){
		features <- data.frame()
		for(song in playlist){
			features[nrow(features)+1,1:11] <- get_track_audio_features(song)[,1:11]
		}
		avg_features[nrow(avg_features)+1,1:11] <- apply(features,2,mean)
	}
	avg_features$code <- sapply(countries, paste0, collapse=",")
	avg_features$followers <- as.numeric(sapply(followers, paste0, collapse=","))
	avg_features$expl <- sapply(explicit, paste0, collapse=",")
	names(avg_features) <- c("danceability","energy","key","loudness","mode","speechiness","acousticness","instrumentalness","liveness","valence","tempo","code","followers","explicit")
	
	return(avg_features)
}

get_followers <- function(){
	read.csv("countries_uri.csv")
	
	countries=list("DE","AR","AU","AT","BE","BO","BR","BG","CA","CZ","CL","CO","CR","DK","EC","SV","SK","ES","US","EE","PH","FI","FR","GR","GT","NL","HN","HK","HU","IN","ID","IE","IS","IL","IT","JP","LV","LT","LU","MY","MT","MX","NI","NO","NZ","PA","PY","PE","PL","PT","UK","DO","RO","SG","ZA","SE","SW","TH","TW","TK","UY","VN")
	
	followers <- list()
	for(country in countries){
		uri_top_playlist <- as.vector( top50df[top50df$CODE==country,]$URI )
		top_songs <- get_playlist( uri_top_playlist , fields=c("name","followers","tracks") , authorization=get_spotify_access_token() )
		followers <- c(followers,as.numeric(top_songs[["followers"]][["total"]]))
	}
	result_df <- data.frame(followers)
	names(result_df) <- countries
	return(result_df)
}

######################################################################################################################################################

get_explicit <- function(){
  read.csv("countries_uri.csv")
  countries=list("DE","AR","AU","AT","BE","BO","BR","BG","CA","CZ","CL","CO","CR","DK","EC","SV","SK","ES","US","EE","PH","FI","FR","GR","GT","NL","HN","HK","HU","IN","ID","IE","IS","IL","IT","JP","LV","LT","LU","MY","MT","MX","NI","NO","NZ","PA","PY","PE","PL","PT","UK","DO","RO","SG","ZA","SE","SW","TH","TW","TK","UY","VN")
  
  explicit <- list()
  for(country in countries){
    uri_top_playlist <- as.vector( top50df[top50df$CODE==country,]$URI )
    top_songs <- get_playlist( uri_top_playlist , fields=c("name","followers","tracks") , authorization=get_spotify_access_token() )
    explicit <- c(explicit,sum(top_songs[["tracks"]][["items"]][["track.explicit"]])/50)
  }
  result_df <- data.frame(explicit)
  names(result_df) <- countries
  return(result_df)
	read.csv("countries_uri.csv")
	
	countries=list("DE","AR","AU","AT","BE","BO","BR","BG","CA","CZ","CL","CO","CR","DK","EC","SV","SK","ES","US","EE","PH","FI","FR","GR","GT","NL","HN","HK","HU","IN","ID","IE","IS","IL","IT","JP","LV","LT","LU","MY","MT","MX","NI","NO","NZ","PA","PY","PE","PL","PT","UK","DO","RO","SG","ZA","SE","SW","TH","TW","TK","UY","VN")
	
	explicit <- list()
	for(country in countries){
		uri_top_playlist <- as.vector( top50df[top50df$CODE==country,]$URI )
		top_songs <- get_playlist( uri_top_playlist , fields=c("name","followers","tracks") , authorization=get_spotify_access_token() )
		explicit <- c(explicit,sum(top_songs[["tracks"]][["items"]][["track.explicit"]])/50)
	}
	result_df <- data.frame(explicit)
	names(result_df) <- countries
	return(result_df)
}

######################################################################################################################################################

# EXECUTION EXAMPLES:

#fllws <- get_followers()
#expls <- get_explicit()
#avgs <- compare_countries(list("PT","ES"))
#avgsALL <- compare_countries()
