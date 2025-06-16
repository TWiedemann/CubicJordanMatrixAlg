### Root homomorphisms, Chevalley basis and generators of Lie

## -------- Cubic --------

DeclareOperation("CubicRootHomLong", [IsInt, IsRingElement, IsInt]);

# l: Number in {1, 2, 3}
# a: Element of ComRing
# sign: 1 or -1
# Output: If sign=1, the image of the root homomorphism in Cubic with image J_{ll}.
# If sign=-1, he image of the root homomorphism in Cubic' with image J_{ll}'.
InstallMethod(CubicRootHomLong, [IsInt, IsRingElement, IsInt], function(l, a, sign)
	local i, j, lambda;
	ReqComRingEl(a);
	i := CycPerm[l][2];
	j := CycPerm[l][3];
	lambda := ComRingGamIndet(j) * ComRingGamIndet(i)^-1;
	if sign = -1 then
		lambda := lambda^-1;
	fi;
	return CubicComEl(l, lambda * a);
end);

DeclareOperation("CubicRootHomShort", [IsInt, IsRingElement, IsInt]);

# l: Number in {1, 2, 3}. Denote by (i,j,l) the corresponding cyclic perm. of (1,2,3).
# a: Element of ComRing
# sign: 1 or -1
# Output: If sign=1, the image of the root homomorphism in Cubic with image J_{ij}.
# If sign=-1, he image of the root homomorphism in Cubic' with image J_{ij}'.
InstallMethod(CubicRootHomShort, [IsInt, IsRingElement, IsInt], function(l, a, sign)
	local i, j, lambda;
	ReqConicAlgEl(a);
	i := CycPerm[l][2];
	j := CycPerm[l][3];
	if sign = 1 then
		lambda := ComRingGamIndet(j)^-1;
	else
		lambda := ComRingGamIndet(i)^-1;
	fi;
	return CubicAlgEl(l, lambda * a);
end);

## -------- Brown --------

DeclareOperation("BrownRootHom", [IsList, IsRingElement]);

# subroot: List [r2, r3, r4] of integers with [1, r2, r3, r4] \in F4
# (equiv. [-1, r2, r3, r4] \in F4).
# a: An element of ConicAlg or of Comring
# Output: An element b of the Brown algebra such that BrownPosToLieEmb(b) is the a-element
# of the [1, r2, r3, r4]-space of Lie and such that BrownNegToLieEmb(b) is the a-element
# of the [-1, r2, r3, r4]-space of Lie.
InstallMethod(BrownRootHom, [IsList, IsRingElement], function(subroot, a)
	local cub, l, sign;
	if not Concatenation([1], subroot) in F4Roots then
		Error("Invalid argument");
		return fail;
	fi;
	if subroot = [1,1,1] then
		return BrownElFromTuple(Zero(ComRing), CubicZero, CubicZero, a);
	elif subroot = [-1, -1, -1] then
		return BrownElFromTuple(a, CubicZero, CubicZero, Zero(ComRing));
	elif Sum(subroot) = 1 then
		l := Position(subroot, -1);
		if l <> fail then
			ReqComRingEl(a);
			cub := CubicRootHomLong(l, a, -1);
		else
			ReqConicAlgEl(a);
			l := Position(subroot, 1);
			cub := CubicRootHomShort(l, a, -1);
		fi;
		return BrownElFromTuple(Zero(ComRing), CubicZero, cub, Zero(ComRing));
	else
		l := Position(subroot, 1);
		if l <> fail then
			ReqComRingEl(a);
			cub := CubicRootHomLong(l, a, 1);
		else
			ReqConicAlgEl(a);
			l := Position(subroot, -1);
			cub := CubicRootHomShort(l, a, 1);
		fi;
		return BrownElFromTuple(Zero(ComRing), cub, CubicZero, Zero(ComRing));
	fi;
end);

## -------- DD --------

DeclareOperation("DDRootHomA2", [IsList, IsRingElement]);

