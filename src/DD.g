SanitizeImmediately := true; # If true, DDSanitizeRep is applied after several transformations which may produce unsanitized (but correct) output

# DD is the ComRing-span of all dd_{a,b} for a, b \in Cubic.
# An element c1 * dd_{a1, b1} + c2 * dd_{a2, b2} + ... is represented by
# the list [[c1, a1, b2], [c2, a2, b2], ...].

DDSanitizeRep := function(rep)
	local i, j, x;
	for i in [Length(rep), Length(rep)-1 .. 1] do
		if i > Length(rep) then
			# This may happen because we remove elements from rep during the loop
			continue;
		fi;
		x := rep[i];
		if x[1] = Zero(ComRing) or IsZero(x[2]) or IsZero(x[3]) then
			Remove(rep, i);
			continue;
		fi;
		for j in [1..i-1] do
			if rep[j][2] = x[2] and rep[j][3] = x[3] then
				rep[j][1] := rep[j][1] + x[1];
				Remove(rep, i);
				if rep[j][1] = Zero(ComRing) then
					Remove(rep, j);
				fi;
				break;
			fi;
		od;
	od;
end;

L0ZeroString := "0_{L_0}";
DDSymString := "\dd";

DDRepToString := function(a)
	local stringList, summand, s;
	stringList := [];
	for summand in a do
		s := Concatenation(DDSymString, "_{", String(summand[2]), ",", String(summand[3]), "}");
		if summand[1] <> One(ComRing) then
			s := Concatenation("(", String(summand[1]), ")", "*", s); 
		fi;
		Add(stringList, s);
	od;
	return StringSum(stringList, "+", L0ZeroString);
end;

DDSpec := rec(
	ElementName := "DDElement",
	Zero := a -> [],
	Addition := function(a, b)
		local sum;
		sum := Concatenation(a,b);
		if SanitizeImmediately then
			DDSanitizeRep(sum);
		fi;
		return sum;
	end,
	AdditiveInverse := function(a)
		local inv, i;
		inv := [];
		for i in [1..Length(a)] do
			Add(inv, [-a[i][1], a[i][2], a[i][3]]);
		od;
		return inv;
	end,
	Print := function(a)
		Print(DDRepToString(a));
	end,
	# Lie bracket on DD
	Multiplication := function(a, b)
		local productRep, summand1, summand2, x1, x2, y1, y2, z1, z2, coeff;
		# We do not sanitize the input because, under normal circumstances, it should already
		# be sanitized
		productRep := [];
		for summand1 in a do
			x1 := summand1[2];
			x2 := summand1[3];
			for summand2 in b do
				y1 := summand2[2];
				y2 := summand2[3];
				# summand1*summand2 = coeff * (dd_{D_{x1,x2}(y1), y2} - dd_{y1, D_{x2,x1}(y2)})
				# Here "D" is JordanD
				coeff := summand1[1] * summand2[1]; # in ComRing
				z1 := JordanD(x1, x2, y1);
				z2 := y2;
				if not IsZero(z1) then
					Add(productRep, [coeff, z1, z2]);
				fi;
				z1 := y1;
				z2 := JordanD(x2, x1, y2);
				if not IsZero(z2) then
					Add(productRep, [-coeff, z1, z2]);
				fi;
			od;
		od;
		if SanitizeImmediately then
			DDSanitizeRep(productRep);
		fi;
		return productRep;
	end,
	MathInfo := IsAdditivelyCommutativeElement
);

DD := ArithmeticElementCreator(DDSpec);
InstallMethod(String, [IsDDElement], x -> DDRepToString(UnderlyingElement(x)));

## ---- Getters ----
DeclareOperation("DDCoeffList", [IsDDElement]);

# ddEl: c1*dd_{a1,b1} + c2*dd_{a2,b2} + ...
# Output: [[c1, a1, b1], [c2, a2, b2], ...]
InstallMethod(DDCoeffList, [IsDDElement], function(ddEl)
	return UnderlyingElement(ddEl);
end);

## ---- Constructors ----
DDZero := DD([]);

DeclareOperation("dd", [IsCubicElement, IsCubicElement]);
InstallMethod(dd, [IsCubicElement, IsCubicElement], function(cubicEl1, cubicEl2)
	if IsZero(cubicEl1) or IsZero(cubicEl2) then
		return DDZero;
	else
		return DD([[One(ComRing), cubicEl1, cubicEl2]]);
	fi;
end);


# Scalar multiplication ComRing x DD -> DD
InstallOtherMethod(\*, "for ComRingElement and DDElement", [IsRingElement, IsDDElement], 2, function(comEl, ddEl)
	local resultRep, summand;
    ReqComRingEl(comEl);
    resultRep := [];
    for summand in UnderlyingElement(ddEl) do
        Add(resultRep, [comEl*summand[1], summand[2], summand[3]]);
    od; 
	return DD(resultRep);
end);

## ---- Simplifier ----

