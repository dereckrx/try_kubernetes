## Overview

docker build --tag my-image path/to/Dockerfile

## Entrypoints and commands
Three forms: 

ENTRYPOINT ["sleep", "5"] # Cannot be overriden

CMD ["sleep", "5"] # Default, can be overriden

ENTRYPOINT ["sleep"]
CMD ["5"] # Default, can be overriden


## Running docker
docker run <image_name> 
docker run <image_name> <...args>
docker run <image_name> <program> <...args>
