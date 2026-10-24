### ----- The commutative ring k -----

#! @Arguments C, p
#! @Description
#! Returns the <C>p</C>-th indeterminate in the base ring of <C>C</C>, which is printed as <C>tp</C>.
#! We must have <C>1 &lt;= p &lt;= ComRingRank(C)</C>.
#! @ChapterInfo Conic, Conic-ComRing
DeclareOperation("ComRingIndet", [ IsRing, IsInt ]);

DeclareOperation("ComRingIndet", [ IsString, IsInt ]);

#! @Arguments i
#! @Description
#! Returns the <C>i</C>-th element of $\Gamma = (\gamma_1, \gamma_2, \gamma_3)$.
#! These are the (arbitrarily chosen, but fixed) constants that appear
#! in the definition of cubic Jordan matrix algebras.
#! They are printed as <C>g1, g2, g3</C>.
#! If the package was initialised with <C>userVars = true</C>,
#! then GAP variables <C>g1 := ComRingGamIndet(1), ...</C> are defined.
#! @ChapterInfo Conic, Conic-ComRing
DeclareOperation("ComRingGamIndet", [ IsInt ]);

# ----- The conic algebra C -----

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
#! Returns the conjugate of <C>a</C>. This is an element of $C$ which is printed as <C>a'</C>.
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
#! Returns <C>ntr(a'b</C>, which is known to be the same as <C>(a+b)-n(a)-n(b)</C>.
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
#! Since GAP does not support function fields over infinitely many indeterminates,
#! it is not possible to return the full base ring of the magma ring <C>C</C>.
#! This function returns the function field over the integers over the finitely many
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
#! @Description
#! Returns the argument <C>conicRank</C> that was specified during the creation
#! of <C>C</C>, that is, the number of independent elements of <C>C</C>.
#! @ChapterInfo Conic, Conic-Stored
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
#! @Description
#! Returns the argument <C>comSym</C> that was specified during the creation
#! of <C>C</C>, that is, the name given to the generators of <C>C</C>.
#! @ChapterInfo Conic, Conic-Stored
DeclareOperation("ComRingIndetName", [ IsObject ]);

DeclareOperation("ReqComRingEl", [IsRingElement]);
DeclareOperation("ReqComRingEl", [IsList]);
DeclareOperation("ReqConicAlgEl", [IsRingElement]);
DeclareOperation("ReqConicAlgEl", [IsList]);

# ----- The cubic Jordan matrix algebra `Cubic` -----

#! @Arguments a, i
#! @Description
#! Returns <C>a[jl]</C> where <C>[i,j,l]</C> is the unique cyclic permutation of <C>[1,2,3]</C>
#! starting from <C>i</C>.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicConicEl", [ IsRingElement, IsObject ]);

#! @Arguments t, i
#! @Description
#! Returns the element of $J$ which is denoted by $te_i$ in [DMW]. It is printed as
#! <C>t[ii]</C>.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicComEl", [ IsFreeMagmaRing, IsRingElement, IsObject ]);

#! @Arguments z, i, j
#! @Description
#! Returns <C>z[ij]</C>. Thus <C>z</C> must lie in $k$ if <C>i=j</C> and in $C$ otherwise.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicEl", [ IsFreeMagmaRing, IsRingElement, IsInt, IsInt ]);

#! @Arguments t, s, r, a, b, c
#! @Description
#! Returns <C>t[11] + s[22] + r[33] + a[23] + b[31] + c[12]</C>.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicElFromTuple",
	[ IsRingElement, IsRingElement, IsRingElement,
        IsElementOfFreeMagmaRing, IsElementOfFreeMagmaRing, IsElementOfFreeMagmaRing ]);

#! @Arguments C
#! @Description
#! Returns the zero element of the conic algebra over <C>C</C>
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicZero", [ IsFreeMagmaRing ]);

#! @Arguments cub, i
#! @Description
#! Returns the corresponding component of <C>cub</C>. For example, for <C>cub = t[11] + s[22] +
#! r[33] + a[23] + b[31] + c[12]</C>, we have <C>CubicConicPart(cub, 1) = a</C> and
#! <C>CubicComPart(cub, 2) = s</C>.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicConicPart", [ IsObject, IsObject ]);

