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
