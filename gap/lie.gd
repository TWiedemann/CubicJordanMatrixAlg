# ----- The 5-grading -----

#! @Arguments lie, p
#! @Description
#! Returns the projection of <C>lie</C> to $L_p$ where <C>-2 &lt;= p &lt;= 2</C>. This is an
#! element of $k$ if $p = \pm 2$, and element of $B$ if $p = \pm 1$ and an element of $L_0$
#! if $p=0$.
#! @ChapterInfo Lie, Lie-5Grad
DeclareOperation("LiePart", [ IsObject, IsObject ]);

#! @BeginGroup
#! @ChapterInfo Lie, Lie-5Grad
#! @GroupTitle LieZero and L0Zero
#! @Arguments C
#! @Description
#! Returns the zero element of $L$ or $L_0$, respectively.
DeclareOperation("LieZero", [IsFreeMagmaRing]);
#! @Arguments C
DeclareOperation("L0Zero", [IsFreeMagmaRing]);
#! @EndGroup

# ----- The components L_2 and L_{-2} -----

#! @BeginGroup
#! @Arguments C
#! @ChapterInfo Lie, Lie-2
#! @GroupTitle LieX and LieY
#! @Description
#! Returns the "canonical" generators of the $k$-module $L_{-2}$ and $L_2$,
#! which are isomorphic
#! to $k$. They are printed as <C>x</C> and <C>y</C>, respectively.
DeclareOperation("LieX", [IsFreeMagmaRing]);
#! @Arguments C
DeclareOperation("LieY", [IsFreeMagmaRing]);
#! @EndGroup

# ----- The components L_1 and L_{-1} -----

