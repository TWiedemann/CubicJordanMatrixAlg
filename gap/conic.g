### This file contains the definition of conic algebras.
### These are free magma rings over the magmas from conic_mag.g with coefficient ring
### as defined in comring.g.

## Some information about a conic algebra is stored in the family object of its
## underlying magma.

# ----- Helper functions used in the constructor -----

## A conic algebra stores some lists with precomputed information in the family object
## of its underlying magma:
## - comRingIndetInfo: A list whose i-th contains information about the i-th indeterminate
##   in the underlying commutative base ring. Namely, this entry is a list
##   [type, info] where type is one of the strings "g" (for \gamma), 
##   "t" (for indeterminates representing arbitrary elements), "n" (for norm indeterminates),
##   "tr" for trace indeterminates. `info` is additional information:
##   For t_i and g_i, info is i. For n(x) and tr(x), info is x (as an element of magma).
## - traceIndets: List of all indeterminates in ComRing of the form
##   tr(a) \in ComRing with a \in ConicAlgMag.
## - traceValues: List of the elements a+a' \in ConicAlg "corresponding"
##   to the elements of traceIndets.
## - trSubIndetList: List of trace indeterminates which may be replaced by other terms
##   using the relation tr(xy') = tr(x)tr(y) - tr(xy). This relation is used by
##   the simplifaction functions to replace all appearances of a_i' in tr.
## - trSubValueList: A list whose i-th entry is the term by which
##   trSubIndetList[i] should be replaced in the simplification functions.

# magma: Conic algebra magma.
# comRank, maxTrLenth: Integers.
# comIndetSym: String.
# This function initialises all indeterminates in the commutative base ring of
# the conic algebra over magma. The number of indeterminates is determined by
# comRank (the number of indeterminates comIndetSym_1, ...) and trMaxLength (the maximal
# length of trace indeterminates). This initialisation step ensures that these
# indeterminates are always printed in the same order (because they are always initialised
# in the same order).
# Returns: [indetList, comRingIndetInfo] where indetList is a list of all indeterminates
# in the commutative ring (in the order in which they are initialised) and comRingIndetInfo
# as as described above.
BindGlobal("_InitComRingIndeterminates", function(magma, comRank, comIndetSym, maxTrLength)
	local maxIndetNum, magEl, magEls, magElsReps, magElRep, trace, polyRep, monomial, i, j,
		conicRank, indetList, comRingIndetInfo;
	conicRank := ConicRank(magma);
	indetList := [];
	comRingIndetInfo := [];
	## Initialise all indeterminates of ComRing in the desired order
	for i in [1..3] do
		Add(indetList, ComRingGamIndet(i)); # Initialise indeterminate
		Add(comRingIndetInfo, ["g", i]);
	od;
	for i in [1..comRank] do
		Add(indetList, ComRingIndet(comIndetSym, i)); # Initialise indeterminate
		Add(comRingIndetInfo, ["t", i]);
	od;
	for i in [1..conicRank] do
		Add(indetList, ComRingNormIndet(magma,i)); # Initialise indeterminate
		Add(comRingIndetInfo, ["n", ConicAlgMagIndet(magma,i)]);
	od;
	## Initialise trace indeterminates in ComRing
	# List of all elements of ConicAlgMag up to length maxTrLength
	magEls := Concatenation(_AllConicAlgMagEls(magma, maxTrLength));
	magEls := Concatenation([One(magma)], magEls);
	magElsReps := List(magEls, x -> ExtRepOfObj(x));
	for i in [1..Length(magEls)] do
		magEl := magEls[i];
		magElRep := magElsReps[i];
		trace := ConicAlgMagTr(magEl);
		polyRep := ExtRepNumeratorRatFun(trace); # rep of the polynomial `trace`
		if Length(polyRep) = 2 then
			# In this case, `trace` has only one summand
			if Length(polyRep[1]) = 2 and polyRep[1][2] = 1 then
				# In this case, `trace` is (a scalar multiple of) a single indeterminate
				# to the power of 1
				if not trace in indetList then
					Add(indetList, trace);
					Add(comRingIndetInfo, ["tr", magEl]);
				fi;
			fi;
		fi;
	od;
	return [indetList, comRingIndetInfo];
end);

