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

# ---- Misc ----
# The ring over which ComRing is a polynomial ring.
BindGlobal("ComRingBaseRing", Integers);
