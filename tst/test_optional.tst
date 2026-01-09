### Test with Test(filepath, rec( width := 500000 ))

### ----- Init -----
gap> InitF4Graded(6, 3, 4, false);;
gap> RereadPackage("F4GradedGroups", "gap/DMW/test_DMW_optional.g");;
gap> TestGrpRootHoms();
true
gap> TestNon00GrpRootHomExp();
true
gap> TestG2WeylFormulas();
true
