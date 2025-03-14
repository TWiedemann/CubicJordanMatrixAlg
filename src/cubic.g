### Cubic norm structure

twistDiag := List([1,2,3], i -> comRingGamIndet(i));
cycPerm := [ [1,2,3], [2,3,1], [3,1,2] ]; # List of cyclic permutations of [1,2,3]

IsCubicEl := function(A)
	if IsList(A) and Length(A) = 3 then
		if IsList(A[1]) and Length(A[1]) = 3
			and IsList(A[2]) and Length(A[2]) = 3
			and IsList(A[3]) and Length(A[3]) = 3 then
			for i in [1..3] do
				for j in [1..3] do
					if i=j and not A[i][j] in ComRing then
						return false;
					elif i<>j and not A[i][j] in ConicAlg then
						return false;
					fi;
				od;
			od;
			return true;
		else
			return false;
		fi;
	else
		return false;
	fi;
end;

cubicComEl := function(i, t)
	local result, j;
	result := NullMat(3, 3, ConicAlg);
	for j in [1..3] do
		if j = i then
			result[j][j] := t;
		else
			result[j][j] := Zero(ComRing);
		fi;
	od;
	return result;
end;

cubicComElOne := function(i)
	return cubicComEl(i, One(ComRing));
end;

cubicAlgEl := function(i, j, a)
	local result, k, l;
	result := NullMat(3, 3, ComRing);
	for k in [1..3] do
		for l in [1..3] do
			if k <> l then
				result[k][l] := Zero(ConicAlg);
			fi;
		od;
	od;
	result[i][j] := twistDiag[j] * a;
	result[j][i] := twistDiag[i] * conicAlgInv(a);
	return result;
end;

cubicAlgElOne := function(i, j)
	return cubicAlgEl(i, j, One(ConicAlg));
end;

cubicZero := function()
	return cubicComEl(1, Zero(ComRing));
end;

cubicOne := function()
	return cubicComEl(1, One(ComRing)) + cubicComEl(2, One(ComRing)) + cubicComEl(3, One(ComRing));
end;

cubicEl := function(t11, t22, t33, a12, a13, a23)
	return cubicComEl(1, t11) + cubicComEl(2, t22) + cubicComEl(3, t33) + cubicAlgEl(1, 2, a12) + cubicAlgEl(1, 3, a13) + cubicAlgEl(2, 3, a23);
end;

cubicGenericElForIndets := function(i11, i22, i33, j12, j13, j23)
	if Maximum(i11, i22, i33) > comring_rank or Maximum(j12, j13, j23) > conicalg_rank then
		return fail;
	else
		return cubicEl(comRingBasicIndet(i11), comRingBasicIndet(i22), comRingBasicIndet(i33), conicAlgBasicIndet(j12), conicAlgBasicIndet(j13), conicAlgBasicIndet(j23));
	fi;
end;

# Returns generic element with indeterminate numbers 3*i+1, 3*i+2, 3*i+3
cubicGenericEl := function(i)
	if 3*i+3 > conicalg_rank or 3*i+3 > comring_rank then
		return fail;
	else
		return cubicEl(comRingBasicIndet(3*i+1), comRingBasicIndet(3*i+2), comRingBasicIndet(3*i+3), conicAlgBasicIndet(3*i+1), conicAlgBasicIndet(3*i+2), conicAlgBasicIndet(3*i+3));
	fi;
end;

cubicCoeff := function(A, i, j)
	if i = j then
		return A[i][i];
	else
		return twistDiag[j]^-1 * A[i][j];
	fi;
end;

cubicAlgCoeff := function(A, i)
	if i = 1 then
		return cubicCoeff(A, 2, 3);
	elif i = 2 then
		return cubicCoeff(A, 3, 1);
	elif i = 3 then
		return cubicCoeff(A, 1, 2);
	else
		return fail;
	fi;
end;

cubicComCoeff := function(A, i)
	return cubicCoeff(A, i, i);
end;

