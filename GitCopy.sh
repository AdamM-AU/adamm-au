#!/bin/bash
#GitCopy.sh - Simple Tool for Cloning a Repo will Full Commit History
#Adam M (S3875753@student.rmit.edu.au)

echo "Full Repo Clone with Commit Histroy!"
if [ -z ${1+x} ]
then
        echo "No Origin/Source Repo!"
        echo "GitCopy.sh <Origin/Source> <Destination/Target>"
        exit
fi

if [ -z ${2+x} ]
then
        echo "No Destination/Target Repo!"
        echo "GitCopy.sh <Origin/Source> <Destination/Target>"		
        exit
fi

echo "Target: $1"
echo "Destination: $2"
mkdir GitCopy-Temp
cd GitCopy-Temp

#Origin/Source Repo
RepoDir=${1##*/}
RepoDir=${RepoDir%".git"}

git clone $1
cd $RepoDir
git remote rm origin
git filter-branch --subdirectory-filter ./ -- --all
git add .
git commit
cd ..
mv $RepoDir $RepoDir"-Source"
#End of Origin/Source Repo


#Destination/Target Repo
RepoDir2=${2##*/}
RepoDir2=${RepoDir2%".git"}

git clone $2
cd $RepoDir2
git remote add origin-repo ../$RepoDir"-Source"
git pull origin-repo master
git remote rm origin-repo
git push
# End of Destination/Target Repo

echo " "
echo "All Tasks Completed!"
echo "You may now delete Directory GitCopy-Temp"