# This file regenerates the package manual using AutoDoc and GAPDoc.

LoadPackage( "AutoDoc" );
AutoDoc( rec(
  autodoc := rec( scan_dirs := [ ], files := [ "doc/manual.autodoc", "gap/declarations.gd" ] ),
  scaffold := rec( includes := [ ] ),
) );
QUIT;
