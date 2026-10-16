### This file contains the definition of ConicAlg, a free nonassociative algebra
### that represents an arbitrary multiplicative conic alternative algebra,
### and functions related to it.
### Technically, ConicAlg is a free magma ring over the free magma ConicAlgMag
### whose coefficient ring is ComRing.

# ----- Constructors for conic algebras -----

InstallMethod(ConicAlgebra, [IsInt, IsInt, IsInt, IsString, IsString, IsString, IsString],
	function(comRank, conicRank, maxTrLength, comSym, conicSym, zeroSym, oneSym)
		local magma, initInfo, comRingIndets, comRingIndetInfo, comRing, conicAlg;
		magma := ConicAlgMagma(conicRank, conicSym, oneSym);
		initInfo := _InitComRingIndeterminates(magma, comRank, comSym, maxTrLength);
		comRingIndets := initInfo[1];
		comRingIndetInfo := initInfo[2];
		comRing := FunctionField(ComRingBaseRing, comRingIndets);
		conicAlg := FreeMagmaRing(ComRing, magma);
		# Store information in families
		famConicAlg := FamilyObj(conicAlg);
		famConicAlgMag := FamilyObj(Magma);
		famConicAlg!.conicAlg := conicAlg;
		famConicAlg!.conicAlgMagFamily := famConicAlgMag;
		# Additional information to be stored in the family object of magma
		famConicAlgMag!.comRingRank := comRank;
		famConicAlgMag!.maxTrLength := maxTrLength;
		famConicAlgMag!.comRingIndetName := comSym;
		famConicAlgMag!.conicZeroName := zeroSym;
		famConicAlgMag!.conicAlgMagEmbedding := x -> ImageElm(Embedding(magma, conicAlg), x);
		famConicAlgMag!.comRingIndetInfo := comRingIndetInfo;
		return conicAlg;
	end
);

InstallMethod(ConicAlgebra, [IsInt, IsInt, IsInt, IsString, IsString],
	function(comRank, conicRank, maxTrLength, comSym, conicSym)
		return ConicAlgebra(
			comRank, conicRank, maxTrLength, comSym, conicSym,
			_ConicDefaultZeroString, _ConicDefaultOneString
		);
	end
);

InstallMethod(ConicAlgebra, [IsInt, IsInt, IsInt], function(comRing, conicRank, maxTrLength)
	return ConicAlgebra(
		comRing, conicRank, maxTrLength, _ComRingIndetDefaultSymbol, _ConicIndetDefaultSymbol
	);
);

InstallMethod(ConicAlgebra, [IsInt, IsInt], function(comRing, conicRank)
	return ConicAlgebra(
		comRing, conicRank, _DefaultMaxTrLength, _ComRingIndetDefaultSymbol, _ConicIndetDefaultSymbol
	);
);

# ----- Getter functions for information stored in conic algebra -----

InstallMethod(ConicAlgebra, [IsElementOfFreeMagmaRing], function(a)
	local fam;
	fam := CollectionsFamily(FamilyObj(a));
	if IsBound(fam!.conicAlgebra) then
		return fam!.conicAlgebra;
	else
		Error("Must be an element of a conic algebra");
	fi;
end);

InstallMethod(ConicAlgMagma, [IsFreeMagmaRing], function(C)
	return UnderlyingMagma(C);
end);

InstallMethod(ComRingOfConicAlg, [IsFreeMagmaRing], LeftActingDomain);

InstallMethod(ConicRank, [IsFreeMagmaRing], C -> ConicRank(ConicAlgMagma(C)));

InstallMethod(ComRingRank, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMag(C));
	if IsBound(fam!.comRingRank) then
		return fam!.comRingRank;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

InstallMethod(ConicIndetName, [IsFreeMagmaRing], C -> ConicIndetName(ConicAlgMagma(C)));

InstallMethod(ComRingIndetName, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMag(C));
	if IsBound(fam!.comRingIndetName) then
		return fam!.comRingIndetName;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

InstallMethod(ConicAlgMaxTrLength, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMag(C));
	if IsBound(fam!.maxTrLength) then
		return fam!.maxTrLength;
	else
		Error("Magma ring must be a conic algebra");
	fi;
end);

InstallMethod(ConicAlgMagEmbedding, [IsFreeMagmaRing], function(C)
	local fam;
	fam := FamilyObj(ConicAlgMag(C));
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
	if IsBound(Collections(FamilyObj(x))!.conicAlgebra) then
		Print(String(x));
	else
		TryNextMethod();
	fi;
end);

# ----- Functions which test requirements and throw errors ---

DeclareOperation("ReqComRingEl", [IsRingElement]);
DeclareOperation("ReqComRingEl", [IsList]);
DeclareOperation("ReqConicAlgEl", [IsRingElement]);
DeclareOperation("ReqConicAlgEl", [IsList]);

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
	emb := ConicAlgMagEmbedding(conicAlg);
	magma := ConicAlgMagma(conicAlg);
	return emb(ConicAlgMagIndet(magma, i));
end);

BindGlobal("ConicAlgInvIndet", function(i)
	emb := ConicAlgMagEmbedding(conicAlg);
	magma := ConicAlgMagma(conicAlg);
	return emb(ConicAlgMagInvIndet(magma, i));
end);

# ----- Conjugation, trace, norm on ConicAlg -----

# 
# a: Element of ConicAlg.
# Returns: The conjugate a' of a.
BindGlobal("ConicAlgInv", [IsElementOfFreeMagmaRing], function(a)
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
		result := Zero(ComRing);
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
	comRing := ComRingOfConicAlg(a);
	return ConicAlgFunctionalFromMagFunctional(conicAlg, comRing, ConicAlgMagTr)(a);
end);

# a, b: Elements of ConicAlg.
# Returns: n(a,b) := n(a+b) - n(a) - n(b).
# By [GPR24, (16.12.4), (16.5.2)], we have n(a,b) = n(1, a'b) = t(a'b)
BindGlobal("ConicAlgNormLin", function(a, b)
	ReqConicAlgEl([a,b]);
	return ConicAlgTr(ConicAlgInv(a)*b);
end);

# a: Element of ConicAlg.
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
	local coeffList, i, magEl, t;
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