#! @BeginGroup
#! @ChapterInfo Lie, Lie-1
#! @GroupTitle BrownPosToLieEmb and BrownNegToLieEmb
#! @Arguments brown
#! @Description
#! Returns the element <C>brown_+</C> of $L_1$ or <C>brown_-</C> of $L_{-1}$, respectively.
DeclareOperation("BrownPosToLieEmb", [ IsObject ]);
#! @Arguments brown
DeclareOperation("BrownNegToLieEmb", [ IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Lie, Lie-1
#! @GroupTitle BrownPosEl and BrownNegEl
#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[t, cub1, cub2, s]_+</C> of $L_1$ or <C>[t, cub1, cub2, s]_-</C> of
#! $L_{-1}$, respectively.
DeclareOperation("BrownPosEl", [ IsObject, IsObject, IsObject, IsObject ]);
#! @Arguments t, cub1, cub2, s
DeclareOperation("BrownNegEl", [ IsObject, IsObject, IsObject, IsObject ]);
#! @EndGroup

# ----- The component L_0 -----

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle LieXi, LieZeta, L0Xi and L0Zeta
#! @Description
#! Returns the elements $\xi$ and $\zeta$ of $L$ or $L_0$, respectively.
#! They are printed as <C>xi</C> and <C>zeta</C>, respectively.
#! @Arguments C
DeclareOperation("LieXi", [IsFreeMagmaRing]);
#! @Arguments C
DeclareOperation("LieZeta", [IsFreeMagmaRing]);
#! @Arguments C
DeclareOperation("L0Xi", [IsFreeMagmaRing]);
#! @Arguments C
DeclareOperation("L0Zeta", [IsFreeMagmaRing]);
#! @EndGroup

#! @Arguments l0
#! @Description
#! Returns the image of <C>l0</C> into $L$.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0ToLieEmb", [ IsObject ]);

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle CubicPosToL0Emb, CubicNegToL0Emb, CubicPosToLieEmb and CubicNegToLie
#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L_0$ and $L$, respectively.
DeclareOperation("CubicPosToL0Emb", [ IsObject ]);
#! @Arguments cub
DeclareOperation("CubicNegToL0Emb", [ IsObject ]);
#! @Arguments cub
DeclareOperation("CubicPosToLieEmb", [ IsObject ]);
#! @Arguments cub
DeclareOperation("CubicNegToLieEmb", [ IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle adPos and adNeg
#! @Arguments cub
#! @Description
#! These are alternative names for <C>CubicPosToLieEmb</C> and <C>CubicNegToLieEmb</C>.
DeclareOperation("adPos", [ IsObject ]);
#! @Arguments cub
DeclareOperation("adNeg", [ IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle L0CubicPosPart and L0CubicNegPart
#! @Arguments l0
#! @Description
#! Returns the projection of <C>l0</C> onto $L_{0,1}$ or $L_{0,-1}$, respectively.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0CubicPosPart", [ IsObject ]);
#! @Arguments l0
DeclareOperation("L0CubicNegPart", [ IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle DDdd, L0dd and Liedd
#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("DDdd", [ IsObject, IsObject ]);
#! @Arguments cub1, cub2
DeclareOperation("L0dd", [ IsObject, IsObject ]);
#! @Arguments cub1, cub2
DeclareOperation("Liedd", [ IsObject, IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle DDToL0Emb and DDToLieEmb
#! @Arguments ddEl
#! @Description
#! Returns the image of <C>ddEl</C> in $L_0$ or $L$, respectively.
#! The argument <C>C</C> is only necessary if <C>ddEl</C> is the zero element,
#! in which case the conic algebra over which $L$ is defined cannot be infered
#! from <C>ddEl</C> alone. 
#! @ChapterInfo Lie, Lie-0
DeclareOperation("DDToL0Emb", [ IsObject ]);
#! @Arguments C, ddEl
DeclareOperation("DDToL0Emb", [ IsFreeMagmaRing, IsObject ]);
#! @Arguments ddEl
DeclareOperation("DDToLieEmb", [ IsObject ]);
#! @Arguments C, ddEl
DeclareOperation("DDToLieEmb", [ IsFreeMagmaRing, IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Lie, Lie-0
#! @GroupTitle Components of elements of $L_0$
#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo Lie, Lie-0
DeclareOperation("L0DDPart", [ IsObject ]);
#! @Arguments l0
DeclareOperation("L0XiPart", [ IsObject ]);
#! @Arguments l0
DeclareOperation("L0ZetaPart", [ IsObject ]);
#! @EndGroup

# ----- Roots and root homomorphisms -----

#! @BeginGroup
#! @ChapterInfo Lie, Lie-Root
#! @Description
#! Lists of all (resp. all short resp. all long) roots in $F_4$ (resp. $G_2$).
DeclareGlobalName("F4Roots");
#!
DeclareGlobalName("F4ShortRoots");
#!
DeclareGlobalName("F4LongRoots");
#!
DeclareGlobalName("G2Roots");
#!
DeclareGlobalName("G2ShortRoots");
#!
DeclareGlobalName("G2LongRoots");
#! @EndGroup

#! @Description
#! @ChapterInfo Lie, Lie-Root
#! The system <C>[[1,1,-1,-1], [-2, 0, 0, 0], [1, -1, 0, 0], [0, 1, 1, 0]</C>
#! of simple roots in $F_4$.
#! This is precisely the tuple $\Delta_F = (\delta_1, \delta_2, \delta_3, \delta_4)$
#! in 11.1 in <Cite Key="DMW26"/>.<P/>
DeclareGlobalName("F4SimpleRoots");

#! @Arguments F4Root
#! @Description
#! Returns the image of <C>F4Root</C> under the surjection $\pi: F_4 \to G_2 \cup \{0\}$
#! described in 10.24 in <Cite Key="DMW26"/>.
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
#! Returns the element $\vartheta_\alpha(z)$ of $L$ as defined in 10.29 in <Cite Key="DMW26"/>.
#! Thus <C>z</C>
#! must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Root
DeclareOperation("LieRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the element $\vartheta_\alpha(z)$ of $L$ as defined in 10.29
#! in <Cite Key="DMW26"/>. Thus <C>z</C>
#! must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Root
DeclareOperation("LieRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject ]);
