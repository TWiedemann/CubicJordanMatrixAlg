### Root homomorphisms, Chevalley basis and generators of Lie

## -------- Cubic --------

DeclareOperation("CubicRootHomF4", [IsList, IsRingElement, IsInt]);

# root: An element [r1, r2, r3, r4] of F4 s.t. the [r1,r2,r3,r4]-space of Lie lies in Cubic or Cubic'
# a: An element of ConicAlg or of Comring
# sign: If sign = 1, the root hom on Cubic is computed. If sign = -1, the root hom on Cubic' is computed.
# Output: An element c of Cubic which, embedded "appropriately" into Lie, is the a-element
# of the [r1,r2,r3,r4]-space of Lie.
InstallMethod(CubicRootHomF4, [IsList, IsRingElement, IsInt], function(root, a, sign)
	local l, sum, comRingHom, conicAlgHom;
	if not root in F4Roots then
		Error("Argument is not a root");
		return fail;
	elif AbsoluteValue(root[1])= 2  or AbsoluteValue(Sum(root{[2..4]})) in [0, 3] then
		Error("CubicRootHomF4 not defined for this root");
		return fail;
	elif not sign in [1, -1] then
		Error("sign must be 1 or -1");
		return fail;
	fi;
	comRingHom := function(l, a)
		local i, j, lambda;
		ReqComRingEl(a);
		i := CycPerm[l][2];
		j := CycPerm[l][3];
		lambda := ComRingGamIndet(j) * ComRingGamIndet(i)^-1;
		if sign = -1 then
			lambda := lambda^-1;
		fi;
		# lambda := One(ComRing); # Revert to naive parametrisation
		return CubicComEl(l, lambda * a); # TODO: Is this correct?
	end;
	conicAlgHom := function(l, a)
		local i, j, lambda;
		ReqConicAlgEl(a);
		i := CycPerm[l][2];
		j := CycPerm[l][3];
		if sign = 1 then
			lambda := ComRingGamIndet(j)^-1;
		else
			lambda := ComRingGamIndet(i)^-1;
		fi;
		# lambda := One(ComRing); # Revert to naive parametrisation
		return CubicAlgEl(l, lambda * a); # TODO: Is this correct?
	end;
	if root[1] = 0 then
		# L_0
		l := PositionProperty(root{[2..4]}, x -> AbsoluteValue(x) = 2);
		if l <> fail then
			return comRingHom(l, a);
		else
			l := Position(root{[2..4]}, 0);
			return conicAlgHom(l, a);
		fi;
	else
		# L_{+-1}
		if 0 in root{[2..4]} then
			l := PositionProperty(root{[2..4]}, x -> x <> 0); # First (and only) non-zero position of roots[2..4]
			return conicAlgHom(l, a);
		else
			# l is the only position of root{[2..4]} whose entry appears only once
			sum := Sum(root{[2..4]});
			l := PositionProperty(root{[2..4]}, x -> x <> sum);
			return comRingHom(l, a);
		fi;
	fi;
end);

## -------- Brown --------

DeclareOperation("BrownRootHomF4", [IsList, IsRingElement]);

# root: An element [r1, r2, r3, r4] of F4 with r1 = 1 or r1 = -1.
# a: An element of ConicAlg or of Comring
# Output: An element b of the Brown algebra such that BrownPosToLieEmb(b) is the a-element
# of the [1, r2, r3, r4]-space of Lie and such that BrownNegToLieEmb(b) is the a-element
# of the [-1, r2, r3, r4]-space of Lie. (Note that r1 is ignored)
InstallMethod(BrownRootHomF4, [IsList, IsRingElement], function(root, a)
	if not root in F4Roots then
		Error("Argument is not a root");
		return fail;
	elif not root[1] in [1, -1] then
		Error("BrownRootHomF4 not defined for this root");
		return fail;
	fi;
	if root{[2..4]} = [1,1,1] then
		return BrownElFromTuple(Zero(ComRing), CubicZero, CubicZero, a);
	elif root{[2..4]} = [-1, -1, -1] then
		return BrownElFromTuple(a, CubicZero, CubicZero, Zero(ComRing));
	elif Sum(root{[2..4]}) = 1 then
		return BrownElFromTuple(Zero(ComRing), CubicZero, CubicRootHomF4(root, a, -1), Zero(ComRing));
	else
		return BrownElFromTuple(Zero(ComRing), CubicRootHomF4(root, a, 1), CubicZero, Zero(ComRing));
	fi;
end);

## -------- DD --------

DeclareOperation("DDRootHomA2", [IsList, IsRingElement]);

# root: A root in A_2.
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
	# lambda := ComRingGamIndet(i)^-1 * ComRingGamIndet(j)^-1 * ComRingGamIndet(l);
	# if not [i, j, l] in CycPerm then
	# 	lambda := lambda^-1;
	# fi;
    return dd(CubicComEl(i, One(ComRing)), lambda*CubicAlgElMat(i, j, a)); # TODO: Is this correct?
end);

## -------- Lie --------

DeclareOperation("LieRootHomF4", [IsList, IsRingElement]);

InstallMethod(LieRootHomF4, [IsList, IsRingElement], function(root, a)
	local sum, G2Root, minusSignRootsLong, minusSignRootsShort;
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
		return BrownNegToLieEmb(BrownRootHomF4(root, a));
	# L_0
	elif G2Root = [0, 1] then
		return CubicPosToLieEmb(CubicRootHomF4(root, a, 1));
	elif G2Root = [0, -1] then
		return CubicNegToLieEmb(CubicRootHomF4(root, a, -1));
	elif G2Root = [0,0] then
		return DDToLieEmb(DDRootHomA2(root{[2..4]}, a));
	# L_1
	elif G2Root[1] = 1 then
		return BrownPosToLieEmb(BrownRootHomF4(root, a));
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