# comRingIndets: List of indeterminates in ComRing.
# comRingIndetInfo: As described above.
# Returns: [traceIndets, traceValues] as described above.
BindGlobal("_TraceHelpLists", function(conicAlg, comRingIndets, comRingIndetInfo)
	local i, infoList, type, info, a, emb, traceIndets, traceValues;
	traceIndets := [];
	traceValues := [];
	emb := ConicAlgMagEmbedding(conicAlg);
	for i in [1..Length(comRingIndetInfo)] do
		infoList := comRingIndetInfo[i];
		type := infoList[1];
		info := infoList[2];
		if type = "tr" then
			Add(traceIndets, comRingIndets[i]); # The variable tr(a) \in ComRing
			a := emb(info); # \in ConicAlg
			Add(traceValues, a+ConicAlgInv(a)); # The element a+a' \in ConicAlg
		fi;
	od;
	return [traceIndets, traceValues];
end);

# comRingIndets: As described above
# Returns: [trSubIndetList, trSubValueList] as described above.
# Currently these lists are filled "by hand" and only for products tr(xyz) up
# to length 3. This is sufficient for our computations.
BindGlobal("_TrSubstitutionLists", function(magma, comRingIndets)
	local tr, inv, add, indet, i, j, k, x, y, z, trSubIndetList, trSubValueList, conicRank;
	trSubIndetList := [];
	trSubValueList := [];
	conicRank := ConicRank(magma);
	tr := ConicAlgMagTr;
	inv := ConicAlgMagInv;
	indet := i -> ConicAlgMagIndet(magma, i);
	# trace: Element of ConicAlgMag.
	# value: Element of ConicAlg.
	# Adds trace and value to the desired lists.
	add := function(trace, value)
		if trace in comRingIndets and not trace in trSubIndetList then
			Add(trSubIndetList, trace);
			Add(trSubValueList, value);
		fi;
	end;
	for i in [1..conicRank] do
		for j in [1..conicRank] do
			x := indet(i);
			y := indet(j);
			## Product of length 2
			# tr(xy') = tr(x)tr(y) - tr(xy)
			if i<>j then
				add(tr(x*inv(y)), tr(x)*tr(y) - tr(x*y));
			else
				# If x=y, then the term tr(xx') never appears because it is automatically
				# replaced by 2n(x) (=tr(n(x))). Hence we write the replacement rule
				# the other way around. This is precisely relation [GPR, (16.5.8)].
				add(tr(x*x), tr(x)^2 - 2*ConicAlgMagNorm(x));
			fi;
			## Products of length 3
			for k in [1..ConicRank(magma)] do
				z := indet(k);
				# tr(xyz') = tr(xy)tr(z) - tr(xyz)
				add(tr(x*y*inv(z)), tr(x*y)*tr(z) - tr(x*y*z));
				# tr(x'yz) = tr(x)tr(yz) - tr(xyz)
				add(tr(inv(x)*y*z), tr(x)*tr(y*z) - tr(x*y*z));
				# tr(xy'z) = tr(zxy') = tr(zx)tr(y) - tr(zxy)
				add(tr(x*inv(y)*z), tr(z*x)*tr(y) - tr(z*x*y));
				# tr(x'y'z) = tr(z'yx) = tr(z)tr(yx) - tr(zyx)
				add(tr(inv(x)*inv(y)*z), tr(z)*tr(y*x) - tr(z*y*x));
				# tr(x'yz') = tr(zy'x) = tr(xz)tr(y) - tr(xzy)
				add(tr(inv(x)*y*inv(z)), tr(x*z)*tr(y) - tr(x*z*y));
				# tr(xy'z') = tr(zyx') = tr(x)tr(yz) - tr(xzy)
				add(tr(x*inv(y)*inv(z)), tr(x)*tr(y*z) - tr(x*z*y));
			od;
		od;
	od;
	return [trSubIndetList, trSubValueList];
end);

