# libgeos_static

Quickly build [GEOS](https://github.com/libgeos/geos) as a static library.

## Usage

```sh
# clone this repository
$ git clone https://github.com/tidwall/libgeos_static

# Change to the newly clone directory
$ cd libgeos_static 

# Download libgeos using a version or branch, such as 3.11 or main.
$ ./download.sh 3.11

# Build libgeos
$ ./build.sh
```

You can now find the include files and static libraries in the `build/install` directory.

To link the libraries to your project:

```sh
cc -Ilibgeos/build/install/include \
    mycfiles.c \
    libgeos/build/install/lib/libgeos_c.a \
    libgeos/build/install/lib/libgeos.a \
    -lm -pthread -lstdc++
```

