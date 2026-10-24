#! @Arguments C, p
#! @Description
#! Returns the <C>p</C>-th indeterminate in the base ring of <C>C</C>.
#! We must have <C>1 &lt;= p &lt;= ComRingRank(C)</C>.
#! @ChapterInfo Conic, Conic-ComRing
DeclareOperation("ComRingIndet", [ IsRing, IsInt ]);

DeclareOperation("ComRingIndet", [ IsString, IsInt ]);

#! @Arguments i
#! @ChapterInfo Conic, Conic-ComRing
#! @Description
#! Returns the <C>i</C>-th element of $\Gamma = (\gamma_1, \gamma_2, \gamma_3)$.
#! These are the (arbitrarily chosen, but fixed) constants that appear
#! in the definition of cubic Jordan matrix algebras.
#! They are printed as <C>g1, g2, g3</C>.
DeclareOperation("ComRingGamIndet", [ IsInt ]);
