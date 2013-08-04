#!/bin/bash
jekyll 
rsync -av _site/ loongfee.github.io:~/loongfee.github.io/ 
#rsync -av _site/ carlboettiger.info:~/carlboettiger.info/