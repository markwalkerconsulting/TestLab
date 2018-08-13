	# .\CacheCredentials.ps1
    
    # Set the cache to timeout after 6 hour (setting is in seconds)
    git config --global credential.helper 'cache --timeout=21600' 
	
	# Set git to use the credential memory cache
	git config --global credential.helper cache
 

