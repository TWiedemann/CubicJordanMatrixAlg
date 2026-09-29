# This file regenerates the package manual using AutoDoc and GAPDoc.

LoadPackage( "AutoDoc" );
AutoDoc( rec(
  autodoc := rec( scan_dirs := [ ], files := [ "doc/manual.autodoc", "gap/declarations.gd" ] ),
  scaffold := rec( includes := [ ] ),
  gapdoc := rec(
      LaTeXOptions := rec( EarlyExtraPreamble := """
          \usepackage{amsmath}
      """ ) # For \text{} command
  ),
) );
QUIT;
