# strix-docker
A Dockerfile to install Strix (https://strix.model.in.tum.de/, https://gitlab.lrz.de/i7/strix/) in an Ubuntu docker image. 

This can be used to use Strix on a Windows machine.

## Instructions

  1. Install docker (this was tried with Docker version 19.03.13, build 4484c46d9d)
  2. In a folder containing the Dockerfile run:
    
```
    docker build --tag=strix
```
   
  3. And that's it! Strix should be ready to run.
  4. Try it by running: 
     
```
    docker run strix -f "G (req0 -> F grant0) && G (req1 -> F grant1) && G (!(grant0 && grant1))" --ins="req0,req1" --outs="grant0,grant1"
```
