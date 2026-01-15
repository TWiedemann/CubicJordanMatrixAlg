### Test with Test(filepath, rec( width := 500000 ))

### ----- Init -----
gap> InitCJMA(6, 3, 4, false);;
gap> RereadPackage("CubicJordanMatrixAlg", "gap/DMW/test_DMW_optional.g");;
gap> TestGrpRootHoms();
true
gap> TestNon00GrpRootHomExp();
true
gap> TestG2WeylFormulas();
true
