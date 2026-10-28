LoadPackage("CubicJordanMatrixAlg");
TestDirectory(DirectoriesPackageLibrary( "CubicJordanMatrixAlg", "tst" ),
  rec(
    exitGAP := true,
    testOptions := rec(width:=50000) # Ensure that each output fits into a single line
  ));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
