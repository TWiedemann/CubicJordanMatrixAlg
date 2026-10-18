### This file contains tests of (special cases of) statements that are proven
### abstractly or by hand in [DMW]. It is not loaded by default.

# Tests whether GrpRootHomF4(conicAlg, root, _) is a homomorphism.
# If root is short: Uses indeterminates a_1, a_2, a_(ConicRank), t_(ComRingRank),
# and it is assumed that ConicRank > 2.
# If root is long: Uses indeterminates t_1, t_2, t_(ComRingRank), a_(ConicARank),
# and it is assumed that ComRingRank > 2.
TestGrpRootHom := function(conicAlg, root)
	local x1, x2, g1, g2, g3;
	if root in F4ShortRoots then
		x1 := ConicAlgIndet(conicAlg, 1);
		x2 := ConicAlgIndet(conicAlg, 2);
	elif root in F4LongRoots then
		x1 := ComRingIndet(conicAlg, 1);
		x2 := ComRingIndet(conicAlg, 2);
	else
		return fail;
	fi;
	g1 := GrpRootHomF4(conicAlg, root, x1);
	g2 := GrpRootHomF4(conicAlg, root, x2);
	g3 := GrpRootHomF4(conicAlg, root, x1+x2);
	if IsEmpty(TestEqualityPieces(g1*g2, g3)) then
		return true;
	else
		return false;
	fi;
end;

# Tests whether GrpRootHomF4 is a homomorphism for all roots.
# Uses indeterminates a_1, a_2, t_1, t_2, a_(ConicRank), t_(ComRingRank),
# and it is assumed that ComRingRank > 2 and ConicRank > 2.
TestGrpRootHoms := function(conicAlg)
	local root;
	for root in F4Roots do
		if not TestGrpRootHom(conicAlg, root) then
			Print("Problem for ", root, "\n");
			return false;
		fi;
	od;
	return true;
end;

# root: Root in F4 with F4RootGsCoord
# Returns: true if GrpRootHomF4 and GrpRootHomF4Div coincide on root.
# Otherweise returns the corresponding error list of terms that have to be checked by hand.
# Uses indeterminates a_1, a_{ConicRank-1}, a_{ConicRank}, t_1, t_{ComRingRank}
TestGrpRootHomExp := function(conicAlg, root)
	local a;
	if root in F4ShortRoots then
		a := ConicAlgIndet(conicAlg, 1);
	elif root in F4LongRoots then
		a := ComRingIndet(conicAlg, 1);
	fi;
	return TestEqualityOnModuleGens(
		conicAlg,
		GrpRootHomF4Div(conicAlg, root, a), GrpRootHomF4(conicAlg, root, a)
	);
end;

# Returns: true if TestGrpRootHomExp succeeds for all roots in F4 with F4RootGsCoord <> [0,0].
# Otherwise returns the list of all error terms that have to be checked by hand.
TestNon00GrpRootHomExp := function(conicAlg)
	local root, test, errorList;
	errorList := [];
	for root in F4Roots do
		if F4RootG2Coord(root) <> [0,0] then
			test := TestGrpRootHomExp(conicAlg, root);
			if test <> true then
				errorList := Concatenation(errorList, List(test, x -> x[2]));
			fi;
		fi;
	od;
	if IsEmpty(errorList) then
		return true;
	else
		return errorList;
	fi;
end;

# Displays the test results for some of the conjugation formulas for Weyl elements in the G2-grading.
# We test these formulas only for cubic Jordan matrix algebras, so these tests do not provide a
# proof of the more general statements in [DMW]. They are merely a sanity check.
TestG2WeylFormulas := function(conicAlg)
	local bCub, bCubInv, bLie, bInvLie, phiMid, phiMidInv, phiR, phiRInv, phibs, phibsInv, t, iota,
		iotainv, testList, aCub, aLie1, aLie2, list, t1, a1;
	t1 := ComRingIndet(conicAlg, 1);
	a1 := ConicAlgIndet(conicAlg, 1);
	# Define phibs as w(bLie), a product of exponential automorphisms
	bCub := Sum(
		t1*CubicComEl(conicAlg, t1, 1), CubicComEl(conicAlg, One(t1), 2),
		CubicComEl(conicAlg, One(t1), 3)
	);
	bCubInv := CubicNorm(bCub)^-1 * CubicAdj(bCub);
	bLie := BrownNegEl(Zero(t1), bCub, CubicZero(conicAlg), Zero(t1));
	bInvLie := BrownPosEl(Zero(t1), CubicZero(conicAlg), -bCubInv, Zero(t1));
	phiMid := F4Exp(-bLie);
	phiMidInv := F4Exp(bLie);
	phiR := F4Exp(-bInvLie);
	phiRInv := F4Exp(bInvLie);
	phibs := phiR * phiMid * phiR; # = \phibs^-1
	phibsInv := phiRInv * phiMidInv * phiRInv;
	# Further constants
	t := CubicNorm(bCub);
	iota := x -> t*JordanU(bCubInv, x);
	iotainv := x -> t^-1 * JordanU(bCub, x);
	# testList will contain lists [e1, e2] for which we test that phibsInv*e1*phibs=e2
	testList := [];
	# e_{(0,a,0,0)_+}^\phibs = e_{-a^\iota}
	aCub := CubicConicEl(a1, 1);
	aLie1 := BrownPosEl(Zero(t1), aCub, CubicZero(conicAlg), Zero(t1));
	aLie2 := CubicNegToLieEmb(-iota(aCub));
	Add(testList, [F4Exp(aLie1), F4Exp(aLie2)]);
	# e_{(0,0,a',0)_+}^\phibs = e_{(0,-t(a')^\iota, 0, 0)_-}
	aLie1 := BrownPosEl(Zero(t1), CubicZero(conicAlg), aCub, Zero(t1));
	aLie2 := BrownNegEl(Zero(t1), -t*iotainv(aCub), CubicZero(conicAlg), Zero(t1));
	Add(testList, [F4Exp(aLie1), F4Exp(aLie2)]);
	# e_{(0,a,0,0)_-}^\phibs = e_{(0,0, -t^{-1} a^\iota, 0)_+}
	aLie1 := BrownNegEl(Zero(t1), aCub, CubicZero(conicAlg), Zero(t1));
	aLie2 := BrownPosEl(Zero(t1), CubicZero(conicAlg), -t^-1*iota(aCub), Zero(t1));
	Add(testList, [F4Exp(aLie1), F4Exp(aLie2)]);
	# Perform actual tests
	for list in testList do
		if TestEquality(conicAlg, phibsInv*list[1]*phibs, list[2]) <> true then
			return false;
		fi;
	od;
	return true;
end;
