
#!/bin/bash

##destfolder=/nfs/rprscratch/wwwShare/genome.grid.wayne.edu/preeclampsia/${PWD##*/}
prefix=/nfs/rprscratch/wwwShare/cell-ranger-atac/

if [[ -n $(git status --porcelain | grep -v '^??') ]]; then
    echo "There are uncommitted changes."
    exit 1
fi

# Check if the current branch is up to date with its upstream branch
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
DATE=$(date -Iminutes)

if [ $LOCAL = $REMOTE ]; then
    echo "Up to date with remote."
else
    echo "Diverged from remote."
    exit 1
fi

destfolder=${prefix}/${LOCAL}/${DATE}

mkdir -p $destfolder

ln -s $destfolder results

cat libList.txt | while read f; 
do 
    echo $f 
    cp $f/web_summary.html $destfolder/$f.html 
done

module load R 
Rscript makesummary.R 

cp summary.tsv $destfolder/
cp all_summary.csv $destfolder/
cp summary.html $destfolder/
