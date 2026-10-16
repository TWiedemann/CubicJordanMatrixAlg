### This file contains the definition of ComRing, the polynomial ring over Z
### that represents an arbitrary commutative ring, and functions related to it

# ----- Indeterminates names -----

# Indeterminate names for traces are defined further below because this is more complicated.

# Returns: Name of the i-th indeterminate of ComRing.
BindGlobal("_ComRingIndetName", function(symbol, i)
	return Concatenation(symbol, String(i));
end);

# Returns: The name of the indeterminate of ComRing which represents the norm of i-th
# indeterminate of conic algebra
BindGlobal("_ComRingNormIndetName", function(conicSymbol, i)
	return Concatenation(_ConicNormSymbol, "(", _ConicAlgIndetName(conicSymbol, i), ")");
end);

BindGlobal("_ComRingTraceIndetName", function(conicIndet)
	return Concatenation(_ConicTraceSymbol, "(", _ConicAlgIndetName(conicSymbol, i), ")");
end);

# i: 1, 2, or 3
# Returns: The name of the indeterminate which represents \gamma_i, the i-th
# element of the diagonal matrix \Gamma which "twists" the cubic Jordan matrix algebra.
BindGlobal("ComRingGamIndetName", function(i)
	if i in [1, 2, 3] then
		return Concatenation(_ComRingGamIndetSymbol, String(i));
	else
		return fail;
	fi;
end);

# ----- Indeterminates -----

# Returns: symbol_i \in ComRing, represents arbitrary element of ComRing
InstallMethod(ComRingIndet, [ IsString, IsInt ], function(symbol, i)
	return Indeterminate(ComRingBaseRing, _ComRingIndetName(symbol, i));
end);

# magma: Conic algebra magma.
# n(a_i) \in ComRing, represents norm of i-th indeterminate in magma
BindGlobal("ComRingNormIndet", function(magma, i)
	local name;
	if i < 1 or i > ConicRank(magma) then
		return fail;
	fi;
	name := _ComRingNormIndetName(ConicIndetName(magma), i);
	return Indeterminate(ComRingBaseRing, name);
end);

# g_i \in ComRing, represents \gamma_i
InstallMethod(ComRingGamIndet, [ IsInt ], function(i)
	return Indeterminate(ComRingBaseRing, ComRingGamIndetName(i));
end);

# ----- Norm: ConicAlgMag -> ComRing -----

# magma: A conic algebra magma
# mRep: ExtRepOfObj of an element of magma
# Returns: Norm of this element (as an element of ComRing)
DeclareGlobalName("ConicAlgMagNormOnRep");
BindGlobal("ConicAlgMagNormOnRep", function(magma, mRep)
	if mRep = 0 then # n(1_ConicAlg) = 1_ComRing
		return One(PolynomialRing(ComRingBaseRing));
	elif mRep in [1..ConicRank(magma)] then
		return ComRingNormIndet(magma,mRep);
	elif mRep in [ConicRank(magma)+1..2*ConicRank(magma)] then
		return ComRingNormIndet(magma,mRep - ConicRank(magma));
	elif IsList(mRep) then
		return ConicAlgMagNormOnRep(magma,mRep[1]) * ConicAlgMagNormOnRep(magma,mRep[2]);
	else
		return fail;
	fi;
end);

# m: Element of ConicAlgMag
# Returns: norm of m, an element of ComRing
BindGlobal("ConicAlgMagNorm", function(m)
	return ConicAlgMagNormOnRep(ConicAlgMagma(m), ExtRepOfObj(m));
end);

# ----- Trace: ConicAlgMag -> ComRing -----

# The trace map is slightly complicated because there exist relations such as
# tr(ab)=tr(ba) and tr((ab)c) = tr(a(bc)). We try to use these relations to keep
# the number of necessary indeterminates low.

## Helper functions for trace

