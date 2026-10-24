# Documentation for AssignGeneratorVariables is in conic.g because this operation
# is already declared in the GAP library, and hence need not (in fact, should not)
# be declared in this file

#! @BeginGroup ConicAlgebra
#! @ChapterInfo Conic, Conic-Const
#! @Description
#! The first variant creates a new (free) conic algebra object <C>C</C>
#! on <C>conicRank</C> generators
#! over a commutative ring with <C>comRingRank</C> generators.
#! For all products <C>d</C> of length at most <C>maxTrLength</C> of generators
#! of the conic algebra, the symbol <C>tr(d)</C> is initialised
#! during the construction of <C>C</C>.
#! This guarantees that an element of <C>C</C> in which no traces of products
#! of higher length appear is always printed in the same way.
#! The printing of elements containing traces of products of higher length,
#! on the other hand, may depend on the order in which these traces have appeared
#! in the current GAP session.<P/>
#! The record <C>nameRec</C> may contain the following entries:
#! * <C>comSym</C>: The symbol used for the generators in the commutative base ring, which are named <C>comSym1, comSym2, ...</C>. Default: <C>t</C>.
#! * <C>conicSym</C>: The symbol used for the generators in the conic algebra, which are named <C>conicSym1, conicSym2, ...</C>. Default: <C>a</C>.
#! * <C>zeroSym</C>: The symbol used for the zero element of the conic algebra. Default: <C>0_C</C>.
#! * <C>oneSym</C>: The symbol used for the one element of the conic algebra. Default: <C>1_C</C>.
#! There are several variants of <C>ConicAlgebra</C> which use default values for the
#! omitted arguments. The default value for <C>maxTrLength</C> is <C>4</C>. <P/>
#! For an element <C>a</C> of a conic algebra, <C>ConicAlgebra(a)</C> is the (full) conic algebra
#! containing <C>a</C>.
#! @Arguments comRingRank, conicRank, maxTrLength, nameRec
DeclareOperation("ConicAlgebra", [IsInt, IsInt, IsInt, IsRecord]);
#! @Arguments comRingRank, conicRank, maxTrLength, comSym, conicSym
DeclareOperation("ConicAlgebra", [IsInt, IsInt, IsInt, IsString, IsString]);
#! @Arguments comRingRank, conicRank, maxTrLength
DeclareOperation("ConicAlgebra", [IsInt, IsInt, IsInt]);
#! @Arguments comRingRank, conicRank
DeclareOperation("ConicAlgebra", [IsInt, IsInt]);
#! @Arguments a
DeclareOperation("ConicAlgebra", [IsObject]); # For conic algebra of an element (of Cubic, Lie, ConicAlg, ...)
#! @EndGroup ConicAlgebra


#! @Arguments C, p
#! @Description
#! Returns the <C>p</C>-th indeterminate in <C>C</C>. We must have
#! <C>1 &lt;= p &lt;= ConicRank(C)</C>.
#! @ChapterInfo Conic, Conic-Const
DeclareOperation("ConicAlgIndet", [ IsFreeMagmaRing, IsInt ]);

DeclareOperation("ConicAlgInvIndet", [ IsFreeMagmaRing, IsInt ]);

DeclareOperation("ConicAlgInv", [ IsElementOfFreeMagmaRing ]);

#! @BeginGroup ConicInv
#! @ChapterInfo Conic, Conic-Maps
#! @Description
#! Returns the conjugate of <C>a</C>.
#! If <C>a</C> is a generator of the conic algebra in which it is contained,
#! then its conjugate is printed as <C>a'</C>.
#! <C>ConicInv</C> and <C>ConicConj</C> are different names for the same function.
#! @Arguments a
DeclareOperation("ConicInv", [ IsObject ]);
#! @Arguments a
DeclareOperation("ConicConj", [ IsObject ]);
#! @EndGroup ConicInv

#! @Arguments a
#! @Description
#! Returns the norm of <C>a</C>.
#! If <C>a</C> is a generator of the conic algebra in which it is contained,
#! then its norm is printed as <C>n(a)</C>.
#! @ChapterInfo Conic, Conic-Maps
DeclareOperation("ConicNorm", [ IsObject ]);

#! @Arguments a, b
#! @Description
#! Returns <C>tr(a'b)</C>, which is known to be the same as <C>n(a+b)-n(a)-n(b)</C>.
#! Thus <C>ConicNormLin</C> is the linearisation of <C>ConicNorm</C>.
#! @ChapterInfo Conic, Conic-Maps
DeclareOperation("ConicNormLin", [ IsObject, IsObject ]);

