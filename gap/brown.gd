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
