# oar-build: Build tools for the OAR Platform

The contents of this directory originate from [the oar-build
repository](https://github.com/usnistgov/oar-build).  It contains
tools for building an OAR package.  integration of these tools 
into an OAR package starts by copying the contents of the oar-build
repository into the `oar-build` directory at the top level of the OAR
package's repository directory.

OAR packages use several different languages (e.g. Java, Javascript,
Python) and, consequently, different build systems (`maven`, `npm`,
python's `distuils` ) to implement the package's capabilities.
The oar-build framework wraps around the native build framework(s) and
uses docker to build the package's deployable products, thereby
eliminating the need to preinstall the package's software prerequisites,
including its build system.  This streamlines the build process for
deployment purposes and provides a single command for building that
works across all the OAR packages and the native frameworks it uses.  

(When building for development purposes, the developer would use the
native build tool directly; thus, in this case, the build tool must be
pre-installed into the developer's native environment.)

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