# ----- Constructors for conic algebras -----

InstallMethod(ConicAlgebra, [IsInt, IsInt, IsInt, IsRecord],
	function(comRank, conicRank, maxTrLength, symbols)
		local magma, initInfo, comRingIndets, comRingIndetInfo, comRing, conicAlg,
			famConicAlg, famConicAlgMag, famComRing, traceLists, traceSubLists,
			comSym, conicSym, zeroSym, oneSym;
		comSym := symbols.comSym;
		conicSym := symbols.conicSym;
		zeroSym := symbols.zeroSym;
		oneSym := symbols.oneSym;
		magma := ConicAlgMagma(conicRank, conicSym, oneSym, zeroSym);
		initInfo := _InitComRingIndeterminates(magma, comRank, comSym, maxTrLength);
		comRingIndets := initInfo[1];
		comRingIndetInfo := initInfo[2];
		comRing := FunctionField(ComRingBaseRing, comRingIndets);
		conicAlg := FreeMagmaRing(comRing, magma);
		famConicAlg := FamilyObj(conicAlg);
		famConicAlgMag := FamilyObj(magma);
		# Additional information to be stored in the family object of conicAlg
		famConicAlg!.conicAlg := conicAlg;
		famConicAlg!.conicAlgMagFamily := famConicAlgMag;
		# Additional information to be stored in the family object of magma
		famConicAlgMag!.comRingRank := comRank;
		famConicAlgMag!.maxTrLength := maxTrLength;
		famConicAlgMag!.comRingIndetName := comSym;
		famConicAlgMag!.conicZeroName := zeroSym;
		famConicAlgMag!.conicAlgMagEmbedding := x -> ImageElm(Embedding(magma, conicAlg), x);
		famConicAlgMag!.comRingIndetInfo := comRingIndetInfo;
		# More complicated information to be stored in the family object of magma
		traceLists := _TraceHelpLists(conicAlg, comRingIndets, comRingIndetInfo);
		famConicAlgMag!.traceIndets := traceLists[1];
		famConicAlgMag!.traceValues := traceLists[2];
		traceSubLists := _TrSubstitutionLists(magma, comRingIndets);
		famConicAlgMag!.trSubIndetList := traceSubLists[1];
		famConicAlgMag!.trSubValueList := traceSubLists[2];
		return conicAlg;
	end
);

InstallMethod(ConicAlgebra, [IsInt, IsInt, IsInt, IsString, IsString],
	function(comRank, conicRank, maxTrLength, comSym, conicSym)
		return ConicAlgebra(
			comRank, conicRank, maxTrLength, rec(
				comSym := comSym, conicSym := conicSym,
				zeroSym := _ConicDefaultZeroString,
				oneSym := _ConicDefaultOneString
			)
		);
	end
);

InstallMethod(ConicAlgebra, [IsInt, IsInt, IsInt], function(comRing, conicRank, maxTrLength)
	return ConicAlgebra(
		comRing, conicRank, maxTrLength, _ComRingIndetDefaultSymbol, _ConicIndetDefaultSymbol
	);
end);

InstallMethod(ConicAlgebra, [IsInt, IsInt], function(comRing, conicRank)
	return ConicAlgebra(
		comRing, conicRank, _DefaultMaxTrLength, _ComRingIndetDefaultSymbol, _ConicIndetDefaultSymbol
	);
end);

# Returns conic algebra containing a
InstallMethod(ConicAlgebra, [IsElementOfFreeMagmaRing], function(a)
	local fam;
	fam := CollectionsFamily(FamilyObj(a));
	if IsBound(fam!.conicAlg) then
		return fam!.conicAlg;
	else
		Error("Must be an element of a conic algebra");
	fi;
end);

