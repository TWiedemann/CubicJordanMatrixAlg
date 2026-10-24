# ----- Simplification functions -----

#! @BeginGroup
#! @ChapterInfo Simplify, Simplify-Function
#! @Description
#! @Label Simplify-Func
#! Returns an element of the parent structure of <C>u</C> (that is, of $k$, $C$, $B$,
#! <C>DD</C>, $L_0$ or $L$) which is mathematically equivalent to <C>u</C>. Usually the
#! internal representation of <C>Simplify(u)</C> is "easier"/"shorter"/"more canonical" than
#! that of <C>u</C>. Thus to check whether <C>u = v</C>, one should check whether
#! <C>Simplify(u-v)</C> equals zero. If this is true, then <C>u</C> and <C>v</C> represent
#! the same element. If not, then they might still represent the same element, and we can
#! try to prove this by hand by showing that <C>Simplify(u-v)</C> represents 0 (which is
#! usually easier than showing that <C>u-v</C> represents 0). The function <C>Simplify</C>
#! relies on several subroutines which can be studied in detail in <C>gap/simplify.g</C>.<P/>
#! If <C>u</C> is an element of a commutative base ring $k$, then the conic algebra
#! <C>C</C> has to be supplied as well. For any other type of <C>u</C>, this is
#! not necessary and the argument <C>C</C> will be ignored.
#! @Arguments C, u
DeclareOperation("Simplify", [ IsFreeMagmaRing, IsObject ]);
#! @Arguments u
DeclareOperation("Simplify", [ IsObject ]);
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo Simplify, Simplify-Function
#! @GroupTitle TestEquality for Lie algebra elements
#! @Description
#! Returns <C>true</C> if <C>lie1</C>, <C>lie2</C> can be proven to represent the same elements
#! using <C>Simplify</C>, and <C>false</C> otherwise. If the optional argument
#! <C>print</C> is supplied and <C>true</C>, then in addition, simplifications of all
#! non-zero components of <C>lie1-lie2</C> in $L_{-2}, \dots, L_2$ are printed.
#! @Arguments lie1, lie2[, print]
DeclareOperation("TestEquality", [ IsObject, IsObject, IsBool ]);
#! @EndGroup

DeclareOperation("TestEquality", [ IsObject, IsObject ]);

# ----- Testing equality of automorphisms of L -----

#! @BeginGroup
#! @ChapterInfo Simplify, Simplify-Test
#! @GroupTitle TestEquality of automorphism of a Lie algebra
#! @Description
#! Returns
#! <C>true</C> if <C>TestEquality(g(gen), h(gen))</C> is <C>true</C> for all <C>gen</C> in a
#! certain list of Lie algebra generators of $L$. Otherwise returns the list of all lists
#! <C>[gen, Simplify(g(gen) - h(gen))]</C> for any <C>gen</C> for which the test was not
#! successful. The list of all generators <C>gen</C> on which we test equality is obtained
#! by evaluating all root homomorphisms with image in $L_{-2} + L_1$ on 
#! $1_k$ (for long root homomorphisms) or on <C>ConicAlgIndet(C, n)</C>
#! (for short root homomorphisms).
#! The user should assure that <C>ConicAlgIndet(C, n)</C> does
#! not occur in the definition of <C>g</C> and <C>h</C>, because otherwise
#! the function may return incorrect positive results.<P/>
#! If <C>n</C> is not supplied, then <C>ConicRank(C)</C> is used as a default value.
#! @Arguments C, g, h[, n]
DeclareOperation("TestEquality", [ IsFreeMagmaRing, IsObject, IsObject, IsInt ]);
#! @EndGroup

DeclareOperation("TestEquality", [ IsFreeMagmaRing, IsObject, IsObject ]);

#! @Arguments g, h
#! @Description
#! Returns <C>true</C> in the same situations as <C>TestEquality</C>. Otherwise the output is a
#! list of all non-zero "pieces" of all "error terms" <C>Simplify(g(gen) - h(gen))</C> that
#! arise during the test. By "pieces" we mean the underlying elements of $k$, $C$ and $L_0$
#! that make up the error terms. Thus to prove that <C>g</C> and <C>h</C> are the same, it
#! suffices to prove that all elements in the output list represent 0. As for
#! <C>TestEquality</C>, the user should assure that <C>ConicAlgIndet(C, ConicRank(C))</C>
#! does not occur in the definition of <C>g</C> and
#! <C>h</C>.
#! @ChapterInfo Simplify, Simplify-Test
#! @Arguments C, g, h
DeclareOperation("TestEqualityPieces", [ IsFreeMagmaRing, IsObject, IsObject ]);
