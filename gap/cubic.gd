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
#! Returns the zero element of the conic algebra over <C>C</C>.
#! @ChapterInfo CJMA, CJMA-Elements
DeclareOperation("CubicZero", [ IsFreeMagmaRing ]);

#! @BeginGroup
#! @ChapterInfo CJMA, CJMA-Elements
#! @GroupTitle CubicConicPart and CubicComPart
#! @Description
#! Returns the corresponding component of <C>cub</C>. For example, for <C>cub = t[11] + s[22] +
#! r[33] + a[23] + b[31] + c[12]</C>, we have <C>CubicConicPart(cub, 1) = a</C> and
#! <C>CubicComPart(cub, 2) = s</C>.
#! @Arguments cub, i
DeclareOperation("CubicConicPart", [ IsObject, IsObject ]);
#! @Arguments cub, i
DeclareOperation("CubicComPart", [ IsObject, IsObject ]);
#! @EndGroup

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
