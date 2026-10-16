### Test with Test(filepath, rec( width := 500000 ))

### ----- Init -----
gap> START_TEST("test_optional.tst");
gap> conicAlg := ConicAlgebra(6, 3, 4);;
gap> ReadPackage("CubicJordanMatrixAlg", "gap/DMW/test_DMW_optional.g");;
gap> TestGrpRootHoms(conicAlg);
true
gap> TestNon00GrpRootHomExp(conicAlg);
true
gap> TestG2WeylFormulas(conicAlg);
true

#
gap> STOP_TEST("test_optional.tst");