# ----- Getter functions for information stored in conic algebra -----

InstallMethod(ConicAlgMagma, [IsFreeMagmaRing], function(C)
	return UnderlyingMagma(C);
end);

InstallMethod(ComRingOfConicAlg, [IsFreeMagmaRing], LeftActingDomain);

InstallMethod(ConicRank, [IsFreeMagmaRing], C -> ConicRank(ConicAlgMagma(C)));

InstallMethod(ComRingRank, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMagma(C));
	if IsBound(fam!.comRingRank) then
		return fam!.comRingRank;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

InstallMethod(ConicIndetName, [IsFreeMagmaRing], C -> ConicIndetName(ConicAlgMagma(C)));

InstallMethod(ComRingIndetName, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMagma(C));
	if IsBound(fam!.comRingIndetName) then
		return fam!.comRingIndetName;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

InstallMethod(ConicAlgMaxTrLength, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMagma(C));
	if IsBound(fam!.maxTrLength) then
		return fam!.maxTrLength;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

InstallMethod(ConicAlgMagEmbedding, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMagma(C));
	if IsBound(fam!.conicAlgMagEmbedding) then
		return fam!.conicAlgMagEmbedding;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

# ----- Nicer printing for 0 in ConicAlg -----

InstallMethod(String, "Custom string for 0 in ConicAlg", [IsElementOfFreeMagmaRing], function(x)
	local fam;
	fam := CollectionsFamily(FamilyObj(x));
	if IsBound(fam!.conicAlgMagFamily) and IsZero(x) then
		return fam!.conicAlgMagFamily!.conicZeroName;
	else
		TryNextMethod();
	fi;
end);

InstallMethod(PrintObj, "Custom string for 0 in ConicAlg", [IsElementOfFreeMagmaRing], function(x)
	if IsBound(CollectionsFamily(FamilyObj(x))!.conicAlg) then
		Print(String(x));
	else
		TryNextMethod();
	fi;
end);

# ----- Functions which test requirements and throw errors ---

# For runtime reasons, ReqComRingEl only tests whether an element is a rational function
# to determine whether it lies (or rather, can possibly lie) in ComRing.
# Similarly, ReqConicAlgEl only tests whether an element is an element of a free
# magma ring.
# Since these functions are essentially only a safeguard against inputting
# elements of ConicAlg where elements of ComRing are required (and vice versa),
# this is sufficient.

InstallMethod(ReqComRingEl, [IsRingElement], function(a)
	if _SkipTests then
		return true;
	fi;
	# We only test whether a is a rational function
	if not IsRationalFunction(a) then
		Error("Invalid input: ", a, " must be in ComRing.");
		return false;
	fi;
	return true;
end);
InstallMethod(ReqComRingEl, [IsList], function(list)
	local a;
	for a in list do
		if not ReqComRingEl(a) then
			return false;
		fi;
	od;
	return true;
end);

InstallMethod(ReqConicAlgEl, [IsRingElement], function(a)
	if _SkipTests then
		return true;
	fi;
	# We only test whether a lies in a free magma ring
	if not IsElementOfFreeMagmaRing(a) then
		Error("Invalid input: ", a, " must be in ConicAlg.");
		return false;
	fi;
	return true;
end);
InstallMethod(ReqConicAlgEl, [IsList], function(list)
	local a;
	for a in list do
		ReqConicAlgEl(a);
	od;
end);

# ----- Constructors for indeterminates -----

InstallMethod(ConicAlgIndet, [ IsFreeMagmaRing, IsInt ], function(conicAlg, i)
	local emb, magma;
	emb := ConicAlgMagEmbedding(conicAlg);
	magma := ConicAlgMagma(conicAlg);
	return emb(ConicAlgMagIndet(magma, i));
end);

InstallMethod(ConicAlgInvIndet, [ IsFreeMagmaRing, IsInt ], function(conicAlg, i)
	local emb, magma;
	emb := ConicAlgMagEmbedding(conicAlg);
	magma := ConicAlgMagma(conicAlg);
	return emb(ConicAlgMagInvIndet(magma, i));
end);