# root: A root in A_2 (e.g. [1, -1, 0]).
# a: An element of ConicAlg.
# Output: The a-element in the root space of DD w.r.t root.
InstallMethod(DDRootHomA2, [IsList, IsRingElement], function(root, a)
    local i, j, l, lambda;
    ReqConicAlgEl(a);
    # The root space w.r.t. root is Z_{i \to j}
    i := Position(root, 1);
    j := Position(root, -1);
    l := Position(root, 0);
	if root = [1, -1, 0] then
		lambda := ComRingGamIndet(1)^-1 * ComRingGamIndet(2)^-1 * ComRingGamIndet(3);
	elif root = [-1, 1, 0] then
		lambda := ComRingGamIndet(3)^-1;
	elif root = [1, 0, -1] then
		lambda := ComRingGamIndet(2)^-1;
	elif root = [-1, 0, 1] then
		lambda := ComRingGamIndet(1)^-1 * ComRingGamIndet(2) * ComRingGamIndet(3)^-1;
	elif root = [0, 1, -1] then
		lambda := ComRingGamIndet(1) * ComRingGamIndet(2)^-1 * ComRingGamIndet(3)^-1;
	elif root = [0, -1, 1] then
		lambda := ComRingGamIndet(1)^-1;
	else
		return fail;
	fi;
    return dd(CubicComEl(i, One(ComRing)), lambda*CubicAlgElMat(i, j, a));
end);

## -------- Lie --------

DeclareOperation("LieRootHomF4", [IsList, IsRingElement]);

InstallMethod(LieRootHomF4, [IsList, IsRingElement], function(root, a)
	local sum, G2Root, minusSignRootsLong, minusSignRootsShort, cub, sign, l;
	if root in F4LongRoots then
		ReqComRingEl(a);
	elif root in F4ShortRoots then
		ReqConicAlgEl(a);
	else
		Error("Argument must be a root in F4");
		return fail;
	fi;
	# Add minus signs to ensure that we get a Chevalley basis
	minusSignRootsLong := Difference(F4NegLongRoots, [
		[-1, -1, -1, 1], [1, 1, -1, 1], [1, -1, 1, 1], [-1, 1, 1, 1],
	]);
	minusSignRootsShort := [
		[1, 0, -1, 0], [0, 1, 0, 1], [0, 0, 1, 1], [0, -1, -1, 0],
		[-1, 1, 0, 0], [-1, 0, 0, 1]
	];
	if root in Union(minusSignRootsLong, minusSignRootsShort) then
		a := -a;
	fi;
	G2Root := F4RootG2Coord(root);
	# L_{-2}
	if G2Root[1] = -2 then
		return a * LieX;
	# L_{-1}
	elif G2Root[1] = -1 then
		return BrownNegToLieEmb(BrownRootHom(root{[2..4]}, a));
	# L_0
	elif G2Root in [[0, 1], [0, -1]] then
		sign := G2Root[2];
		l := PositionProperty(root{[2..4]}, x -> AbsoluteValue(x) = 2);
		if l <> fail then
			ReqComRingEl(a);
			cub := CubicRootHomLong(l, a, sign);
		else
			ReqConicAlgEl(a);
			l := Position(root{[2..4]}, 0);
			cub := CubicRootHomShort(l, a, sign);
		fi;
		if sign = 1 then
			return CubicPosToLieEmb(cub);
		else
			return CubicNegToLieEmb(cub);
		fi;
	elif G2Root = [0,0] then
		return DDToLieEmb(DDRootHomA2(root{[2..4]}, a));
	# L_1
	elif G2Root[1] = 1 then
		return BrownPosToLieEmb(BrownRootHom(root{[2..4]}, a));
	# L_2
	elif G2Root[1] = 2 then
		return a * LieY;
	fi;
end);

## -------- Generators of Lie --------

# comIndetNum, conicIndetNum: Numbers of the indeterminates that should be used.
# Output: A list of generic basic elements of Lie (as a Lie algebra),
# involving indeterminates t_comIndetNum, a_conicIndetNum
# If the last (boolean) input variable is true, then the generator list contains
# LieY and elements from L_{-1}. Otherwise (and by default) it contains LieX
# and elements from L_1.
DeclareOperation("LieGensAsLie", [IsInt, IsInt, IsBool]);
DeclareOperation("LieGensAsLie", [IsInt, IsInt]);

