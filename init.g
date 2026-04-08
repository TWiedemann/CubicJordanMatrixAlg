# InitCJMA(a,b,c,d) initialises the setup of the package with
# ComRing_rank := a, ConicAlg_rank := b, Trace_MaxLength := c and defines
# the variables in user_vargs.g if d = true.
# InitCJMA() uses (6,4,4,true) as the default values for (a,b,c,d).
DeclareGlobalFunction("InitCJMA");
InstallGlobalFunction(InitCJMA, function(args...)
	local comrank, conicrank, tracelength, s, userVars;
	# Set default values for ComRing_rank, ConicAlg_rank, Trace_MaxLength
	if Length(args) > 0 then
		comrank := args[1];
		conicrank := args[2];
		tracelength := args[3];
		userVars := args[4];
	else
		comrank := 6;
		conicrank := 4;
		tracelength := 4;
		userVars := true;
	fi;
	# If InitCJMA is called a second time in the same GAP session (not recommended, but
	# "usually" works), then the variables have to be unbound first
	for s in ["ComRing_rank", "ConicAlg_rank", "Trace_MaxLength"] do
		if IsBoundGlobal(s) then
			MakeReadWriteGlobal(s);
			UnbindGlobal(s);
		fi;
	od;
	BindGlobal("ComRing_rank", comrank);
	BindGlobal("ConicAlg_rank", conicrank);
	BindGlobal("Trace_MaxLength", tracelength);
	# Read files
	ReadPackage("CubicJordanMatrixAlg", "gap/constants.g"); # Global constants of the package
	ReadPackage("CubicJordanMatrixAlg", "gap/F4-roots.g"); # The root systems F4 and G2
	ReadPackage("CubicJordanMatrixAlg", "gap/parity_lists.g"); # Stores the parity map of the F4-graded group
	ReadPackage("CubicJordanMatrixAlg", "gap/helper.g"); # Helper functions, monstly for lists
	ReadPackage("CubicJordanMatrixAlg", "gap/conic_mag.g"); #
	ReadPackage("CubicJordanMatrixAlg", "gap/comring.g"); # Commutative ring k = ComRing
	ReadPackage("CubicJordanMatrixAlg", "gap/conic.g"); # Conic algebra C = Conic
	ReadPackage("CubicJordanMatrixAlg", "gap/init_trlists.g"); # Initialises some global constants
	ReadPackage("CubicJordanMatrixAlg", "gap/cubic.g"); # Cubic Jordan matrix algebra
	ReadPackage("CubicJordanMatrixAlg", "gap/brown.g"); # Brown algebra
	ReadPackage("CubicJordanMatrixAlg", "gap/DD.g"); # DD
	ReadPackage("CubicJordanMatrixAlg", "gap/lie0.g"); # L_0
	ReadPackage("CubicJordanMatrixAlg", "gap/lie.g"); # Lie algebra L
	ReadPackage("CubicJordanMatrixAlg", "gap/lie_roothom.g"); # Root homomorphisms in L
	ReadPackage("CubicJordanMatrixAlg", "gap/group.g"); # LieEndo and root homomorphisms in there
	ReadPackage("CubicJordanMatrixAlg", "gap/simplify.g"); # Simplification functions
	ReadPackage("CubicJordanMatrixAlg", "gap/chev.g"); # Chevalley-type bases
	ReadPackage("CubicJordanMatrixAlg", "gap/test_equal.g"); # Equality tests
	if userVars = true then
		ReadPackage("CubicJordanMatrixAlg", "gap/user_vars.g"); # Additional shortcuts for convenience
	fi;
end);
