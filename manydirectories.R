library(archivist)
showGithubRepo( user="MarcinKosinski", repo="Museum", branch="master",
                repoDirGit="ex1")
showGithubRepo( user="MarcinKosinski", repo="Museum", branch="master",
                repoDirGit="ex2")

loadFromGithubRepo( "ff575c261c949d073b2895b05d1097c3", 
                    user="MarcinKosinski", repo="Museum", branch="master",
                repoDirGit="ex2")


loadFromGithubRepo( "ff575c261c949d073b2895b05d1097c3", 
                    user="MarcinKosinski", repo="Museum", branch="master",
                    repoDirGit="ex1")

searchInGithubRepo( pattern = "name", user="MarcinKosinski", repo="Museum", 
                    branch="master", repoDirGit="ex1", fixed = FALSE )

searchInGithubRepo( pattern = "name", user="MarcinKosinski", repo="Museum", 
                    branch="master", repoDirGit="ex2", fixed = FALSE )

getTagsGithub("ff575c261c949d073b2895b05d1097c3", user="MarcinKosinski", repo="Museum", 
              branch="master", repoDirGit="ex1",)

# when repository is in the main folder repoDirGit should not be specified
searchInGithubRepo( pattern = "name", user="pbiecek", repo="archivist", fixed=FALSE)

getTagsGithub("a250f9167c377e0de3b6bf85bfcf4e5a", user="pbiecek", repo="archivist")