InstallMethod(LieGensAsLie, [IsInt, IsInt, IsBool],
	function(comIndetNum, conicIndetNum, var)
		local a, t, gens, root, coord;
		t := ComRingBasicIndet(comIndetNum);
		a := ConicAlgBasicIndet(conicIndetNum);
		if var then
			gens := [LieY];
			coord := -1;
		else
			gens := [LieX];
			coord := 1;
		fi;
		for root in Filtered(F4Roots, x -> F4RootG2Coord(x)[1] = coord) do
			if root in F4ShortRoots then
				Add(gens, LieRootHomF4(root, a));
			else
				Add(gens, LieRootHomF4(root, t));
			fi;
		od;
		return gens;
	end);

InstallMethod(LieGensAsLie, [IsInt, IsInt], function(comIndetNum, conicIndetNum)
	return LieGensAsLie(comIndetNum, conicIndetNum, false);
end);

# comIndetNum, conicIndetNum: Numbers of the indeterminates that should be used.
# Output: A list of generic basic elements of Lie (as a module), involving indeterminates
# t_comIndetNum, a_conicIndetNum, a_{conicIndetNum+1}.
# Uses the formulas from [DMW, 5.20] (d_{a[ij],b[jk]} = TwistDiag[j]*d_{1[ii],ab[kk]})
# to reduce the number of generators.
LieGensAsModule := function(comIndetNum, conicIndetNum)
	local t1, a1, a2, gens, root, i, j, gen;
	t1 := ComRingBasicIndet(comIndetNum);
	a1 := ConicAlgBasicIndet(conicIndetNum);
	a2 := ConicAlgBasicIndet(conicIndetNum + 1);
	gens := [LieXi, LieZeta];
	# Generators outside DD
	for root in F4Roots do
		if F4RootG2Coord(root) <> [0, 0] then
			if root in F4ShortRoots then
				Add(gens, LieRootHomF4(root, a1));
			else
				Add(gens, LieRootHomF4(root, t1));
			fi;
		fi;
	od;
	# Generators in DD
	# Generators of Z_{i \to j} for i <> j and of Z_{ii,ii}
	for i in [1..3] do
		for j in [1..3] do
			if i = j then
				gen := Liedd(CubicComEl(i, One(ComRing)), CubicComEl(i, t1));
			else
				gen := Liedd(CubicComEl(i, One(ComRing)), CubicAlgElMat(i, j, a1));
			fi;
			Add(gens, gen);
		od;
	od;
	# Generators of Z_{ij,ji} for i <> j
	for i in [1..3] do
		for j in [i+1..3] do
			Add(gens, Liedd(CubicAlgElMat(i, j, a1), CubicAlgElMat(j, i, a2)));
		od;
	od;
	return gens;
end;

# (Probably not used)
# As LieGensAsModule, but does not use the formulas from [DMW, 5.20].
LieGensAsModuleUnsimplified := function(indetNum)
	local t1, a1, gens, root, cubic1, cubic2, cubicGens1, cubicGens2;
	t1 := ComRingBasicIndet(2*indetNum + 1);
	a1 := ConicAlgBasicIndet(2*indetNum + 1);
	gens := [LieXi, LieZeta];
	# Generators outside DD
	for root in F4Roots do
		if F4RootG2Coord(root) <> [0, 0] then
			if root in F4ShortRoots then
				Add(gens, LieRootHomF4(root, a1));
			else
				Add(gens, LieRootHomF4(root, t1));
			fi;
		fi;
	od;
	# Generators in DD
	cubicGens1 := CubicGensAsModule(2*indetNum + 1);
	cubicGens2 := CubicGensAsModule(2*indetNum + 2);
	for cubic1 in cubicGens1 do
		for cubic2 in cubicGens2 do
			Add(gens, Liedd(cubic1, cubic2));
		od;
	od;
	return gens;
end;
