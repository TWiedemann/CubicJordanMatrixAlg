### Declaration part
ReadPackage("CubicJordanMatrixAlg", "gap/comring.gd");
ReadPackage("CubicJordanMatrixAlg", "gap/conic.gd");
ReadPackage("CubicJordanMatrixAlg", "gap/cubic.gd");
ReadPackage("CubicJordanMatrixAlg", "gap/brown.gd");
# Also contains declarations for DD, lie0, F4-roots, lie_roothom
ReadPackage("CubicJordanMatrixAlg", "gap/lie.gd");
ReadPackage("CubicJordanMatrixAlg", "gap/group.gd");
# Also contains declarations for test_equal
ReadPackage("CubicJordanMatrixAlg", "gap/simplify.gd");

### Implementation part
ReadPackage("CubicJordanMatrixAlg", "gap/constants.g");
ReadPackage("CubicJordanMatrixAlg", "gap/F4-roots.g"); # The root systems F4 and G2
ReadPackage("CubicJordanMatrixAlg", "gap/parity_lists.g"); # Stores the parity map of the F4-graded group
ReadPackage("CubicJordanMatrixAlg", "gap/helper.g");
ReadPackage("CubicJordanMatrixAlg", "gap/conic_mag.g");
ReadPackage("CubicJordanMatrixAlg", "gap/comring.g"); # Commutative ring k = ComRing
ReadPackage("CubicJordanMatrixAlg", "gap/conic.g"); # Conic algebra C = Conic
ReadPackage("CubicJordanMatrixAlg", "gap/cubic.g"); # Cubic Jordan matrix algebra
ReadPackage("CubicJordanMatrixAlg", "gap/brown.g"); # Brown algebra
ReadPackage("CubicJordanMatrixAlg", "gap/DD.g"); # DD
ReadPackage("CubicJordanMatrixAlg", "gap/lie0.g"); # L_0
ReadPackage("CubicJordanMatrixAlg", "gap/lie.g"); # Lie algebra L
ReadPackage("CubicJordanMatrixAlg", "gap/lie_roothom.g"); # Root homomorphisms in L
ReadPackage("CubicJordanMatrixAlg", "gap/group.g"); # LieEndo and root homomorphisms in there
ReadPackage("CubicJordanMatrixAlg", "gap/simplify.g"); # Simplification functions
ReadPackage("CubicJordanMatrixAlg", "gap/chev.g"); # Chevalley-type bases
ReadPackage("CubicJordanMatrixAlg", "gap/test_equal.g"); # Equality tests