# magma: Conic algebra magma.
# a, b, c: External reps of elements of magma.
# Returns: If one of the elements (repr. by) a,b,c is the conjugate of another, the output
# is a list [x, y] where x is the rep of such an element and y is the rep of
# the remaining (third) element.
# Otherwise the output is fail.
# Example: If ConicRank(magma) = 3 (so that a1'=a4 and a2'=a5), then
# _PullNorm([1, 2], [3], [5, 4]) is [[1, 2], [3]] or [[5,4], [3]]
# The point of this is that the elements tr(aa'b), tr(a'ba), tr(baa') all equal
# n(a)tr(b), i.e., we can "pull norms out of traces".
# This is a helper function to detect arguments on which we can apply this relations.
# It translates the arguments into a usable format.
BindGlobal("_PullNorm", function(magma, a, b, c)
    local list, i, j, k;
	list := [a,b,c];
	for i in [1..3] do
		for j in [i+1..3] do
			if list[i] = ConicAlgMagInvOnRep(magma,list[j]) then
				k := Difference([1..3], [i,j])[1];
				return [list[i], list[k]];
			fi;
		od;
	od;
	return fail;
end);

# magma: Conic algebra magma.
# a, b, c: External reps of elements of magma.
# Returns: A list of triples [d, e, f] s.t. tr(abc) = tr(def).
# By the relations tr(ab) = tr(ba), tr((ab)c) = tr(a(bc)) and tr(a') = tr(a),
# we may write tr(abc) without brackets and this term is equal to all cyclic permutations
# and to all cyclic permutations of tr(c'b'a').
BindGlobal("_ConicAlgMagTrCandidates", function(magma, a, b, c)
	local aInv, bInv, cInv;
	aInv := ConicAlgMagInvOnRep(magma,a);
	bInv := ConicAlgMagInvOnRep(magma,b);
	cInv := ConicAlgMagInvOnRep(magma,c);
	return [
		[a, b, c], [b, c, a], [c, a, b],
		[cInv, bInv, aInv], [aInv, cInv, bInv], [bInv, aInv, cInv]
	];
end);

# magma: Conic algebra magma.
# mRep: External rep of an element of magma.
# Returns: An element of ComRing which represents the trace of the corresponding
# element of magma. In most cases, this is an indeterminate in ComRing,
# but it need not be. E.g. tr(One(magma)) = 2*One(ComRing).
# We use the relations described in _ConicAlgMagTrCandidates and _PullNorm.
DeclareGlobalName("ConicAlgMagTrOnRep");
BindGlobal("ConicAlgMagTrOnRep", function(magma, mRep)
	local trArg, varName, inv, left, right, candidates, list, min, StringFromRep;
	trArg := ""; # Will be string of an element of magma
	inv := x -> ConicAlgMagInvOnRep(magma, x);
	if not IsList(mRep) then
		if mRep = 0 then
			return 2*One(PolynomialRing(ComRingBaseRing)); # tr(1) = 2
		else
			mRep := Minimum(mRep, inv(mRep)); # Replace a' by a if necessary
			trArg := Concatenation(trArg, String(ConicAlgMagElFromRep(magma,mRep)));
		fi;
	else
		left := mRep[1];
		right := mRep[2];
		if left = inv(right) then
			return 2*inv(left); # tr(aa') = 2n(a)
		fi;
		# A "candidate" is a triple [a,b,c] of reps such that tr(mRep) = tr(abc)
		# or a pair [a,b] such that tr(mRep) = tr(ab).
		# Note that tr((ab)c) = tr(a(bc)), so no brackets are necessary.
		# Compute all candidates
		if not IsList(left) and not IsList(right) then
			# tr(ab) = tr(ba) and tr(a') = tr(a)
			candidates := [
				[left, right], [right, left], [inv(left), inv(right)], [inv(right), inv(left)]
			];
		else
			candidates := [];
			if IsList(left) then
				list := _PullNorm(magma,left[1], left[2], right);
				if list <> fail then
					# Pull out norms: E.g. tr(aa'b) = n(a)tr(b). Apply recursion to compute tr(b).
					return ConicAlgMagNormOnRep(magma,list[1]) * ConicAlgMagTrOnRep(magma,list[2]);
				else
					# No "pulling out" of norms is possible
					candidates := Concatenation(
						candidates, _ConicAlgMagTrCandidates(magma, left[1], left[2], right)
					);
				fi;
			fi;
			if IsList(right) then
				# As above, but with left and right switched
				list := _PullNorm(magma,left, right[1], right[2]);
				if list <> fail then
					return ConicAlgMagNormOnRep(magma,list[1]) * ConicAlgMagTrOnRep(magma,list[2]);
				else
					candidates := Concatenation(
						candidates, _ConicAlgMagTrCandidates(magma,left, right[1], right[2])
					);
				fi;
			fi;
		fi;
		# Choose the minimal candidate w.r.t the lex order. It does not matter which
		# one we choose, but this is an easy way to choose a unique representative.
		min := Minimum(candidates); # minimum w.r.t. lex order
		# If min = [a, b, c], then varName = "abc". Note that 
		# String puts a bracket around elements of ConicAlgMag if their length
		# is at least 2, so we do not have to do this ourselves.
		# E.g. if min = [a1, a1a2, a3], then varName = "a1(a1a2)a3"
		varName := Concatenation(List(min, x -> String(ConicAlgMagElFromRep(magma,x))));
        trArg := Concatenation(trArg, varName);
	fi;
	return Indeterminate(ComRingBaseRing, _ComRingTraceIndetName(trArg));
end);

