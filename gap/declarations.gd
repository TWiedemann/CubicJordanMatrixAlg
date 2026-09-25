
#! @Arguments p
#! @Description
#! Returns the <C>p</C>-th indeterminate in $k$, which is printed as <C>tp</C>.
#! We must have <C>1 &lt;= p &lt;= ComRing_rank</C>.
#! If the package was initialised with <C>userVars = true</C>,
#! then GAP variables <C>t1 := ComRingIndet(1), ...</C> are defined.
#! @ChapterInfo The commutative ring $k$, Functions
DeclareOperation("ComRingIndet", [ IsInt ]);

#! @Arguments i
#! @Description
#! Returns the <C>i</C>-th element of $\Gamma = (\gamma_1, \gamma_2, \gamma_3)$.
#! These are the (arbitrarily chosen, but fixed) constants that appear
#! in the definition of cubic Jordan matrix algebras.
#! They are printed as <C>g1, g2, g3</C>.
#! If the package was initialised with <C>userVars = true</C>,
#! then GAP variables <C>g1 := ComRingGamIndet(1), ...</C> are defined.
#! @ChapterInfo The commutative ring $k$, Functions
DeclareOperation("ComRingGamIndet", [ IsInt ]);

#! @Arguments p
#! @Description
#! Returns the <C>p</C>-th indeterminate in $C$, which is printed as <C>ap</C>. We must have
#! <C>1 &lt;= p &lt;= ComRing_rank</C>. If the package was initialised with <C>userVars =
#! true</C>, then GAP variables <C>a1 := ConicAlgIndet(1), ...</C> are available.
#! @ChapterInfo The multiplicative conic alternative algebra $C$, Functions
DeclareOperation("ConicAlgIndet", [ IsInt ]);

#! @Arguments a
#! @Description
#! Returns the conjugate of <C>a</C>. This is an element of $C$ which is printed as <C>a'</C>.
#! <C>ConicInv</C> and <C>ConicConj</C> are different names for the same function.
#! @ChapterInfo The multiplicative conic alternative algebra $C$, Functions
DeclareOperation("ConicInv", [ IsObject ]);

#! @Arguments a
#! @Description
#! Returns the conjugate of <C>a</C>. This is an element of $C$ which is printed as <C>a'</C>.
#! <C>ConicInv</C> and <C>ConicConj</C> are different names for the same function.
#! @ChapterInfo The multiplicative conic alternative algebra $C$, Functions
DeclareOperation("ConicConj", [ IsObject ]);

#! @Arguments a
#! @Description
#! Returns the norm of <C>a</C>. This is an element of $k$ which is printed as <C>n(a)</C>.
#! @ChapterInfo The multiplicative conic alternative algebra $C$, Functions
DeclareOperation("ConicNorm", [ IsObject ]);

#! @Arguments a
#! @Description
#! Returns the trace of <C>a</C>. This is an element of $k$ which is printed as <C>tr(a)</C>.
#! Several measures are taken to simplify (the display of) traces. Multiplication signs in
#! the argument of the trace are not printed: For <C>a=a1*a2</C>, the trace of <C>a</C> is
#! printed as <C>tr(a1a2)</C>. By the relation <C>tr((ab)c) = tr(a(bc))</C>, we can omit
#! brackets in products of length at most 3, so the result of <C>ConicTr((a1*a2)*a3)</C> is
#! printed as <C>tr(a1a2a3)</C>. Using in addition the relations <C>tr(a') = tr(a)</C> and
#! <C>tr(ab) = tr(ba)</C>, the arguments of the trace are often permuted and/or replaced by
#! their conjugates to ensure proper cancellation of terms. For example, both
#! <C>ConicTr(a1*ConicInv(a2))</C> and <C>ConicTr(ConicInv(a1)*a2)</C> evaluate to
#! <C>tr(a1a2')</C>, and <C>ConicTr(ConicInv(a1)*a2*a3)</C> evaluates to <C>tr(a1a3'a2')</C>
#! (which is correct because <C>tr(a1'a2a3) = tr((a1'a2a3)') = tr(a3'a2'a1) =
#! tr(a1a3'a2')</C>).
#! @ChapterInfo The multiplicative conic alternative algebra $C$, Functions
DeclareOperation("ConicTr", [ IsObject ]);

