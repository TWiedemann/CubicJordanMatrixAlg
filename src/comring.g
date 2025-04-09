BaseRing := Rationals;
# ComRing contains indeterminates t_1, ..., t_{ComRing_rank} (and the norms and traces of elements of ConicAlg) 
ComRing_rank := 3;
# Let t = Trace_MaxLength. For all k <= t and all i_1, ..., i_k in [ 1..ConicAlg_rank ],
# an indeterminate which represents tr(a_{i_1} ... a_{i_t}) will be created.
# If longer products are needed during the runtime, then an error message is printed.
Trace_MaxLength := 3;

## ComRing indeterminates

# a, b, c: External reps of elements of ConicAlgMag
# Output: The string for the indeterminate tr(abc). The identities tr(xy) = tr(yx)
# and tr(x') = tr(x) are used to produce a canonical form.
# If a symplification by the formula tr(aa'b) = tr(aba') = tr(baa') = tr(b) n(a)
# is possible, return fail.
ComRingTraceIndetName := function(a, b, c)
    local aInv, bInv, cInv, candidates, min, StringFromRep;
	aInv := ConicAlgMagInvOnRep(a);
	bInv := ConicAlgMagInvOnRep(b);
	cInv := ConicAlgMagInvOnRep(c);
	if a in [b, c] or aInv in [b, c] or c in [b, bInv] then
		return fail;
	else
		candidates := [
			[a, b, c], [b, c, a], [c, a, b],
			[cInv, bInv, aInv], [aInv, cInv, bInv], [bInv, aInv, cInv]
		];
		min := Minimum(candidates);
        # s: External rep of an element of ConicAlgMag
        # Output: The corresponding string (in brackets if there are at least 2 factors)
        StringFromRep := function(s)
            if IsList(s) then
                return Concatenation("(", String(ObjByExtRep(ConicAlgMagElFam, s)), ")");
            else
                return ConicAlgIndetNames[s];
            fi;
        end;
        return Concatenation(
            "tr(", StringFromRep(min[1]), StringFromRep(min[2]),
            StringFromRep(min[2]), ")"
        );
    fi;
end;

# i: Integer.
# Output: Name of the i-th indeterminate of ComRing.
ComRingBasicIndetName := function(i)
	return Concatenation("t", String(i));
end;

# i: Integer with 1 <= i <= ConicAlg_rank.
# Output: The name of the indeterminate of ComRing which represents the norm of a_i
ComRingNormIndetName := function(i)
	if i in [1..ConicAlg_rank] then
		return Concatenation("n(", ConicAlgIndetNames[i], ")");
	else
		return fail;
	fi;
end;

# TODO: Remove indet names for tr(a_i a_i') because they are not need (tr(a_i a_i') = 2*n(a_i))
# indexList: A list [i_1, ..., i_k] (for some k) of integers i with 1 <= i <= 2*ConicAlg_rank.
# Output: The name of the indeterminate of ComRing which represents
ComRingTraceIndetName := function(indexList)
	local name, i;
	if Length(indexList) > Trace_MaxLength then
		Error("Product in trace too long");
		return fail;
	fi;
	indexList := _CanonicalIndexList(indexList);
	name := "tr(";
	for i in indexList do
		if not i in [1..2*ConicAlg_rank] then
			return fail;
		else
			name := Concatenation(name, ConicAlgIndetNames[i]);
		fi;
	od;
	name := Concatenation(name, ")");
	return name;
end;

# The elements \gamma_1, ..., \gamma_3 of the diagonal matrix \Gamma which "twists"
# the cubic Jordan matrix algebra.
ComRingGamIndetName := function(i)
	if i in [1, 2, 3] then
		return Concatenation("g", String(i));
	else
		return fail;
	fi;
end;

ComRingIndetNumberForBasic := function(i)
	return i;
end;

ComRingIndetNumberForNorm := function(i)
	return ComRing_rank + i;
end;

# Returns the list of all strings which appear as indeterminate names in ComRing
_ComRingIndetNames := function()
	local ComRingIndetNames, i, j, l, indexList, name;
	ComRingIndetNames := [];
	# Basic indeterminates
	for i in [1..ComRing_rank] do
		Add(ComRingIndetNames, Concatenation("t", String(i)));
	od;
	# Norms
	for i in [1..ConicAlg_rank] do
		Add(ComRingIndetNames, ComRingNormIndetName(i));
	od;
	# Traces
	for l in [1..Trace_MaxLength] do
		indexList := [];
		for i in [1..l] do
			Add(indexList, 1);
		od;
		Add(ComRingIndetNames, ComRingTraceIndetName(indexList)); # Add [ 1, ..., 1 ]
		while true do
			# Increase indexList by one step
			for i in [l, l-1 .. 1 ] do
				if indexList[i] < 2*ConicAlg_rank then
					indexList[i] := indexList[i] + 1;
					for j in [i+1..l] do
						indexList[j] := 1;
					od;
					break;
				elif i = 1 then
					indexList := fail;
				fi;
			od;
			if indexList = fail then
				break;
			else
				name := ComRingTraceIndetName(indexList);
				if not name in ComRingIndetNames then
					Add(ComRingIndetNames, name);
				fi;
			fi;
		od;
	od;
	# \Gamma
	for i in [1,2,3] do
		Add(ComRingIndetNames, ComRingGamIndetName(i));
	od;
	return ComRingIndetNames;
end;

ComRingIndetNames := _ComRingIndetNames();