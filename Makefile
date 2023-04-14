# Makefile to build JupyterBook for this repository

## - html    : Build static website for local display
.PHONY: html
html:
	jupyter-book build .
    
## - clean   : remove all build files
.PHONY: clean
clean:
	rm -rf figures
	rm -rf audio 
	rm -rf _build/html/
	rm -rf _build

# create a conda environment. 
# by default, each line in the markfile will run in a different shell. 
# The .ONESHELL: command allow us to run all the commands inside an operation in the same shell. 
.ONESHELL:
SHELL = /bin/bash

env :
	source /srv/conda/etc/profile.d/conda.sh
	conda env create -f environment.yml 
	conda activate notebook
	conda install ipykernel
	python -m ipykernel install --user --name make-env --display-name "IPython - Make"

## Other useful Makefile comments, not required by the hw. 

## - html-hub: build static website so it can be viewed on hosted JupyterHub (via URL proxy).
.PHONY: html-hub
html-hub: conf.py
	sphinx-build  . _build/html -D html_baseurl=${JUPYTERHUB_SERVICE_PREFIX}proxy/absolute/8000
	@echo
	@echo "To start the Python http server, use:"
	@echo "python -m http.server --directory ${PWD}/_build/html"
	@echo "and visit this link with your browser:"
	@echo "https://stat159.datahub.berkeley.edu/user-redirect/proxy/8000/index.html"

## - conf.py : update sphinx configuration for manual sphinx runs
conf.py: _config.yml _toc.yml
	jupyter-book config sphinx .

## - help    : Summary help of all targets in this Makefile.
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
