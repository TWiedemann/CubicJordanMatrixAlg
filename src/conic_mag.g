# ConicAlg contains indeterminates a_1, ... a_{ConicAlg_rank} (and their conjugations)
ConicAlg_rank := 5;

## ConicAlg indeterminates

# i: Integer.
# Output: Name of the i-th indeterminate in ConicAlg
ConicAlgBasicIndetName := function(i)
	return Concatenation("a", String(i));
end;

# i: Integer.
# Output: Name of the conjugate of the i-th indeterminate in ConicAlg
ConicAlgBasicInvIndetName := function(i)
	return Concatenation("a", String(i), "'");
end;

# Returns the list of all strings which appear as indeterminate names in ConicAlg
_ConicAlgIndetNames := function()
	local ConicAlgIndetNames, i;
	ConicAlgIndetNames := [];
	for i in [1..ConicAlg_rank] do
		Add(ConicAlgIndetNames, ConicAlgBasicIndetName(i));
	od;
	for i in [1..ConicAlg_rank] do
		Add(ConicAlgIndetNames, ConicAlgBasicInvIndetName(i)); # Conjugation
	od;
	return ConicAlgIndetNames;
end;

ConicAlgIndetNames := _ConicAlgIndetNames();

# mRep: External rep of an element of ConicAlgMag.
# Output: The external rep of the conjugate of this element.
ConicAlgMagInvOnRep := function(mRep)
	local replaceByList, replaceList;
	mRep := reverseNonassocList(mRep);
	replaceList := [1..2*ConicAlg_rank];
	replaceByList := Concatenation([ConicAlg_rank+1..2*ConicAlg_rank], [1..ConicAlg_rank]);
	return ReplaceInNonassocList(mRep, replaceList, replaceByList);
end;

## Definition of ConicAlgMag

ConicAlgMag := FreeMagmaWithOne(ConicAlgIndetNames);
ConicAlgMagIndets := GeneratorsOfMagmaWithOne(ConicAlgMag);
ConicAlgMagBasicIndets := ConicAlgMagIndets{[1..ConicAlg_rank]};
ConicAlgMagInvIndets := ConicAlgMagIndets{[ConicAlg_rank+1..2*ConicAlg_rank]};

ConicAlgMagBasicIndet := function(i)
	return ConicAlgMagBasicIndets[i];
end;

ConicAlgMagInvIndet := function(i)
	return ConicAlgMagInvIndets[i];
end;

ConicAlgMagElFromRep := function(mRep)
	return ObjByExtRep(FamilyObj(One(ConicAlgMag)), mRep);
end;

# m: Element of ConicAlgMag.
# Output: Conjugate of m.
ConicAlgMagInv := function(m)
	return ConicAlgMagElFromRep(ConicAlgMagInvOnRep(ExtRepOfObj(m)));
end;

# max_length: Integer at least 1
# Output: A list l of length max_length such that l[k] is a list of all external
# reps of elements of ConicMagEl of length k
_AllConicAlgMagReps := function(max_length)
	local result, i, j, x, y;
	result := [];
	for i in [1..max_length] do
		if i = 1 then
			result[i] := [1..2*ConicAlg_rank];
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
end;

# max_length: Integer at least 1
# Output: A list l of length max_length such that l[k] is a list of all
# elements of ConicMagEl of length k
_AllConicAlgMagEls := function(max_length)
	return List(_AllConicAlgMagReps(max_length), x -> List(x, ConicAlgMagElFromRep));
end;