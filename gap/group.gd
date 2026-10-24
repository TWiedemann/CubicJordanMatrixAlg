#! @Description
#! The identity element in the automorphism group of the Lie algebra over a conic algebra.
#! It is the same for any conic algebra.
#! @ChapterInfo Lie, Lie-Auto
DeclareGlobalName("LieEndoOne");

#! @Arguments F4Root, z
#! @Description
#! Returns the automorphism $\theta_\alpha(a)$ of $L$ as defined in
#! 11.2 and 11.8 in <Cite Key="DMW26"/>.
#! Thus <C>z</C> must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Auto
DeclareOperation("GrpRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject, IsObject ]);

#! @Arguments F4Root, z
#! @Description
#! Returns the automorphism $\theta_\alpha(a)$ of $L$ as defined in
#! 11.2 and 11.8 in <Cite Key="DMW26"/>. Thus <C>z</C> must be in $k$ if <C>F4Root</C> is long and in $C$ otherwise.
#! @ChapterInfo Lie, Lie-Auto
DeclareOperation("GrpRootHomF4", [ IsFreeMagmaRing, IsObject, IsObject ]);

#! @Arguments F4Root
#! @Description
#! Returns the Weyl element $w_\alpha = \theta_{-\alpha}(-1) \theta_\alpha(1)
#! \theta_{-\alpha}(-1)$ .
#! @ChapterInfo Lie, Lie-Auto
DeclareOperation("GrpStandardWeylF4", [ IsFreeMagmaRing, IsList ]);

# Variant with additional sign. Not part of the main interface.
DeclareOperation("GrpStandardWeylF4", [ IsFreeMagmaRing, IsList, IsInt ]);
