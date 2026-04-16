### Test with Test(filepath, rec( width := 500000 ))

### ----- Init -----
gap> START_TEST("test_optional.tst");
gap> InitCJMA(6, 3, 4, false);;
gap> ReadPackage("CubicJordanMatrixAlg", "gap/DMW/test_DMW_optional.g");;
gap> TestGrpRootHoms();
true
gap> TestNon00GrpRootHomExp();
true
gap> TestG2WeylFormulas();
true

#
gap> STOP_TEST("test_optional.tst");