#! @Arguments a
#! @Description
#! Returns the trace of <C>a</C>.
#! If <C>a</C> is a generator of the conic algebra in which it is contained,
#! then its trace is printed as <C>tr(a)</C>.
#! Several measures are taken to simplify (the display of) traces:
#! * Multiplication signs in the argument of the trace are not printed: For <C>a=a1*a2</C>, the trace of <C>a</C> is printed as <C>tr(a1a2)</C>
#! * By the relation <C>tr((ab)c) = tr(a(bc))</C>, we can omit brackets in products of length at most 3, so the result of <C>ConicTr((a1*a2)*a3)</C> is printed as <C>tr(a1a2a3)</C>.
#! * Using in addition the relations <C>tr(a') = tr(a)</C> and <C>tr(ab) = tr(ba)</C>, the arguments of the trace are often permuted and/or replaced by their conjugates to ensure proper cancellation of terms. For example, both <C>ConicTr(a1*ConicInv(a2))</C> and <C>ConicTr(ConicInv(a1)*a2)</C> evaluate to <C>tr(a1a2')</C>, and <C>ConicTr(ConicInv(a1)*a2*a3)</C> evaluates to <C>tr(a1a3'a2')</C> (which is correct because <C>tr(a1'a2a3) = tr((a1'a2a3)') = tr(a3'a2'a1) = tr(a1a3'a2')</C>).
#! @ChapterInfo Conic, Conic-Maps
DeclareOperation("ConicTr", [ IsObject ]);

DeclareOperation("ConicAlgMagma", [IsInt]);
DeclareOperation("ConicAlgMagma", [IsInt, IsString]);
DeclareOperation("ConicAlgMagma", [IsInt, IsString, IsString, IsString]);
DeclareOperation("ConicAlgMagma", [IsNonassocWord]);
DeclareOperation("ConicAlgMagma", [IsFreeMagmaRing]);
DeclareOperation("ConicAlgMagEmbedding", [IsFreeMagmaRing]);

#! @Arguments C
#! @Description
#! Since GAP does not support function fields (or polynomial rings) over infinitely many indeterminates,
#! it is not possible to return a commutative ring containing all symbols <C>tr(d)</C>
#! for all monomials <C>d</C> in <C>C</C> of arbitrary length.
#! Instead, this function returns the function field over the integers over the finitely many
#! indeterminates which were initialised during the construction of <C>C</C>.
#! In particular, for elements <C>tr(d)</C> where d is a product in <C>C</C>
#! of sufficiently high length, the expression <C>tr(d) in ComRingOfConicAlg(C)</C>
#! is <C>false</C>. Thus the user should not rely on this ring to be the full
#! coeficient ring. However, it may be safely used to access
#! <C>Zero(ComRingOfConicAlg(C))</C> and <C>One(ComRingOfConicAlg(C))</C>.
#! @ChapterInfo Conic, Conic-Stored
DeclareOperation("ComRingOfConicAlg", [IsFreeMagmaRing]);

#! @Arguments C
#! @Description
#! Returns the parameter <C>maxTrLength</C> that was specified during the
#! construction of <C>C</C>.
#! @ChapterInfo Conic, Conic-Stored
DeclareOperation("ConicAlgMaxTrLength", [IsFreeMagmaRing]);

#! @Arguments C
#! @ChapterInfo Conic, Conic-Stored
#! @Description
#! Returns the argument <C>conicRank</C> that was specified during the creation
#! of <C>C</C>.
DeclareOperation("ConicRank", [ IsObject ]);
#! @Arguments C
#! @Description
#! Returns the argument <C>conicSym</C> that was specified during the creation
#! of <C>C</C>, that is, the name given to the generators of <C>C</C>.
#! @ChapterInfo Conic, Conic-Stored
DeclareOperation("ConicIndetName", [ IsObject ]);
#! @Arguments C
#! @Description
#! Returns the argument <C>comRingRank</C> that was specified during the creation
#! of <C>C</C>, that is, the number of independent elements of <C>ComRingOfConicAlg(C)</C>.
#! @ChapterInfo Conic, Conic-Stored
DeclareOperation("ComRingRank", [ IsObject ]);
#! @Arguments C
#! @ChapterInfo Conic, Conic-Stored
#! @Description
#! Returns the argument <C>comSym</C> that was specified during the creation
#! of <C>C</C>.
DeclareOperation("ComRingIndetName", [ IsObject ]);

DeclareOperation("ReqComRingEl", [IsRingElement]);
DeclareOperation("ReqComRingEl", [IsList]);
DeclareOperation("ReqConicAlgEl", [IsRingElement]);
DeclareOperation("ReqConicAlgEl", [IsList]);