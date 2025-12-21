#
# F4GradedGroups: Provides basic functionality for symbolic computation in free multiplicative conic alternative algebras and associated F4-graded Lie algebras and groups
#

SetPackageInfo( rec(

PackageName := "F4GradedGroups",
Subtitle := "Provides basic functionality for symbolic computation in free multiplicative conic alternative algebras and associated F4-graded Lie algebras and groups",
Version := "0.1",
Date := "19/12/2025", # dd/mm/yyyy format
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

#SourceRepository := rec( Type := "TODO", URL := "URL" ),
#IssueTrackerURL := "TODO",
PackageWWWHome := "https://github.com/TWiedemann/F4GradedGroups",
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL     := Concatenation( ~.PackageWWWHome,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "F4GradedGroups",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Provides basic functionality for symbolic computation in free multiplicative conic alternative algebras and associated F4-graded Lie algebras and groups",
),

Dependencies := rec(
  GAP := ">= 4.15",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

# TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


