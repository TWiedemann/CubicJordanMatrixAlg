
# Fix to make RereadPackage usable



# ComRing contains indeterminates:
# - t_1, ..., t_{ComRing_rank} representing arbitrary elements,
# - g_1, ..., g_3 representing the structure constants \gamma_1, ..., \gamma_3,
# - the norms and traces of indeterminates in ConicAlg
# ComRing_rank := 6;
## The values ConicAlg_rank and Trace_MaxLength strongly affect the runtime, so keep
## them as low as possible. All computations performed in [DMW] work with either
## ConicAlg_rank := 2 and Trace_MaxLength := 5 or
## ConicAlg_rank := 4 and Trace_MaxLength := 2.
# ConicAlg contains indeterminates a_1, ... a_{ConicAlg_rank} (and their conjugates).
# ConicAlg_rank := 4;
# Let t = Trace_MaxLength. For all k <= t, all i_1, ..., i_k in [ 1..ConicAlg_rank ]
# and all possible ways to choose brackets in the product a_{i_1} .. a_{i_t},
# an indeterminate which represents tr(a_{i_1} ... a_{i_t}) 
# (with respect to the choice of brackets) will be created.
# Some of these indeterminates represent the same element of ComRing because there are identities
# such as tr(xy) = tr(yx) or tr((xy)z) = tr(x(yz)).
# If longer products are needed during the runtime, then an error message is printed.
# Trace_MaxLength := 4;



### ----- Load files in correct order -----

DeclareOperation("InitF4Graded", []);
DeclareOperation("InitF4Graded", [IsInt, IsInt, IsInt]);

InstallMethod("InitF4Graded", [IsInt, IsInt, IsInt],
	function(comrank, conicrank, tracelength)
		local myUnbind;
		myUnbind := function(s)
			if IsBoundGlobal(s) then
				MakeRereadPackageWriteGlobal(s);
				UnbindGlobal(s);
			fi;
		end;
		myUnbind("ComRing_rank");
		myUnbind("ConicAlg_rank");
		myUnbind("Trace_MaxLength");
		BindGlobal("ComRing_rank", comrank);
		BindGlobal("ConicAlg_rank", conicrank);
		BindGlobal("Trace_MaxLength", tracelength);
		RereadPackage("F4GradedGroups", "gap/constants.g"));
		RereadPackage("F4GradedGroups", "gap/F4-roots.g"));
		RereadPackage("F4GradedGroups", "gap/parity_lists.g");
		RereadPackage("F4GradedGroups", "gap/helper.g");
		RereadPackage("F4GradedGroups", "gap/conic_mag.g");
		RereadPackage("F4GradedGroups", "gap/comring.g");
		RereadPackage("F4GradedGroups", "gap/conic.g");
		RereadPackage("F4GradedGroups", "gap/init.g");
		myUnbind("IsCubicElement");
		RereadPackage("F4GradedGroups", "gap/cubic.g");
		myUnbind("IsBrownElement");
		RereadPackage("F4GradedGroups", "gap/brown.g");
		myUnbind("IsDDElement");
		myUnbind("IsL0Element");
		myUnbind("IsLieElement");
		myUnbind("IsLieEndo");
		RereadPackage("F4GradedGroups", "gap/DD.g");
		RereadPackage("F4GradedGroups", "gap/lie0.g");
		RereadPackage("F4GradedGroups", "gap/lie.g");
		RereadPackage("F4GradedGroups", "gap/lie_roothom.g");
		RereadPackage("F4GradedGroups", "gap/group.g");
		RereadPackage("F4GradedGroups", "gap/simplify.g");
		RereadPackage("F4GradedGroups", "gap/chev.g");
		RereadPackage("F4GradedGroups", "gap/test_equal.g");
		RereadPackage("F4GradedGroups", "gap/test_paper.g");
		RereadPackage("F4GradedGroups", "gap/test_additional.g");
		RereadPackage("F4GradedGroups", "gap/user_vars.g");
);

InstallMethod("InitF4Graded", [], function()
	InitF4Graded(6, 4, 4);
end);
