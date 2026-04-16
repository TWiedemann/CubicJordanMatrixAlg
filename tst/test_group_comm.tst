### Test with Test(filepath)

### This file tests that the root homomorphisms in the automorphism group satisfy
### the desired F4-commutator relations.

### Init
gap> START_TEST("test_group_comm.tst");
gap> InitCJMA(6, 3, 4, false);;
gap> ReadPackage("CubicJordanMatrixAlg", "gap/DMW/test_DMW.g");;

# Element is trivial because
# n(a2)*a1 = a1*n(a2) = a1*(a2*a2') = (a1*a2)*a2',
# using Artin's Theorem in the last step.
gap> TestGrpComRels();
[ dd_{(1)[22],((-n(a2)/g3)*a1+(1/g3)*((a1*a2)*a2'))[12]} ]

#
gap> STOP_TEST("test_group_comm.tst");