# ----- Assign generator variables -----

InstallMethod(AssignGeneratorVariables, [IsFreeMagmaRing], function(conicAlg)
	local i, varname, assignVar;
	assignVar := function(num, sym, valueFunc)
		for i in [1..num] do
			varname := Concatenation(sym, String(i));
			if IsBoundGlobal(varname) then
				UnbindGlobal(varname);
			fi;
			BindGlobal(varname, valueFunc(i));
			MakeReadWriteGlobal(varname);
		od;
	end;
	assignVar(ConicRank(conicAlg), ConicIndetName(conicAlg), i -> ConicAlgIndet(conicAlg, i));
	assignVar(ComRingRank(conicAlg), ComRingIndetName(conicAlg), i -> ComRingIndet(conicAlg, i));
	assignVar(3, _ComRingGamIndetSymbol, i -> ComRingGamIndet(i));
	varname := "dd";
	if IsBoundGlobal(varname) then
		UnbindGlobal(varname);
	fi;
	BindGlobal(varname, Liedd);
	MakeReadWriteGlobal(varname);
end);

# ----- Conjugation, trace, norm on ConicAlg -----

# a: Element of ConicAlg.
# Returns: The conjugate a' of a.
InstallMethod(ConicAlgInv, [IsElementOfFreeMagmaRing], function(a)
	ReqConicAlgEl(a);
	return ChangeRingElByMagmaTrans(ConicAlgebra(a), a, ConicAlgMagInv);
end);

# comRing: A commutative ring.
# magmaRing: A magma ring over comRing.
# magFunc: A function UnderlyingMagma(magmaRing) -> comRing.
# Returns: The linear extension of magFunc to magmaRing.
BindGlobal("ConicAlgFunctionalFromMagFunctional", function(magmaRing, comRing, magFunc)
	return function(a)
		local coeffList, result, i, magmaEl, coeff;
		coeffList := CoefficientsAndMagmaElements(a);
		result := Zero(comRing);
		for i in [1..Length(coeffList)/2] do
			magmaEl := coeffList[2*i - 1]; # \in ConicAlgMag
			coeff := coeffList[2*i]; # \in ComRing
			result := result + coeff * magFunc(magmaEl);
		od;
		return result;
	end;
end);

BindGlobal("ConicAlgTr", function(a)
	local conicAlg, comRing;
	conicAlg := ConicAlgebra(a);
	comRing := ComRingOfConicAlg(conicAlg);
	return ConicAlgFunctionalFromMagFunctional(conicAlg, comRing, ConicAlgMagTr)(a);
end);

# a, b: Elements of conic algebra.
# Returns: n(a,b) := n(a+b) - n(a) - n(b).
# By [GPR24, (16.12.4), (16.5.2)], we have n(a,b) = n(1, a'b) = t(a'b)
BindGlobal("ConicAlgNormLin", function(a, b)
	ReqConicAlgEl([a,b]);
	return ConicAlgTr(ConicAlgInv(a)*b);
end);

# a: Element of conic algebra.
# Returns: Its norm n(a), an element of ComRing.
# Uses that n(\sum_i c_i m_i) = \sum_i c_i^2 n(m_i) + sum_{i<j} c_i c_j n(m_i, m_j)
BindGlobal("ConicAlgNorm", function(a)
	local coeffList, result, i, j, magmaEl, magmaEl2, coeff, coeff2;
	ReqConicAlgEl(a);
	coeffList := CoefficientsAndMagmaElements(a);
	result := Zero(ComRingOfConicAlg(ConicAlgebra(a)));
	for i in [1..Length(coeffList)/2] do
		magmaEl := coeffList[2*i - 1]; # \in ConicAlgMag
		coeff := coeffList[2*i]; # \in ComRing
		# a is the sum of all coeff*magmaEl. Begin by adding coeff^2 * n(magmaEl).
		result := result + coeff^2 * ConicAlgMagNorm(magmaEl); # norm(x_i)
		for j in [i+1..Length(coeffList)/2] do
			magmaEl2 := coeffList[2*j - 1]; # \in ConicAlgMag
			coeff2 := coeffList[2*j]; # \in ComRing
			result := result + coeff*coeff2 * ConicAlgMagNormLin(magmaEl, magmaEl2);
		od;
	od;
	return result;
end);

