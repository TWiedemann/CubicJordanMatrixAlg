# Indeterminates of ConicAlg
if ConicAlg_rank > 0 then
    a1 := ConicAlgIndet(1);
fi;
if ConicAlg_rank > 1 then
    a2 := ConicAlgIndet(2);
fi;
if ConicAlg_rank > 2 then
    a3 := ConicAlgIndet(3);
fi;
if ConicAlg_rank > 3 then
    a4 := ConicAlgIndet(4);
fi;
if ConicAlg_rank > 4 then
    a5 := ConicAlgIndet(5);
fi;
if ConicAlg_rank > 5 then
    a6 := ConicAlgIndet(6);
fi;
# Indeterminates of ComRing
if ComRing_rank > 0 then
    t1 := ComRingIndet(1);
fi;
if ComRing_rank > 0 then
    t2 := ComRingIndet(2);
fi;
if ComRing_rank > 0 then
    t3 := ComRingIndet(3);
fi;
if ComRing_rank > 0 then
    t4 := ComRingIndet(4);
fi;
if ComRing_rank > 0 then
    t5 := ComRingIndet(5);
fi;
if ComRing_rank > 0 then
    t6 := ComRingIndet(6);
fi;
if ComRing_rank > 0 then
    t7 := ComRingIndet(7);
fi;
if ComRing_rank > 0 then
    t8 := ComRingIndet(8);
fi;
if ComRing_rank > 0 then
    t9 := ComRingIndet(9);
fi;
if ComRing_rank > 0 then
    t10 := ComRingIndet(10);
fi;

g1 := ComRingGamIndet(1);
g2 := ComRingGamIndet(2);
g3 := ComRingGamIndet(3);

# dd as a shorthand for Liedd
dd := Liedd;

# Simple roots
# d1 := F4SimpleRoots[1];
# d2 := F4SimpleRoots[2];
# d3 := F4SimpleRoots[3];
# d4 := F4SimpleRoots[4];

# Weyl elements
# w1 := GrpStandardWeylF4(F4SimpleRoots[1]);
# w1Inv := GrpStandardWeylF4(F4SimpleRoots[1], -1);
# w2 := GrpStandardWeylF4(F4SimpleRoots[2]);
# w2Inv := GrpStandardWeylF4(F4SimpleRoots[2], -1);
# w3 := GrpStandardWeylF4(F4SimpleRoots[3]);
# w3Inv := GrpStandardWeylF4(F4SimpleRoots[3], -1);
# w4 := GrpStandardWeylF4(F4SimpleRoots[4]);
# w4Inv := GrpStandardWeylF4(F4SimpleRoots[4], -1);
