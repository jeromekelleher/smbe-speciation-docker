# smbe-speciation-docker
Docker image for the SMBE speciation genomics workshop

- Clone the repo.

- Build the docker image: ``docker build -t tskitdev/smbe-speciation . --network host``. (The --network host is probably not needed in most cases, but it worked around very tricky networking issues I was having during build.)

- Test out the docker image: ``docker run -p 8888:8888 tskitdev/smbe-speciation``
