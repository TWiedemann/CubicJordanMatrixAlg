#
# CubicJordanMatrixAlg: Provides basic functionality for symbolic computation in
# cubic Jordan matrix algebras and associated F4-graded Lie algebras and groups
#

SetPackageInfo( rec(

PackageName := "CubicJordanMatrixAlg",
Subtitle := "Symbolic computation in cubic Jordan matrix algebras",
Version := "1.1.2",
Date := "29/10/2026", # dd/mm/yyyy format
License := "GPL-3.0-or-later",

Persons := [
  rec(
    FirstNames := "Torben",
    LastName := "Wiedemann",
    WWWHome := "https://github.com/TWiedemann",
    Email := "torben.wiedemann@rptu.de",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    #Place := TODO,
    #Institution := TODO,
  ),
],

SourceRepository := rec(
  Type := "git", URL := "https://github.com/TWiedemann/CubicJordanMatrixAlg"
),
IssueTrackerURL := Concatenation(~.SourceRepository.URL, "/issues"),
PackageWWWHome := "https://twiedemann.github.io/CubicJordanMatrixAlg/",
PackageInfoURL := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
README_URL     := Concatenation( ~.PackageWWWHome, "/README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "CubicJordanMatrixAlg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Symbolic computation in cubic Jordan matrix algebras",
),

AutoDoc := rec(),

Dependencies := rec(
  GAP := ">= 4.15",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

# The most extensive test. It is also the "highest-level" test: It involves computations
# in the F4-graded group, which involves computations in the F4-graded Lie algebra,
# which involves computations in the cubic norm structure, which involves computations
# in Conic and ComRing.
TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


