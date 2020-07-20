/*
 *Default size in pixels
 */
const int Ninja_Compass_Size = 180;


/*
 * Core to create, rotate, adjust and draw the compass on the screen
 */
func void Ninja_Compass_Draw() {
    // Create sprites once
    var int back; var int needle;
    if (!Hlp_IsValidHandle(needle)) {
        back   = Sprite_CreatePxl(0, 0, 10, 10, -1, "NINJA_COMPASS_BACK.TGA");
        needle = Sprite_CreatePxl(0, 0, 10, 10, -1, "NINJA_COMPASS_NEEDLE.TGA");
    };

    // Make robust to changes in screen resolution
    var int x; var int y;
    Print_GetScreenSize();
    if (x != Print_Screen[PS_X]) || (y != Print_Screen[PS_X]) {
        x = Print_Screen[PS_X] - (Ninja_Compass_Size/2);
        y = Ninja_Compass_Size/2;
        Sprite_SetPosPxl(back,   x, y);
        Sprite_SetPosPxl(needle, x, y);
        Sprite_SetDimPxl(back,   Ninja_Compass_Size, Ninja_Compass_Size);
        Sprite_SetDimPxl(needle, Ninja_Compass_Size, Ninja_Compass_Size);
        x = Print_Screen[PS_X];
        y = Print_Screen[PS_Y];
    };

    // Auto show and hide
    var oCNpc her; her = Hlp_GetNpc(hero);
    var int status; status = _Bar_PlayerStatus() && (!(her.bitfield[0] & oCNpc_bitfield0_movlock));
    Sprite_SetVisible(back,  status);
    Sprite_SetVisible(needle, status);

    // Update orientation
    var zCVob vob; vob = Hlp_GetNpc(hero);
    Sprite_SetRotationSC(needle, vob.trafoObjToWorld[2], vob.trafoObjToWorld[10]);
};


/*
 * Menu initialization function called by Ninja every time a menu is opened
 */
func void Ninja_Compass_Menu(var int menuPtr) {
    const int once = 0;
    if (!once) {
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
    // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
    LeGo_MergeFlags(LeGo_Sprite | LeGo_FrameFunctions);
    FF_ApplyOnce(Ninja_Compass_Draw);
};
