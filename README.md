# Go Builder (Cross Compiler)
The builder uses [gox](https://github.com/mitchellh/gox) package to cross-compile for target os/architecture combinations.

## Usage
### Clone the Go package into src/<package_name>. 
E.g. for package `code.linksmart.eu/sc/service-catalog`:
```
git clone https://code.linksmart.eu/scm/sc/service-catalog.git src/code.linksmart.eu/sc/service-catalog
```

### Run the builder
* Mount /home to the current directory on host
* Pass package name as PACKAGE environment variable
```
docker run --rm -v `pwd`:/home -e PACKAGE=code.linksmart.eu/sc/service-catalog docker.linksmart.eu/ci/go-builder
```
By default, the builder uses `bin/{{.Dir}}-{{.OS}}-{{.Arch}}` naming template and cross-compiles for the following os/arch combinations:
* linux/386 
* linux/amd64 
* linux/arm 
* windows/386
* windows/amd64
* darwin/amd64 

These can be overriden by setting OSARCH and OUTPUT environment variable. E.g.:
```
docker run --rm -v `pwd`:/home -e PACKAGE=code.linksmart.eu/sc/service-catalog -e OSARCH="linux/arm linux/amd64" docker.linksmart.eu/ci/go-builder
```