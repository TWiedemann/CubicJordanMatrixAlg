### This file contains the definition of ConicAlgMag, the free magma consisting
### of products of the ideterminates in the conic algebra, and functions related
### to this magma.

# ----- Indeterminates and their names -----

# symbol: String.
# i: Integer.
# Returns: Name of the i-th indeterminate in conic algebra.
BindGlobal("_ConicAlgIndetName", function(symbol, i)
	return Concatenation(symbol, String(i));
end);

# symbol: String.
# i: Integer.
# Returns: Name of the conjugate of the i-th indeterminate in conic algebra.
BindGlobal("_ConicAlgInvIndetName", function(symbol, i)
	return Concatenation(symbol, String(i), _ConicConjSymbol);
end);

# Returns: The list of all strings which appear as indeterminate names in conic algebra
# for the respective variable symbol and rank.
BindGlobal("_ConicAlgIndetNames", function(symbol, rank)
	local ConicAlgIndetNames, i;
	ConicAlgIndetNames := [];
	for i in [1..rank] do
		Add(ConicAlgIndetNames, _ConicAlgIndetName(symbol, i));
	od;
	for i in [1..rank] do
		Add(ConicAlgIndetNames, _ConicAlgInvIndetName(symbol, i)); # Conjugation
	od;
	return ConicAlgIndetNames;
end);

# ----- ConicAlgMag and its generators ----- 

InstallMethod(ConicAlgMagma, [IsInt, IsString, IsString], function(rank, varName, oneName)
	local magma, fam;
	magma := FreeMagmaWithOne(_ConicAlgIndetNames(varName, rank));
	fam := FamilyObj(magma);
	fam!.conicOneName := oneName;
	fam!.conicMagma := magma;
	fam!.conicIndetName := varName;
	fam!.conicRank := rank;
	return magma;
end);

InstallMethod(ConicAlgMagma, [IsInt, IsString], function(rank, varName)
	return ConicAlgMagma(rank, varName, _ConicDefaultOneString);
end);

InstallMethod(ConicAlgMagma, [IsInt], function(rank)
	return ConicAlgMagma(rank, _ConicIndetDefaultSymbol, _ConicDefaultOneString);
end);

InstallMethod("ConicRank", [IsMagma], function(magma)
	local fam;
	fam := FamilyObj(magma);
	if IsBound(fam!.conicRank) then
		return fam!.conicRank;
	else
		Error("Magma must be magma of a conic algebra");
	fi;
end);

InstallMethod("ConicIndetName", [IsMagma], function(magma)
	local fam;
	fam := FamilyObj(magma);
	if IsBound(fam!.conicIndetName) then
		return fam!.conicIndetName;
	else
		Error("Magma must be magma of a conic algebra");
	fi;
end);

BindGlobal("ConicAlgMagIndet", function(magma, i)
	return GeneratorsOfMagmaWithOne(magma)[i];
end);

BindGlobal("ConicAlgMagInvIndet", function(magma, i)
	return GeneratorsOfMagmaWithOne(magma)[ConicRank(magma)+i];
end);


# ----- Nicer printing for 1 in ConicAlg -----

InstallMethod(String, "Custom string for 1 in ConicAlgMag", [IsNonassocWord], function(x)
	local fam;
	fam := CollectionsFamily(FamilyObj(x));
	if IsBound( fam!.conicOneName ) and IsOne(x) then
		return fam!.conicOneName;
	else
		TryNextMethod();
	fi;
end);

InstallMethod(PrintObj, "Custom string for 1 in ConicAlgMag", [IsNonassocWord], function(x)
	if IsBound( FamilyObj(x)!.conicRank ) then
		Print(String(x));
	else
		TryNextMethod();
	fi;
end);

# ----- Constructing elements from representations and list of all elements -----

# mRep: External representation of an element of ConicAlgMag
# Returns: The corresponding element of magma.
BindGlobal("ConicAlgMagElFromRep", function(magma, mRep)
	return ObjByExtRep(ElementsFamily(FamilyObj(magma)), mRep);
end);

# rank: Rank of the conic algebra magma.
# max_length: Integer at least 1
# Returns: A list l of length max_length such that l[k] is a list of all external
# reps of elements of conic algebra magma of length k
BindGlobal("_AllConicAlgMagReps", function(max_length, rank)
	local result, i, j, x, y;
	result := [];
	for i in [1..max_length] do
		if i = 1 then
			result[i] := [1..2*rank];
		else
			result[i] := [];
			for j in [1..i-1] do
				for x in result[j] do
					for y in result[i-j] do
						Add(result[i], [x, y]);
					od;
				od;
			od;
		fi;
	od;
	return result;
end);

# magma: Conic algebra magma.
# max_length: Integer at least 1
# Returns: A list l of length max_length such that l[k] is a list of all
# elements of magma of length k
BindGlobal("_AllConicAlgMagEls", function(magma, max_length)
	return List(
		_AllConicAlgMagReps(max_length, ConicRank(magma)),
		x -> List(x, y -> ConicAlgMagElFromRep(magma, y))
	
	);
end);

# ----- Involution (i.e. conjugation) of ConicAlgMag -----

# magma: Conic algebra magma.
# mRep: External rep of an element of magma.
# Returns: The external rep of the conjugate of this element.
BindGlobal("ConicAlgMagInvOnRep", function(magma, mRep)
	local replaceByList, replaceList, rank;
	rank := ConicRank(magma);
	mRep := ReverseNonassocList(mRep);
	replaceList := [1..2*rank];
	replaceByList := Concatenation([rank+1..2*rank], [1..rank]);
	return ReplaceInNonassocList(mRep, replaceList, replaceByList);
end);

# m: Element of ConicAlgMag.
# Returns: Conjugate of m.
BindGlobal("ConicAlgMagInv", function(m)
	local fam;
	fam := FamilyObj(m);
	return ObjByExtRep(
		fam,
		ConicAlgMagInvOnRep(CollectionsFamily(fam)!.conicMagma, ExtRepOfObj(m))
	);
end);

## Norm and trace on ConicAlgMag is defined in comring.g