#! @Arguments cub, i
#! @Description
#! Returns the corresponding component of <C>cub</C>. For example, for <C>cub = t[11] + s[22] +
#! r[33] + a[23] + b[31] + c[12]</C>, we have <C>CubicConicPart(cub, 1) = a</C> and
#! <C>CubicComPart(cub, 2) = s</C>.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicComPart", [ IsObject, IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the norm of <C>cub</C>, which is an element of $k$.
#! @ChapterInfo CJMA, CJMA-CNS
DeclareOperation("CubicNorm", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the adjoint $\text{cub}^\sharp$ of <C>cub</C>, which is an element of $J$.
#! @ChapterInfo CJMA, CJMA-CNS
DeclareOperation("CubicAdj", [ IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the bilinear trace $T(\text{cub1}, \text{cub2})$ of <C>cub1</C>, <C>cub2</C>, which
#! is an element of $k$.
#! @ChapterInfo CJMA, CJMA-CNS
DeclareOperation("CubicBiTr", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns $\text{cub1} \times \text{cub2}$, which is an element of $J$.
#! @ChapterInfo CJMA, CJMA-CNS
DeclareOperation("CubicCross", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns $U_{\text{cub1}}(\text{cub2})$, which is an element of $J$.
#! @ChapterInfo CJMA, CJMA-Jordan
DeclareOperation("JordanU", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2, cub3
#! @Description
#! Returns $U_{\text{cub1},\text{cub2}}(\text{cub3})=U_{\text{cub1}+\text{cub2}}(\text{cub3}) -
#! U_{\text{cub1}}(\text{cub3}) - U_{\text{cub2}}(\text{cub3})$, which is an element of $J$.
#! @ChapterInfo CJMA, CJMA-Jordan
DeclareOperation("JordanULin", [ IsObject, IsObject, IsObject ]);

#! @Arguments cub1, cub2, cub3
#! @Description
#! Returns $D_{\text{cub1}, \text{cub2}}(\text{cub3}) = \{\text{cub1}, \text{cub2},
#! \text{cub3}\} = U_{\text{cub1}, \text{cub3}}(\text{cub2})$, which is an element of $J$.
#! @ChapterInfo CJMA, CJMA-Jordan
DeclareOperation("JordanD", [ IsObject, IsObject, IsObject ]);

# ----- The Brown algebra `Brown` -----

#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[ t, cub1, cub2, s ]</C> of $B$.
#! @ChapterInfo Lie, Lie-Brown
DeclareOperation("BrownEl", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments brown
#! @Description
#! Returns the GAP list <C>[ t, cub1, cub2, s ]</C> underlying <C>brown</C>.
#! @ChapterInfo Lie, Lie-Brown
DeclareOperation("BrownElTuple", [ IsObject ]);

#! @Arguments brown, p
#! @Description
#! Returns the <C>p</C>-th entry of the list underlying <C>brown</C>, where <C>1 &lt;= p &lt;=
#! 4</C>.
#! @ChapterInfo Lie, Lie-Brown
DeclareOperation("BrownElPart", [ IsObject, IsObject ]);

#! @Arguments brown, p
#! @Description
#! Returns <C>BrownElPart(brown, 1)</C> for <C>p=1</C> and <C>BrownElPart(brown, 4)</C> for
#! <C>p=2</C>.
#! @ChapterInfo Lie, Lie-Brown
DeclareOperation("BrownElComPart", [ IsObject, IsObject ]);

#! @Arguments brown, p
#! @Description
#! Returns <C>BrownElPart(brown, 2)</C> for <C>p=1</C> and <C>BrownElPart(brown, 3)</C> for
#! <C>p=2</C>.
#! @ChapterInfo Lie, Lie-Brown
DeclareOperation("BrownElCubicPart", [ IsObject, IsObject ]);

# ----- The Lie algebra `Lie` -----

#! @Arguments lie, p
#! @Description
#! Returns the projection of <C>lie</C> to $L_p$ where <C>-2 &lt;= p &lt;= 2</C>. This is an
#! element of $k$ if $p = \pm 2$, and element of $B$ if $p = \pm 1$ and an element of $L_0$
#! if $p=0$.
#! @ChapterInfo Lie, Lie-5Grad
DeclareOperation("LiePart", [ IsObject, IsObject ]);

#! @Arguments brown
#! @Description
#! Returns the element <C>brown_+</C> of $L_1$ or <C>brown_-</C> of $L_{-1}$, respectively.
#! @ChapterInfo Lie, Lie-1
DeclareOperation("BrownPosToLieEmb", [ IsObject ]);

#! @Arguments brown
#! @Description
#! Returns the element <C>brown_+</C> of $L_1$ or <C>brown_-</C> of $L_{-1}$, respectively.
#! @ChapterInfo Lie, Lie-1
DeclareOperation("BrownNegToLieEmb", [ IsObject ]);

#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[t, cub1, cub2, s]_+</C> of $L_1$ or <C>[t, cub1, cub2, s]_-</C> of
#! $L_{-1}$, respectively.
#! @ChapterInfo Lie, Lie-1
DeclareOperation("BrownPosEl", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[t, cub1, cub2, s]_+</C> of $L_1$ or <C>[t, cub1, cub2, s]_-</C> of
#! $L_{-1}$, respectively.
#! @ChapterInfo Lie, Lie-1
DeclareOperation("BrownNegEl", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments l0
#! @Description
#! Returns the embedding of <C>l0</C> into $L$.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0ToLieEmb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L_0$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("CubicPosToL0Emb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L_0$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("CubicNegToL0Emb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("CubicPosToLieEmb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("CubicNegToLieEmb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! These are alternative names for <C>CubicPosToLieEmb</C> and <C>CubicNegToLieEmb</C>.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("adPos", [ IsObject ]);

#! @Arguments cub
#! @Description
#! These are alternative names for <C>CubicPosToLieEmb</C> and <C>CubicNegToLieEmb</C>.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("adNeg", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns the projection of <C>l0</C> onto $L_{0,1}$ or $L_{0,-1}$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0CubicPosPart", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns the projection of <C>l0</C> onto $L_{0,1}$ or $L_{0,-1}$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0CubicNegPart", [ IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>. If the package was initialised with <C>userVars = true</C>, then
#! the shortcut <C>dd := Liedd</C> is defined.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("DDdd", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>. If the package was initialised with <C>userVars = true</C>, then
#! the shortcut <C>dd := Liedd</C> is defined.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0dd", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>. If the package was initialised with <C>userVars = true</C>, then
#! the shortcut <C>dd := Liedd</C> is defined.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("Liedd", [ IsObject, IsObject ]);

#! @Arguments ddEl
#! @Description
#! Returns the embedding of <C>ddEl</C> into $L_0$ or $L$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("DDToL0Emb", [ IsObject ]);
DeclareOperation("DDToL0Emb", [ IsFreeMagmaRing, IsObject ]);

#! @Arguments ddEl
#! @Description
#! Returns the embedding of <C>ddEl</C> into $L_0$ or $L$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("DDToLieEmb", [ IsObject ]);
DeclareOperation("DDToLieEmb", [ IsFreeMagmaRing, IsObject ]);

#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0DDPart", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0XiPart", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0ZetaPart", [ IsObject ]);

#! @Arguments F4Root
#! @Description
#! Returns the image of <C>F4Root</C> under the surjection $\pi: F_4 \to G_2 \cup \{0\}$
#! described in [DMW, 10.24].
#! @ChapterInfo Lie, Lie-Root
DeclareOperation("F4RootG2Coord", [ IsObject ]);

#! @Arguments F4Root1, F4Root2
#! @Description
#! Returns $\text{F4Root1}^{\sigma(\text{F4Root2})}$, the image of <C>F4Root1</C>
#! under the reflection along the hyperplane orthogonal to <C>F4Root2</C>.
#! @ChapterInfo Lie, Lie-Root
DeclareOperation("F4Refl", [ IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the element $\vartheta_\alpha(z)$ of $L$ as defined in [DMW, 10.29]. Thus <C>z</C>
#! must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Root
DeclareOperation("LieRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the element $\vartheta_\alpha(z)$ of $L$ as defined in [DMW, 10.29]. Thus <C>z</C>
#! must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Root
DeclareOperation("LieRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject ]);

# ----- The automorphisms of `Lie` -----

#! @Description
#! The identity element in the automorphism group of the Lie algebra over a conic algebra.
#! It is the same for any conic algebra.
#! @ChapterInfo Lie, Lie-Auto
DeclareGlobalName("LieEndoOne");

#! @Arguments F4Root, z
#! @Description
#! Returns the automorphism $\theta_\alpha(a)$ of $L$ in <C>LieEndo</C> as defined in
#! [DMW, 11.2, 11.8]. Thus <C>z</C> must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Auto
DeclareOperation("GrpRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the automorphism $\theta_\alpha(a)$ of $L$ in <C>LieEndo</C> as defined in
#! [DMW, 11.2, 11.8]. Thus <C>z</C> must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Auto
DeclareOperation("GrpRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject ]);

#! @Arguments F4Root
#! @Description
#! Returns the Weyl element $w_\alpha = \theta_{-\alpha}(-1) \theta_\alpha(1)
#! \theta_{-\alpha}(-1)$ in <C>LieEndo</C>.
#! @ChapterInfo Lie, Lie-Auto
DeclareOperation("GrpStandardWeylF4", [ IsFreeMagmaRing, IsList ]);

# Variant with additional sign. Not part of the main interface.
DeclareOperation("GrpStandardWeylF4", [ IsFreeMagmaRing, IsList, IsInt ]);

# ----- Simplifcation and equality tests -----

DeclareOperation("Simplify", [ IsFreeMagmaRing, IsObject ]);
#! @Arguments u
#! @Description
#! Returns an element of the parent structure of <C>u</C> (that is, of $k$, $C$, $B$,
#! <C>DD</C>, $L_0$ or $L$) which is mathematically equivalent to <C>u</C>. Usually the
#! internal representation of <C>Simplify(u)</C> is "easier"/"shorter"/"more canonical" than
#! that of <C>u</C>. Thus to check whether <C>u = v</C>, one should check whether
#! <C>Simplify(u-v)</C> equals zero. If this is true, then <C>u</C> and <C>v</C> represent
#! the same element. If not, then they might still represent the same element, and we can
#! try to prove this by hand by showing that <C>Simplify(u-v)</C> represents 0 (which is
#! usually easier than showing that <C>u-v</C> represents 0). The function <C>Simplify</C>
#! relies on several subroutines which can be studied in detail in <C>gap/simplify.g</C>.
#! For Lie algebra elements, we also provide the following function.
#! @ChapterInfo Simplify, Simplify-Test
DeclareOperation("Simplify", [ IsObject ]);

# For IsLieElement
DeclareOperation("TestEquality", [ IsObject, IsObject, IsBool ]);
DeclareOperation("TestEquality", [ IsObject, IsObject ]);

#! @Description
#! Returns <C>true</C> if <C>lie1</C>, <C>lie2</C> can be proven to represent the same elements
#! using the techniques outlined above, and <C>false</C> otherwise. If the optional argument
#! <C>print</C> is supplied and <C>true</C>, then in addition, simplifications of all
#! non-zero components of <C>lie1-lie2</C> in $L_{-2}, \dots, L_2$ are printed. Returns
#! <C>true</C> if <C>TestEquality(g(gen), h(gen))</C> is <C>true</C> for all <C>gen</C> in a
#! certain list of Lie algebra generators of $L$. Otherwise returns the list of all lists
#! <C>[gen, Simplify(g(gen) - h(gen))]</C> for any <C>gen</C> for which the test was not
#! successfull. The list of all generators <C>gen</C> on which we test equality is obtained
#! by evaluating all root homomorphisms with image in $L_{-2} + L_1$ on the last
#! indeterminate in $k$ or $C$ (that is, on the last generators of the base ring or
#! <C>C</C>). The user should assure that these indeterminates do
#! not occur in the definition of <C>g</C> and <C>h</C>.
#! @ChapterInfo Simplify, Simplify-Test
DeclareOperation("TestEquality", [ IsFreeMagmaRing, IsObject, IsObject, IsObject ]);

#! @Description
#! Returns <C>true</C> if <C>lie1</C>, <C>lie2</C> can be proven to represent the same elements
#! using the techniques outlined above, and <C>false</C> otherwise. If the optional argument
#! <C>print</C> is supplied and <C>true</C>, then in addition, simplifications of all
#! non-zero components of <C>lie1-lie2</C> in $L_{-2}, \dots, L_2$ are printed. Returns
#! <C>true</C> if <C>TestEquality(g(gen), h(gen))</C> is <C>true</C> for all <C>gen</C> in a
#! certain list of Lie algebra generators of $L$. Otherwise returns the list of all lists
#! <C>[gen, Simplify(g(gen) - h(gen))]</C> for any <C>gen</C> for which the test was not
#! successfull. The list of all generators <C>gen</C> on which we test equality is obtained
#! by evaluating all root homomorphisms with image in $L_{-2} + L_1$ on the last
#! indeterminate in $k$ or $C$ (that is, on the last generators of the base ring or
#! <C>C</C>). The user should assure that these indeterminates do
#! not occur in the definition of <C>g</C> and <C>h</C>.
#! @ChapterInfo Simplify, Simplify-Test
DeclareOperation("TestEquality", [ IsFreeMagmaRing, IsObject, IsObject ]);

#! @Arguments g, h
#! @Description
#! Returns <C>true</C> in the same situations as <C>TestEquality</C>. Otherwise the output is a
#! list of all non-zero "pieces" of all "error terms" <C>Simplify(g(gen) - h(gen))</C> that
#! arise during the test. By "pieces" we mean the underlying elements of $k$, $C$ and $L_0$
#! that make up the error terms. Thus to prove that <C>g</C> and <C>h</C> are the same, it
#! suffices to prove that all elements in the output list represent 0. As for
#! <C>TestEquality</C>, the user should assure that the final indeterminates of the coefficient
#! ring or <C>C</C> do not occur in the definition of <C>g</C> and
#! <C>h</C>.
#! @ChapterInfo Simplify, Simplify-Test
DeclareOperation("TestEqualityPieces", [ IsFreeMagmaRing, IsObject, IsObject ]);
