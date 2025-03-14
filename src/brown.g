# The Brown algebra (ComRing, Cubic, Cubic, ComRing) to which L_{\pm 1} is isomorphic
BrownSpec := rec(
	ElementName := "BrownElement",
	Zero := a -> [Zero(ComRing), CubicZero, CubicZero, Zero(ComRing)],
	Addition := function(a, b)
		return a+b;
	end,
	AdditiveInverse := a -> -a,
	MathInfo := IsAdditivelyCommutativeElement
);
Brown := ArithmeticElementCreator(BrownSpec);
BrownZero := Brown(BrownSpec.Zero(fail));

BrownPart := function(brownEl, i)
	if i in [1,2,3,4] then
		return UnderlyingElement(brownEl)[i];
	else
		Error("Brown algebra element: Invalid position.");
		return fail;
	fi;
end;

BrownComPart := function(brownEl, i)
	if i = 1 then
		return BrownPart(brownEl, 1);
	elif i = 2 then
		return BrownPart(brownEl, 4);
	else
		Error("Brown algebra element: Invalid position (ComPart).");
	fi;
end;

BrownConicPart := function(brownEl, i)
	if i = 1 then
		return BrownPart(brownEl, 2);
	elif i = 2 then
		return BrownPart(brownEl, 3);
	else
		Error("Brown algebra element: Invalid position (ConicPart).");
	fi;
end;

# Scalar multiplication ComRing x Brown -> Brown
InstallMethod(\*, "for ComRingElement and CubicElement", [IsRingElement, IsCubicElement], function(comEl, brownEl)
	return Brown(comEl * UnderlyingElement(brownEl));
end);