#! @Arguments a, b
#! @Description
#! Returns <C>n(a+b)-n(a)-n(b)</C>, which is known to be the same as <C>tr(a'b)</C>.
#! @ChapterInfo The multiplicative conic alternative algebra $C$, Functions
DeclareOperation("ConicNormLin", [ IsObject, IsObject ]);

#! @Arguments a, i
#! @Description
#! Returns <C>a[jl]</C> where <C>[i,j,l]</C> is the unique cyclic permutation of <C>[1,2,3]</C>
#! starting from <C>i</C>.
#! @ChapterInfo The cubic Jordan matrix algebra, Elements of the cubic Jordan matrix algebra
DeclareOperation("CubicConicEl", [ IsRingElement, IsObject ]);

#! @Arguments t, i
#! @Description
#! Returns the element of $J$ which is denoted by $te_i$ in [DMW]. It is printed as
#! <C>t[ii]</C>.
#! @ChapterInfo The cubic Jordan matrix algebra, Elements of the cubic Jordan matrix algebra
DeclareOperation("CubicComEl", [ IsRingElement, IsObject ]);

#! @Arguments z, i, j
#! @Description
#! Returns <C>z[ij]</C>. Thus <C>z</C> must lie in $k$ if <C>i=j</C> and in $C$ otherwise.
#! @ChapterInfo The cubic Jordan matrix algebra, Elements of the cubic Jordan matrix algebra
DeclareOperation("CubicEl", [ IsRingElement, IsInt, IsInt ]);

#! @Arguments t, s, r, a, b, c
#! @Description
#! Returns <C>t[11] + s[22] + r[33] + a[23] + b[31] + c[12]</C>.
#! @ChapterInfo The cubic Jordan matrix algebra, Elements of the cubic Jordan matrix algebra
DeclareOperation("CubicElFromTuple",
    [ IsRingElement, IsRingElement, IsRingElement, IsRingElement, IsRingElement, IsRingElement ]);

#! @Arguments cub, i
#! @Description
#! Returns the corresponding component of <C>cub</C>. For example, for <C>cub = t[11] + s[22] +
#! r[33] + a[23] + b[31] + c[12]</C>, we have <C>CubicConicPart(cub, 1) = a</C> and
#! <C>CubicComPart(cub, 2) = s</C>.
#! @ChapterInfo The cubic Jordan matrix algebra, Elements of the cubic Jordan matrix algebra
DeclareOperation("CubicConicPart", [ IsObject, IsObject ]);