# ddEl: Element of DD.
# Output: An element of DD which (mathematically) represents the same element of DD,
# but each summand of the output is of the form t * dd_{a,b} for some t \in ComRing and
# a, b \in Cubic where both a and b have exactly one non-zero entry.
# Further, each summand of the form dd_{a[ij], b[kl]} with Intersection([i,j], [k,l]) = []
# is removed (because it represents 0). [DMW, 3.8, 5.2, 5.3 (iii)]
DeclareOperation("ApplyDistAndPeirceLaw", [IsDDElement]);
InstallMethod(ApplyDistAndPeirceLaw, [IsDDElement], function(ddEl)
	local coeffList, resultCoeffList, summand, cubic1, cubic2, summand1, summand2,
			i1, i2, j1, j2, summandList1, summandList2, p, q, aCoeffList, bCoeffList,
			aMonomial, bMonomial, ddCoeffList, a, b, aCoeff, bCoeff, ddCoeff,
			intersection, k, l;
	# x: Element of ComRing or ConicAlg.
	# Output: If x in ComRing: [x, One(ComRing)].
	# If x in ConicAlg: List [t_1, c_1, ..., t_k, c_k] with t_i in ComRing and c_i in ConicAlg
	# where c_i is a monomial (i.e., is the image of an element of ConicAlgMag).
	# The output l satisfies x = sum_{i=1}^{Length(l)} l[2*i-1] * l[2*i]
	# CoeffList := function(x)

	# end;
	ddCoeffList := DDCoeffList(ddEl);
	resultCoeffList := [];
	for summand in coeffList do
		ddCoeff := summand[1];
		cubic1 := summand[2];
		cubic2 := summand[3];
		# Split up the summands of cubic1 and cubic2 (distributive law)
		for summandList1 in Summands(cubic1) do
			for summandList2 in Summands(cubic2) do
				# TODO: Apply CoefficientsAndMagmaElements to elements of ConicAlg and push all coefficients from ComRing to coeff
				# In the same run, push all elements of ConicAlg to the right factor whenever possible
				i1 := summandList1[1];
				j1 := summandList1[2];
				a := summandList1[3]; # in ComRing or Conicalg
				i2 := summandList2[1];
				j2 := summandList2[2];
				b := summandList2[3]; # in ComRing or ConicAlg
				intersection := Intersection([i1,j1], [i2,j2]);
				if Size(intersection) = 1 then
					# Define k, p, l such that dd(cubic1, cubic2) lies in Z_{kp,pl}
					p := intersection[1];
					if j1 = p then
						k := i1;
					else
						k := j1;
					fi;
					if i2 = p then
						l := j2;
					else
						l := i2;
					fi;
					# Replace a by ConicAlgInv(a) if necessary to ensure that
					# cubic1 = CubicAlgElMat(k, p, a)
					if i1 <> k then
						# Since { i1, j1 } = { k, p }, we have a in ConicAlg in this case
						a := ConicAlgInv(a);
					fi;
					# Similarly for b
					if j2 <> l then
						b := ConicAlgInv(b);
					fi;

				elif Size(intersection) = 2 then

				fi;
				# Remove zero summands (Peirce law)
				if not IsEmpty(Intersection([i1,j1], [i2,j2])) then
					# Split up a and b into sums of monomials
					aCoeffList := CoefficientsAndMagmaElements(a);
					bCoeffList := CoefficientsAndMagmaElements(b);
					for p in [1..Length(aCoeffList)/2] do
						for q in [1..Length(bCoeffList)/2] do
							aCoeff := aCoeffList[2*p - 1]; # in ComRing
							bCoeff := bCoeffList[2*q - 1]; # in ComRing
							aMonomial := aCoeffList[2*p]; # in ConicAlgMag
							bMonomial := bCoeffList[2*q]; # in ConicAlgMag
							if i1 <> j1 and Set([i1, j1]) = Set([i2, j2]) then
								Add(
									resultCoeffList,
									[ 
										ddCoeff*aCoeff*bCoeff,
										ConicAlgMagToAlg(aMonomial), 
										ConicAlgMagToAlg(bMonomial) 
									]
								);
							else
								Add(
									resultCoeffList,
									[
										ddCoeff*aCoeff*bCoeff,
									]
								);
							fi;
						od;
					od;
				fi;
			od;
		od;
	od;
	if SanitizeImmediately then
		DDSanitizeRep(resultCoeffList);
	fi;
	return DD(resultCoeffList);
end);

## ------- Root homomorphisms ----

DeclareOperation("DDRootHomA2", [IsList, IsRingElement]);

# root: A root in A_2.
# a: An element of ConicAlg.
# Output: The a-element in the root space of DD w.r.t root.
InstallMethod(DDRootHomA2, [IsList, IsRingElement], function(root, a)
    local i, j, l;
    ReqConicAlgEl(a);
    # The root space w.r.t. root is Z_{i \to j}
    i := Position(root, 1);
    j := Position(root, -1);
    l := Position(root, 0);
    return dd(CubicAlgElMat(i, l, One(ConicAlg)), CubicAlgElMat(l, j, a));
end);