# A: An element of the cubic norm structure.
# Output: Zero(ComRing) if A is the zero element. Otherwise returns a non-zero coefficient of A (which lies either in ConicAlg or in ComRing).
# This will be used to determine whether an element of the Brown algebra lies in a root space.
cubicGetNonTrivCoeff := function(A)
	local i, j;
	for i in [1..3] do
		for j in [i..3] do
			if A[i][j] <> Zero(ComRing) and A[i][j] <> Zero(ConicAlg) then
				return A[i][j];
			fi;
		od;
	od;
	return Zero(ComRing);
end;

## ----- Structural maps of a cubic norm structure ------

cubicNorm := function(A)
	local sum, perm, i, j, l;
	sum := cubicComCoeff(A, 1) * cubicComCoeff(A, 2) * cubicComCoeff(A, 3)
		+ twistDiag[1] * twistDiag[2] * twistDiag[3] * conicAlgTr(cubicAlgCoeff(A, 1)*cubicAlgCoeff(A, 2)*cubicAlgCoeff(A, 3));
	for perm in cycPerm do
		i := perm[1];
		j := perm[2];
		l := perm[3];
		sum := sum - cubicComCoeff(A, i) * twistDiag[j] * twistDiag[l] * conicAlgNorm(cubicAlgCoeff(A, i));
	od;
	return sum;
end;

cubicAdj := function(A)
	local result, perm, i, j, l, a_i, a_j, a_l, A_i, A_j, A_l, comEl, algEl;
	result := cubicZero();
	for perm in cycPerm do
		i := perm[1];
		j := perm[2];
		l := perm[3];
		a_i := cubicAlgCoeff(A, i);
		a_j := cubicAlgCoeff(A, j);
		a_l := cubicAlgCoeff(A, l);
		A_i := cubicComCoeff(A, i);
		A_j := cubicComCoeff(A, j);
		A_l := cubicComCoeff(A, l);
		comEl := A_j*A_l - twistDiag[j]*twistDiag[l]*conicAlgNorm(a_i);
		result := result + cubicComEl(i, comEl);
		algEl := -A_i*a_i + twistDiag[i] * conicAlgInv(a_j*a_l);
		result := result + cubicAlgEl(j, l, algEl);
	od;
	return result;
end;

cubicCross := function(A, B)
	local result, perm, i, j, l, a_i, a_j, a_l, b_i, b_j, b_l, A_i, A_j, A_l, B_i, B_j, B_l, comEl, algEl;
	result := cubicZero();
	for perm in cycPerm do
		i := perm[1];
		j := perm[2];
		l := perm[3];
		a_i := cubicAlgCoeff(A, i);
		a_j := cubicAlgCoeff(A, j);
		a_l := cubicAlgCoeff(A, l);
		b_i := cubicAlgCoeff(B, i);
		b_j := cubicAlgCoeff(B, j);
		b_l := cubicAlgCoeff(B, l);
		A_i := cubicComCoeff(A, i);
		A_j := cubicComCoeff(A, j);
		A_l := cubicComCoeff(A, l);
		B_i := cubicComCoeff(B, i);
		B_j := cubicComCoeff(B, j);
		B_l := cubicComCoeff(B, l);
		comEl := A_j*B_l + B_j*A_l - twistDiag[j]*twistDiag[l]*conicAlgBiTr(a_i, b_i);
		result := result + cubicComEl(i, comEl);
		algEl := -A_i*b_i - B_i*a_i + twistDiag[i]*conicAlgInv(a_j*b_l + b_j*a_l);
		result := result + cubicAlgEl(j, l, algEl);
	od;
	return result;
end;

cubicTr := function(A, B)
	local result, i, j, l, perm;
	result := Zero(ComRing);
	for perm in cycPerm do
		i := perm[1];
		j := perm[2];
		l := perm[3];
		result := result + cubicComCoeff(A, i)*cubicComCoeff(B, i) + twistDiag[j]*twistDiag[l] * conicAlgBiTr(cubicAlgCoeff(A, i), cubicAlgCoeff(B, i));
	od;
	return result;
end;

## ------- Structural maps of the corresponding Jordan algebra ----

jordanU := function(a, b)
	return cubicTr(a,b)*a -cubicCross(cubicAdj(a), b);
end;

jordanULin := function(a,b,c)
	return cubicTr(a, c)*b + cubicTr(b, c)*a - cubicCross(cubicCross(a,b), c);
end;

jordanD := function(a,b,c)
	return jordanULin(a,c,b);
end;