# magEl: Element of conic algebra magma
# Returns: Its trace (an element of ComRing).
BindGlobal("ConicAlgMagTr", function(magEl)
	return ConicAlgMagTrOnRep(ConicAlgMagma(magEl), ExtRepOfObj(magEl));
end);

# a, b: Elements of ConicAlgMag.
# Returns: n(a,b) := n(a+b) - n(a) - n(b).
# By [GPR24, (16.12.4), (16.5.2)], we have n(a,b) = n(1, a'b) = t(a'b)
BindGlobal("ConicAlgMagNormLin", function(a, b)
	return ConicAlgMagTr(ConicAlgMagInv(a)*b);
end);

# TODO: Document the return and input values.
# This function does the following:
# - Initialises the list comRingIndetInfo (see constants.g for a documentation).
# - Every indeterminate that may appear in ComRing is created once, and this always happens
# in the same order (for a fixed choice of ConigAlg_rank and Trace_MaxLength). Every indeterminate
# is assigned a number by GAP the first time it is used. Calling this function ensures that
# the indeterminates are always initialised in the same order and hence always have the same
# internal number. This guarantees that they are always printed in the same order.
BindGlobal("_InitIndeterminates", function(magma, comRank)
	local maxIndetNum, magEl, magEls, magElsReps, magElRep, trace, polyRep, monomial, i, j, magma;
	conicRank := ConicRank(magma);
	comRingIndetInfo := [];
	# Initialise all the other indeterminates of ComRing in the desired order
	for i in [1..3] do
		ComRingGamIndet(i); # Initialise indeterminate
		Add(comRingIndetInfo, ["g", i]);
	od;
	for i in [1..comRank] do
		ComRingIndet(i); # Initialise indeterminate
		Add(comRingIndetInfo, ["t", i]);
	od;
	for i in [1..conicRank] do
		ComRingNormIndet(magma,i); # Initialise indeterminate
		Add(comRingIndetInfo, ["n", ConicAlgMagIndet(magma,i)]);
	od;
	## Initialise indeterminates in ComRing
	# maxIndetNum will be increased whenever a new indeterminate is created
	maxIndetNum := 3 + comRank + conicRank;
	# List of all elements of ConicAlgMag up to length Trace_MaxLength
	magEls := Concatenation(_AllConicAlgMagEls(magma,Trace_MaxLength));
	magEls := Concatenation([One(magma)], magEls);
	magElsReps := List(magEls, x -> ExtRepOfObj(x));
	for i in [1..Length(magEls)] do
		magEl := magEls[i];
		magElRep := magElsReps[i];
		trace := ConicAlgMagTr(magEl);
		## Update maxIndetNum
		polyRep := ExtRepNumeratorRatFun(trace); # rep of the polynomial `trace`
		# Iterate through all monomials in `trace`
		for i in [1..Length(polyRep)/2] do
			monomial := polyRep[2*i - 1];
			# Iterate through all indeterminate numbers in monomial
			for j in [1..Length(monomial)/2] do
				if monomial[2*j-1] > maxIndetNum then
					# A new indeterminate has occured. It must be tr(magEl).
					maxIndetNum :=  monomial[2*j - 1];
					Add(comRingIndetInfo, ["tr", magEl]);
				fi;
			od;
		od;
	od;
	return [maxIndetNum, comRingIndetInfo];
end);

# TODO: Remove this.
BindGlobal("_ComRingBuildData", _InitIndeterminates());
BindGlobal("_ComRingNumIndets", _ComRingBuildData[1]);
BindGlobal("ComRing", FunctionField(ComRingBaseRing, _ComRingNumIndets));
Collections(FamilyObj(One(ComRing)))!.conicMagma := _ComRingBuildData[2];