# ----- Shortcuts for conjugation, trace, norm on ConicAlg OR ConicAlgMag -----

# a: Element of ConicAlgMag or of ConicAlg
# Returns: a'
InstallMethod(ConicInv, [ IsObject ], function(a)
	if IsElementOfFreeMagmaRing(a) then
		return ConicAlgInv(a);
	elif IsNonassocWord(a) then
		return ConicAlgMagInv(a);
	else
		return fail;
	fi;
end);

# Different name
InstallMethod(ConicConj, [ IsObject ], ConicInv);

# a: Element of ConicAlgMag or of ConicAlg
# Returns: tr(a) \in ComRing
InstallMethod(ConicTr, [ IsObject ], function(a)
	if IsElementOfFreeMagmaRing(a) then
		return ConicAlgTr(a);
	elif IsNonassocWord(a) then
		return ConicAlgMagTr(a);
	else
		return fail;
	fi;
end);

# a: Element of ConicAlgMag or of ConicAlg
# Returns: n(a) \in ComRing
InstallMethod(ConicNorm, [ IsObject ], function(a)
	if IsElementOfFreeMagmaRing(a) then
		return ConicAlgNorm(a);
	elif IsNonassocWord(a) then
		return ConicAlgMagNorm(a);
	else
		return fail;
	fi;
end);

# a,b: Element of ConicAlgMag or of ConicAlg (both in the same)
# Returns: n(a,b) \in ComRing
InstallMethod(ConicNormLin, [ IsObject, IsObject ], function(a,b)
	if IsElementOfFreeMagmaRing(a) and IsElementOfFreeMagmaRing(b) and FamilyObj(a) = FamilyObj(b) then
		return ConicAlgNormLin(a,b);
	elif IsNonassocWord(a) and IsNonassocWord(b) and FamilyObj(a) = FamilyObj(b) then
		return ConicAlgMagNormLin(a,b);
	else
		return fail;
	fi;
end);

# ----- Misc functions -----

# a: Element of ConicAlg.
# Returns: [t, b] with t \in ComRing, b \in ConicAlg such that a = t*One(ConicAlg)+b
# and such that b has no summand of the form s*One(ConicAlg) for s \in ComRing
BindGlobal("ConicAlgSplitOne", function(a)
	local coeffList, i, magEl, t, conicAlg;
	conicAlg := ConicAlgebra(a);
	coeffList := CoefficientsAndMagmaElements(a);
	# Look for summand t*One(ConicAlg)
	for i in [1..Length(coeffList)/2] do
		magEl := coeffList[2*i-1];
		if IsOne(magEl)  then
			# Summand t*One(ConicAlg) found
			t := coeffList[2*i];
			return [t, a - t*One(conicAlg)];
		fi;
	od;
	# No summand t*One(ConicAlg) found
	return [Zero(ComRingOfConicAlg(conicAlg)), a];
end);

# twist: Element of the twisting group of (ComRing, ConicAlg), i.e., one of
# [1,1], [-1,1], [1,-1], [-1,-1].
# a: Element of ComRing or of ConicAlg.
# Returns: twist.a, i.e., the action of twist on a.
BindGlobal("TwistGrpAct", function(twist, a)
	if IsRationalFunction(a) then # a in ComRing
		return twist[1]*a;
	else
		a := twist[1]*a;
		if twist[2] = -1 then
			return ConicAlgInv(a);
		else
			return a;
		fi;
	fi;
end);
