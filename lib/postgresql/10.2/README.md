# siose-innova/postgresql

PostgreSQL Server with `python3` support.

## Considerations about the `siose-innova/postgresql` image

This Dockerfile is a slightly modified copy of the official one. Therefore, you should consider the following specs and constraints before building an image `FROM siose-innova/postgresql`:  
  
- Volume creation for database cluster is skipped so that data can be persisted within the Docker image using `docker commit`.
- Supports `python3` but does not support `python 2.x`. Building dependencies and configure options where changed accordingly to achieve this.
- The remaining configure options for compiling PostgreSQL where left unchanged.
- The tooling for installing Python modules (`setuptools`) is available.
- The `redis-py` module is already installed so that a `siose-innova/postgresql` instance is able to connect to a Redis instance if needed.
- Build dependencies are installed and removed through `apk` virtual packages named `.fetch-deps` and `.build-deps`. Therefore, there are no build tools available in the final image.
