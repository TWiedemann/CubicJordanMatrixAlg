LoadPackage("CubicJordanMatrixAlg");
TestDirectory(DirectoriesPackageLibrary( "CubicJordanMatrixAlg", "tst" ),
  rec(
    exitGAP := true,
    testOptions := rec(width:=50000)
  ));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
