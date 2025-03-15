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

## Getters for components

DeclareOperation(BrownElTuple, [IsBrownElement]);
DeclareOperation(BrownElPart, [IsBrownElement, IsInteger]);
DeclareOperation(BrownElComPart, [IsBrownElement, IsInteger]);
DeclareOperation(BrownElConicPart, [IsBrownElement, IsInteger]);

# Output: List [a, b, c, d] of the entries of brownEl
InstallMethod(BrownElTuple, [IsBrownElement], function(brownEl)
	return UnderlyingElement(brownEl);
end);

InstallMethod(BrownElPart, [IsBrownElement, IsInteger], function(brownEl, i)
	if i in [1,2,3,4] then
		return UnderlyingElement(brownEl)[i];
	else
		Error("Brown algebra element: Invalid position.");
		return fail;
	fi;
end);

InstallMethod(BrownElComPart, [IsBrownElement, IsInteger], function(brownEl, i)
	if i = 1 then
		return BrownElPart(brownEl, 1);
	elif i = 2 then
		return BrownElPart(brownEl, 4);
	else
		Error("Brown algebra element: Invalid position (ComPart).");
	fi;
end);

InstallMethod(BrownElConicPart, [IsBrownElement, IsInteger], function(brownEl, i)
	if i = 1 then
		return BrownElPart(brownEl, 2);
	elif i = 2 then
		return BrownElPart(brownEl, 3);
	else
		Error("Brown algebra element: Invalid position (ConicPart).");
	fi;
end);

# Scalar multiplication ComRing x Brown -> Brown
InstallMethod(\*, "for ComRingElement and CubicElement", [IsRingElement, IsCubicElement], function(comEl, brownEl)
	return Brown(comEl * UnderlyingElement(brownEl));
end);