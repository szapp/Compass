/*
 * Menu initialization function called by Ninja every time a menu is opened
 */
func void Ninja_Compass_Menu(var int menuPtr) {
    // Only on game start
    const int once = 0;
    if (!once) {
        // Initialize Ikarus
        MEM_InitAll();

        MEM_Info("Compass: Initializing entries in Gothic.ini.");
        if (!MEM_GothOptExists("COMPASS", "pixelSize")) {
            MEM_SetGothOpt("COMPASS", "pixelSize", IntToString(Ninja_Compass_Size));
        } else {
            Ninja_Compass_Size = STR_ToInt(MEM_GetGothOpt("COMPASS", "pixelSize"));
        };
        once = 1;
    };
};


/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_Compass_Init() {
    // Initialize Ikarus
    MEM_InitAll();

    // Only initialize if compass does not exist in the mod
    if (MEM_FindParserSymbol("COMPASS_INIT") == -1) {
        // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
        LeGo_MergeFlags(LeGo_Sprite | LeGo_FrameFunctions);
        Patch_Compass_Init();
    };
};
