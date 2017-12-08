# oar-build: Build tools for the OAR Platform

The contents of this directory originate from [the oar-build
repository](https://github.com/usnistgov/oar-build).  It contains
tools for building an OAR package.  Integration of these tools 
into an OAR package starts by copying the contents of the oar-build
repository into the `oar-build` directory at the top level of the OAR
package's repository directory.

OAR packages use several different languages (e.g. Java, Javascript,
Python) to implement the package's capabilities and, consequently,
different build systems (`maven`, `npm`, python's `distuils` ) create
the packages products.  The oar-build framework wraps around the
native build framework(s) and uses docker to build the package's
deployable products, thereby eliminating the need to preinstall the
package's software prerequisites, including its build system.  This
streamlines the build process for deployment purposes and provides a
single command for building that works across all the OAR packages and
the native frameworks it uses.   

(When building for development purposes, the developer would use the
native build tool directly; thus, in this case, the build tool must be
pre-installed into the developer's native environment.)

## Integrating the oar-build tools into an OAR package

The oar-build tools are typically integrated into a package early in
the development of an OAR package.  The contents of the [the `oar-build`
repository](https://github.com/usnistgov/oar-build) are copied into
new package's top directory.

For example, to integrate the tools into a new package, `oar-mypkg`,
you would download a zip-file release of the `oar-build` package
(e.g. `oar-build-master.zip`) and then execute the commands as shown
in this example session:

```bash
$ ls
oar-build-master.zip      oar-mypkg
$ unzip -q oar-build-master.zip
$ ls
oar-build-master    oar-build-master.zip      oar-mypkg
$ cd oar-build-master
$ tar cf - * | (cd ../oar-mypkg; tar xkf -)     # WILL NOT OVERWRITE EXISTING FILES
```

The `tar` command above adds the following to the new package:
```
   docker             -- directory containing tools for building and testing via Docker
   oar-build          -- directory containing the oar-build infrastructure 
   scripts            -- directory containing build scripts
   README_OARBUILD.md -- this file
```

As the developer of code in the new package, you should customize the
scripts found in the `scripts` and `docker` directories as needed (see
script comments for details).  The contents of `oar-build` are
normally not edited.

One important changes to make in your new package after copying in the
`oar-build` files is to your `README.md` file:  update the build
instructions to incorporate the description below.  

## Building a package with the oar-build framework

The deployable products that result from building a package that
supports oar-build are referred to as distributions.  A single script
can be used to build the distributions:

```
  oar-build/makedist
```

This will create a directory called `dist` under the top directory of the
package and the deployable products will be placed into.  Upon
successful completion, these products are ready to be deployed into their
proper places in an oar-docker deployment where they can be built into
an operating OAR system.



