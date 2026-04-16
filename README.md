# Introduction

The [GAP](https://www.gap-system.org/) package `CubicJordanMatrixAlg`
allows basic symbolic computation in
free multiplicative conic alternative algebras
(over free commutative rings, that is, polynomial rings)
and, as the main application, in cubic Jordan matrix algebras over them.
In other words, it provides a framework to prove that certain identities hold in any multiplicative conic alternative algebra over any commutative ring.
It does this by deriving these identities from a set of known identities in such objects.

In the preprint \[DMW\] [*From cubic norm pairs to $G_2$- and $F_4$-graded groups and Lie algebras*](https://arxiv.org/abs/2602.06147), two objects are constructed
from the cubic Jordan matrix algebra of an arbitrary multiplicative conic alternative algebra:
* A Lie algebra $L$ (with a grading by the root system $F_4$).
* A group $G$ of automorphisms of $L$ (which also has a grading by $F_4$).

`CubicJordanMatrixAlg` also supports computations in $L$ and $G$. In fact, it was developed
for this purpose, and is used to establish several computational results in \[DMW\].

`CubicJordanMatrixAlg` cannot prove any valid identity in the objects described above
(which seems to be a hopeless task),
but it is powerful enough to prove all identities that are needed in \[DMW\].
The basic underlying principles of this package are described in \[DMW, Section 9.3\]
and in the preprint \[Wie26\] [*Symbolic computation in cubic Jordan matrix algebras and in related structures*](https://arxiv.org/abs/2604.13809).


# Installation

1. Install the latest version of [GAP](https://www.gap-system.org/install/). This package requires GAP version at least 4.15.0, and has been tested with GAP version 4.15.1. It will run into errors with GAP version 4.14.0 or lower.
2. Start the GAP package manager:
```
gap> LoadPackage("PackageManager");
```
3. Install the package from its git repository:
```
gap> InstallPackage("https://github.com/TWiedemann/CubicJordanMatrixAlg.git");
```
This will install the package into your local GAP package directory.
You can find the location of this directory on your system by calling
```
gap> GAPInfo.PackageDirectories;
```
in a GAP session.

As an alternative way of installation,
you can manually download (or `git clone`) this repository into your package directory.

# Updating the package

1. Start the GAP package manager:
```
gap> LoadPackage("PackageManager");
```
2. Update the package:
```
gap> UpdatePackage("CubicJordanMatrixAlg");
```

# Using the package

1. In GAP, load the package with
```
gap> LoadPackage("CubicJordanMatrixAlg");
```
2. Initialise the package with
```
gap> InitCJMA();
```

Now you can perform computations with this package.
For details, see either [`doc/manual.md`](https://github.com/TWiedemann/CubicJordanMatrixAlg/blob/main/doc/manual.md) for a comprehensive description or
simply have a look at the usage examples in (the test file) `tst/test_basic.tst`.

# Verification of the claims in \[DMW\] (Tests)

The directory `[gap]/pkg/CubicJordanMatrixAlg/tst` (where `[gap]/pkg` is the directory in which
`CubicJordanMatrixAlg` is installed) contains several test files which verify certain claims
in \[DMW\] (and which also serve as a test suite for the package).
If you want to run these tests, do the following for each of these test files:
1. Start a GAP session.
2. Type `LoadPackage("CubicJordanMatrixAlg");` and press Enter to load the package. Do NOT call `InitCJMA()`, this will be done automatically by the following steps.
3. Type `Test("filepath", rec(width:=50000));` and press Enter. Here `filepath` should be replaced by the path of the file you want to test. On Unix, if you started the GAP session inside `[gap]/pkg/CubicJordanMatrixAlg/tst`, then `filepath` can simply be the name of the file, e.g. `Test("test_basic.tst", rec(width:=50000));`. On Windows, this does not work, but you can drag and drop the `tst` file from your file explorer into your GAP session to obtain its path.
Consult the [GAP manual](https://docs.gap-system.org/doc/ref/chap7_mj.html#X801051CC86594630) for more information on the GAP function `Test`.
4. An output of `true` on the terminal signifies that all tests were successful. Some tests run only a few seconds, others may take several minutes.
5. To test the next file, close GAP and start a new session.

Specifically, the files perform the following tests:
- `test_basic.tst` does not verify any specific claim in \[DMW\]. Rather, it tests that all basic functions of the package work as intended.
- `test_jordan_brace.tst` verifies \[DMW, 9.15\] (explicit formulas for the $D$-operators in cubic Jordan matrix algebras).
- `test_lie_comm.tst` verifies \[DMW, 10.32, 10.33, 10.34\] (existence of a Chevalley-type basis and explicit commutator formulas in the Lie algebra).
- `test_group_comm.tst` verifies \[DMW, 11.13\] (commutator formulas in the $F_4$-graded group).
- `test_weyl.tst` verifies \[DMW, 11.4, 11.7, 11.11\] (the elements $w_\delta$ are Weyl elements with the desired parities).

The last two test files require a few more computations by hand to complete the proof of the specified claims. See the comments of the respective test files for details.

# License

This software is licensed under the GPL-3.0 license.
