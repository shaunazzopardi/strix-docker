# strix-docker
A Dockerfile to install [St](https://strix.model.in.tum.de/)r[ix](https://github.com/meyerphi/strix) in an Ubuntu docker image. 

I am using this for my research to have Strix available on a Windows machine.

## Build

  1. Install [docker](https://www.docker.com/).
  2. In a folder containing the Dockerfile run:
    
```
    docker build --tag=strix .
```
   
  3. And that's it! Strix should be ready to run.
  4. Try it by running: 
     
```
    docker run strix -f "G (req0 -> F grant0) && G (req1 -> F grant1) && G (!(grant0 && grant1))" --ins="req0,req1" --outs="grant0,grant1"
```

## Usage

See [strix](https://github.com/meyerphi/strix) for command-line usage instructions.

## Version

This will install Strix 21.0.0 as at commit fd372cf. To try the script at different commits edit line 18 in ./Dockerfile appropriately. This comes with no guarantees, the script was only tested with commit fd372cf.
