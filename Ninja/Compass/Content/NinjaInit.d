/*
 * Menu initialization function called by Ninja every time a menu is opened
 */
func void Ninja_Compass_Menu(var int menuPtr) {
    // Only on game start
    const int once = 0;
    if (!once) {
        // Initialize Ikarus
        MEM_InitAll();

        // Version check
        if (NINJA_VERSION < 2813) {
            MEM_SendToSpy(zERR_TYPE_FATAL, "Compass requires at least Ninja 2.8.13 or higher.");
        };

        MEM_Info("Compass: Initializing entries in Gothic.ini.");
        if (!MEM_GothOptExists("COMPASS", "pixelSize")) {
            MEM_SetGothOpt("COMPASS", "pixelSize", IntToString(Patch_Compass_Size));
        } else {
            Patch_Compass_Size = STR_ToInt(MEM_GetGothOpt("COMPASS", "pixelSize"));
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

    // Fix mistake from a previous update that caused orphan handles
    foreachPatchHndl(NINJA_ID_COMPASS, gCSprite@, Patch_Compass_PurgeOrphanSprites);
};

/*
 * Remove dangling handles of sprites
 */
func void Patch_Compass_PurgeOrphanSprites(var int hndl) {
    var gCSprite sprite; sprite = get(hndl);
    if (!STR_StartsWith(sprite.textureName, "PATCH_COMPASS_")) {
        delete(hndl);
    };
};
