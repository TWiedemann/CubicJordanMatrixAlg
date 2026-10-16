## ---- Bools ----
# If _SanitizeImmediately = true, DDSanitizeRep is applied after several transformations which
# may produce unsanitized (but correct) output
BindGlobal("_SanitizeImmediately", true);
# If true, the tests which check whether elements lie in ComRing or ConicAlg are skipped
BindGlobal("_SkipTests", false);

## ---- Symbols ----
BindGlobal("_ConicConjSymbol", "'");
BindGlobal("_ConicNormSymbol", "n");
BindGlobal("_ConicTraceSymbol", "tr");
BindGlobal("_ComRingGamIndetSymbol", "g");
BindGlobal("_ConicIndetDefaultSymbol", "a");
BindGlobal("_ComRingIndetDefaultSymbol", "t");
BindGlobal("_ConicDefaultOneString", "1_C");
BindGlobal("_ConicDefaultZeroString", "0_C");

## ---- Integers ----
BindGlobal("_DefaultMaxTrLength", 4);

# ---- Precomputed information ----
# _ComRingTraceIndets: List of all indeterminates of the form tr(a) \in ComRing with a \in ConicAlgMag.
# _ConicAlgTraces: List of the "corresponding" elements a+a' in ConicAlg.
# Used by WithoutTraces().
DeclareGlobalName("_ComRingTraceIndets");
DeclareGlobalName("_ConicAlgTraces");
# _TrSubIndetList contains trace indeterminates which may be replaced by other terms
# using the relation tr(xy') = tr(x)tr(y) - tr(xy). This relation may be used to replace
# all appearances of a_i' in tr.
# _TrSubValueList[i] is the term by which _TrSubIndetList[i] should be replaced.
DeclareGlobalName("_TrSubIndetList");
DeclareGlobalName("_TrSubValueList");

# ---- Misc ----
# The ring over which ComRing is a polynomial ring.
BindGlobal("ComRingBaseRing", Integers);