#! @Arguments cub, i
#! @Description
#! Returns the corresponding component of <C>cub</C>. For example, for <C>cub = t[11] + s[22] +
#! r[33] + a[23] + b[31] + c[12]</C>, we have <C>CubicConicPart(cub, 1) = a</C> and
#! <C>CubicComPart(cub, 2) = s</C>.
#! @ChapterInfo The cubic Jordan matrix algebra, Elements of the cubic Jordan matrix algebra
DeclareOperation("CubicComPart", [ IsObject, IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the norm of <C>cub</C>, which is an element of $k$.
#! @ChapterInfo The cubic Jordan matrix algebra, The cubic norm structure
DeclareOperation("CubicNorm", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the adjoint $\text{cub}^\sharp$ of <C>cub</C>, which is an element of $J$.
#! @ChapterInfo The cubic Jordan matrix algebra, The cubic norm structure
DeclareOperation("CubicAdj", [ IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the bilinear trace $T(\text{cub1}, \text{cub2})$ of <C>cub1</C>, <C>cub2</C>, which
#! is an element of $k$.
#! @ChapterInfo The cubic Jordan matrix algebra, The cubic norm structure
DeclareOperation("CubicBiTr", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns $\text{cub1} \times \text{cub2}$, which is an element of $J$.
#! @ChapterInfo The cubic Jordan matrix algebra, The cubic norm structure
DeclareOperation("CubicCross", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns $U_{\text{cub1}}(\text{cub2})$, which is an element of $J$.
#! @ChapterInfo The cubic Jordan matrix algebra, The Jordan algebra structure
DeclareOperation("JordanU", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2, cub3
#! @Description
#! Returns $U_{\text{cub1},\text{cub2}}(\text{cub3})=U_{\text{cub1}+\text{cub2}}(\text{cub3}) -
#! U_{\text{cub1}}(\text{cub3}) - U_{\text{cub2}}(\text{cub3})$, which is an element of $J$.
#! @ChapterInfo The cubic Jordan matrix algebra, The Jordan algebra structure
DeclareOperation("JordanULin", [ IsObject, IsObject, IsObject ]);

#! @Arguments cub1, cub2, cub3
#! @Description
#! Returns $D_{\text{cub1}, \text{cub2}}(\text{cub3}) = \{\text{cub1}, \text{cub2},
#! \text{cub3}\} = U_{\text{cub1}, \text{cub3}}(\text{cub2})$, which is an element of $J$.
#! @ChapterInfo The cubic Jordan matrix algebra, The Jordan algebra structure
DeclareOperation("JordanD", [ IsObject, IsObject, IsObject ]);

#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[ t, cub1, cub2, s ]</C> of $B$.
#! @ChapterInfo The Brown algebra, Functions
DeclareOperation("BrownEl", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments brown
#! @Description
#! Returns the GAP list <C>[ t, cub1, cub2, s ]</C> underlying <C>brown</C>.
#! @ChapterInfo The Brown algebra, Functions
DeclareOperation("BrownElTuple", [ IsObject ]);

#! @Arguments brown, p
#! @Description
#! Returns the <C>p</C>-th entry of the list underlying <C>brown</C>, where <C>1 &lt;= p &lt;=
#! 4</C>.
#! @ChapterInfo The Brown algebra, Functions
DeclareOperation("BrownElPart", [ IsObject, IsObject ]);

#! @Arguments brown, p
#! @Description
#! Returns <C>BrownElPart(brown, 1)</C> for <C>p=1</C> and <C>BrownElPart(brown, 4)</C> for
#! <C>p=2</C>.
#! @ChapterInfo The Brown algebra, Functions
DeclareOperation("BrownElComPart", [ IsObject, IsObject ]);

#! @Arguments brown, p
#! @Description
#! Returns <C>BrownElPart(brown, 2)</C> for <C>p=1</C> and <C>BrownElPart(brown, 3)</C> for
#! <C>p=2</C>.
#! @ChapterInfo The Brown algebra, Functions
DeclareOperation("BrownElCubicPart", [ IsObject, IsObject ]);

#! @Arguments lie, p
#! @Description
#! Returns the projection of <C>lie</C> to $L_p$ where <C>-2 &lt;= p &lt;= 2</C>. This is an
#! element of $k$ if $p = \pm 2$, and element of $B$ if $p = \pm 1$ and an element of $L_0$
#! if $p=0$.
#! @ChapterInfo The Lie algebra, Functions
DeclareOperation("LiePart", [ IsObject, IsObject ]);

#! @Arguments brown
#! @Description
#! Returns the element <C>brown_+</C> of $L_1$ or <C>brown_-</C> of $L_{-1}$, respectively.
#! @ChapterInfo The Lie algebra, The parts $L_{-1}$ and $L_1$
DeclareOperation("BrownPosToLieEmb", [ IsObject ]);

#! @Arguments brown
#! @Description
#! Returns the element <C>brown_+</C> of $L_1$ or <C>brown_-</C> of $L_{-1}$, respectively.
#! @ChapterInfo The Lie algebra, The parts $L_{-1}$ and $L_1$
DeclareOperation("BrownNegToLieEmb", [ IsObject ]);

#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[t, cub1, cub2, s]_+</C> of $L_1$ or <C>[t, cub1, cub2, s]_-</C> of
#! $L_{-1}$, respectively.
#! @ChapterInfo The Lie algebra, The parts $L_{-1}$ and $L_1$
DeclareOperation("BrownPosEl", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments t, cub1, cub2, s
#! @Description
#! Returns the element <C>[t, cub1, cub2, s]_+</C> of $L_1$ or <C>[t, cub1, cub2, s]_-</C> of
#! $L_{-1}$, respectively.
#! @ChapterInfo The Lie algebra, The parts $L_{-1}$ and $L_1$
DeclareOperation("BrownNegEl", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments l0
#! @Description
#! Returns the embedding of <C>l0</C> into $L$.
#! @ChapterInfo The Lie algebra, The Lie subalgebra $L_0$
DeclareOperation("L0ToLieEmb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L_0$, respectively.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("CubicPosToL0Emb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L_0$, respectively.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("CubicNegToL0Emb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L$, respectively.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("CubicPosToLieEmb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! Returns the elements <C>ad_{cub}^+</C> and <C>ad_{cub}^-</C> of $L$, respectively.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("CubicNegToLieEmb", [ IsObject ]);

#! @Arguments cub
#! @Description
#! These are alternative names for <C>CubicPosToLieEmb</C> and <C>CubicNegToLieEmb</C>.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("adPos", [ IsObject ]);

#! @Arguments cub
#! @Description
#! These are alternative names for <C>CubicPosToLieEmb</C> and <C>CubicNegToLieEmb</C>.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("adNeg", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns the projection of <C>l0</C> onto $L_{0,1}$ or $L_{0,-1}$, respectively.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("L0CubicPosPart", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns the projection of <C>l0</C> onto $L_{0,1}$ or $L_{0,-1}$, respectively.
#! @ChapterInfo The Lie algebra, The $L_0$ components
DeclareOperation("L0CubicNegPart", [ IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>. If the package was initialised with <C>userVars = true</C>, then
#! the shortcut <C>dd := Liedd</C> is defined.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("DDdd", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>. If the package was initialised with <C>userVars = true</C>, then
#! the shortcut <C>dd := Liedd</C> is defined.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("L0dd", [ IsObject, IsObject ]);

#! @Arguments cub1, cub2
#! @Description
#! Returns the element $\mathbf{d}_{\text{cub1},\text{cub2}}$, regarded as an element of
#! <C>DD</C>, $L_0$ or $L$, respectively. In all three cases, it is printed as
#! <C>dd_{cub1,cub2}</C>. If the package was initialised with <C>userVars = true</C>, then
#! the shortcut <C>dd := Liedd</C> is defined.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("Liedd", [ IsObject, IsObject ]);

#! @Arguments ddEl
#! @Description
#! Returns the embedding of <C>ddEl</C> into $L_0$ or $L$, respectively.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("DDToL0Emb", [ IsObject ]);

#! @Arguments ddEl
#! @Description
#! Returns the embedding of <C>ddEl</C> into $L_0$ or $L$, respectively.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("DDToLieEmb", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("L0DDPart", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("L0XiPart", [ IsObject ]);

#! @Arguments l0
#! @Description
#! Returns elements of <C>DD</C> and $k$ such that the projection of <C>l0</C> onto $Z$ is
#! <C>L0DDPart(l0) + L0XiPart(l0)*L0Xi + L0ZetaPart(l0)*L0Zeta</C>. Note that since the sum
#! of <C>DD</C> and $k \xi + k \zeta$ is not necessarily direct, these elements are not
#! uniquely determined by this property.
#! @ChapterInfo The Lie algebra, The parts $Z$ and `DD`
DeclareOperation("L0ZetaPart", [ IsObject ]);

#! @Arguments F4Root
#! @Description
#! Returns the image of <C>F4Root</C> under the surjection $\pi: F_4 \to G_2 \cup \{0\}$
#! described in [DMW, 10.24].
#! @ChapterInfo The Lie algebra, Root homomorphisms
DeclareOperation("F4RootG2Coord", [ IsObject ]);

#! @Arguments F4Root1, F4Root2
#! @Description
#! Returns $\text{F4Root1}^{\sigma(\text{F4Root2})}$, the image of <C>F4Root1</C>
#! under the reflection along the hyperplane orthogonal to <C>F4Root2</C>.
#! @ChapterInfo The Lie algebra, Root homomorphisms
DeclareOperation("F4Refl", [ IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the element $\vartheta_\alpha(z)$ of $L$ as defined in [DMW, 10.29]. Thus <C>z</C>
#! must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo The Lie algebra, Root homomorphisms
DeclareOperation("LieRootHomF4", [ IsObject, IsObject, IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the element $\vartheta_\alpha(z)$ of $L$ as defined in [DMW, 10.29]. Thus <C>z</C>
#! must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo The Lie algebra, Root homomorphisms
DeclareOperation("LieRootHomF4", [ IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the automorphism $\theta_\alpha(a)$ of $L$ in <C>LieEndo</C> as defined in
#! [DMW, 11.2, 11.8]. Thus <C>z</C> must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo The automorphism group, Functions
DeclareOperation("GrpRootHomF4", [ IsObject, IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the automorphism $\theta_\alpha(a)$ of $L$ in <C>LieEndo</C> as defined in
#! [DMW, 11.2, 11.8]. Thus <C>z</C> must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo The automorphism group, Functions
DeclareOperation("GrpRootHomF4", [ IsObject, IsObject ]);

#! @Arguments F4Root
#! @Description
#! Returns the Weyl element $w_\alpha = \theta_{-\alpha}(-1) \theta_\alpha(1)
#! \theta_{-\alpha}(-1)$ in <C>LieEndo</C>.
#! @ChapterInfo The automorphism group, Functions
DeclareOperation("GrpStandardWeylF4", [ IsList ]);

# Variant with additional sign. Not part of the main interface.
DeclareOperation("GrpStandardWeylF4", [ IsList, IsInt ]);

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
#! @ChapterInfo Simplification and equality tests, Functions
DeclareOperation("Simplify", [ IsObject ]);

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
#! indeterminate in $k$ or $C$ (that is, on <C>ComRingIndet(ComRing_rank)</C> or
#! <C>ConicAlgIndet(ConicAlg_rank)</C>). The user should assure that these indeterminates do
#! not occur in the definition of <C>g</C> and <C>h</C>.
#! @ChapterInfo Simplification and equality tests, Functions
DeclareOperation("TestEquality", [ IsObject, IsObject, IsObject ]);

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
#! indeterminate in $k$ or $C$ (that is, on <C>ComRingIndet(ComRing_rank)</C> or
#! <C>ConicAlgIndet(ConicAlg_rank)</C>). The user should assure that these indeterminates do
#! not occur in the definition of <C>g</C> and <C>h</C>.
#! @ChapterInfo Testing equality of automorphism of $L$, Functions
DeclareOperation("TestEquality", [ IsObject, IsObject ]);

#! @Arguments g, h
#! @Description
#! Returns <C>true</C> in the same situations as <C>TestEquality</C>. Otherwise the output is a
#! list of all non-zero "pieces" of all "error terms" <C>Simplify(g(gen) - h(gen))</C> that
#! arise during the test. By "pieces" we mean the underlying elements of $k$, $C$ and $L_0$
#! that make up the error terms. Thus to prove that <C>g</C> and <C>h</C> are the same, it
#! suffices to prove that all elements in the output list represent 0. As for
#! <C>TestEquality</C>, the user should assure that <C>ComRingIndet(ComRing_rank)</C> or
#! <C>ConicAlgIndet(ConicAlg_rank)</C> do not occur in the definition of <C>g</C> and
#! <C>h</C>.
#! @ChapterInfo Testing equality of automorphism of $L$, Functions
DeclareOperation("TestEqualityPieces", [ IsObject, IsObject ]);

#! @Arguments [comrank, conicrank, tracelength, userVars]
#! @Description
#! Initialises the package with <C>ComRing_rank := comrank</C>, <C>ConicAlg_rank :=
#! conicrank</C>, <C>Trace_MaxLength := tracelength</C>. If <C>userVars = true</C>, then the
#! following GAP variables are defined for the user's convenience: <C>t1, t2, ...</C> for
#! the generators of $k$; <C>a1, a2, ...</C> for the generators of $C$; <C>g1, g2, g3</C>
#! for the (arbitrary) constants $\gamma_1, \gamma_2, \gamma_3$ in $k$ (see below);
#! <C>dd</C> for <C>Liedd</C> (see below). If <C>userVars = false</C>, then for example the
#! indeterminates in $k$ are still printed as <C>t1, t2, ...</C>, but no GAP variables of
#! the same name are defined to easily access these elements of $k$. High values of
#! <C>ConicAlg_rank</C> and <C>Trace_MaxLength</C> strongly impact the time needed for
#! initialisation with <C>InitCJMA</C>. All serious computations needed in [DMW] work in
#! the setup <C>InitCJMA(6, 3, 4, false)</C> or <C>InitCJMA(6, 2, 4, false)</C>. It is
#! possible to reset the values of these constants with another call to <C>InitCJMA</C>.
#! However, this will issue a few GAP warnings (see below) and may lead to unsafe behaviour,
#! and is hence not recommended. In particular, re-initialisation will redefine all
#! algebraic structures that are set up in the package, and hence elements of these
#! structures that were defined before re-initialisation are not compatible with those
#! defined afterwards. For example:
#! @ChapterInfo Introduction, Initialisation
DeclareGlobalFunction("InitCJMA");
