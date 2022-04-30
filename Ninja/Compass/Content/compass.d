/*
 * compass.d
 * Source: https://forum.worldofplayers.de/forum/threads/?p=26483751
 *
 * Add an on-screen compass.
 *
 * - Requires Ikarus, LeGo (FrameFunctions and Sprite)
 * - Compatible with Gothic 1 and Gothic 2
 *
 * Instructions
 * - Initialize from Init_Global with
 *     Compass_Init();
 *
 *
 * Note: All symbols are prefixed with "Patch_" to not interfere with the mod. Remove if using somewhere else!
 */

/* Constants */
const string Patch_Compass_Tex_Back   = "PATCH_COMPASS_BACK.TGA";
const string Patch_Compass_Tex_Needle = "PATCH_COMPASS_NEEDLE.TGA";
const int    Patch_Compass_Size       = 150; // Width and height in pixels
const int    Patch_Compass_Show       = 1;   // Switch for outside functions to hide it (TRUE/FALSE)

/*
 * Initialization function to be called from Init_Global
 */
func void Patch_Compass_Init() {
    // Requires LeGo FrameFunctions and Sprite
    if (_LeGo_Flags & (LeGo_Sprite | LeGo_FrameFunctions)) {
        FF_ApplyOnce(Patch_Compass);
        foreachHndlSort(gCSprite@, _Sprite_PrioComparer); // Bug fix for lower LeGo versions
    };
};

/*
 * FrameFunction to create, rotate, adjust and draw the compass on the screen
 */
func void Patch_Compass() {
    // Create sprites once
    var int back; var int needle; var int init;
    if (!Hlp_IsValidHandle(needle)) {
        PM_BindInt(needle); // Patch-specific to avoid duplicate sprites after re-install
        back   = Sprite_CreatePxl(0, 0, 250, 250, -1, Patch_Compass_Tex_Back);
        needle = Sprite_CreatePxl(0, 0, 250, 250, -1, Patch_Compass_Tex_Needle);
        Sprite_SetPrio(needle, 1); // Keep needle on top
        init = FALSE; // Patch-specific to force re-initialization, if lost after loading (paranoid)
    };

    // Make robust to changes in screen resolution
    var int x; var int y;
    Print_GetScreenSize();
    if (Print_Screen[PS_X] != x) || (Print_Screen[PS_Y] != y) || (!init) {
        x = Print_Screen[PS_X] - (Patch_Compass_Size/2 + 15);
        y = Patch_Compass_Size/2 + 15; // Padding of extra 15 px in case there is a status bar
        Sprite_SetPosPxl(back,   x, y);
        Sprite_SetPosPxl(needle, x, y);
        Sprite_SetDimPxl(back,   Patch_Compass_Size, Patch_Compass_Size);
        Sprite_SetDimPxl(needle, Patch_Compass_Size, Patch_Compass_Size);
        Sprite_SetRotationSC(back, FLOATNULL, FLOATONE); // Bug fix: Angles are lost for after loading
        x = Print_Screen[PS_X];
        y = Print_Screen[PS_Y];
        init = TRUE;
    };

    // Auto show and hide
    var oCNpc her; her = Hlp_GetNpc(hero);
    var int on; on = _Bar_PlayerStatus() && (!(her.bitfield[0] & oCNpc_bitfield0_movlock)) && Patch_Compass_Show;
    Sprite_SetVisible(back,   on);
    Sprite_SetVisible(needle, on);

    // Update orientation
    var zCVob vob; vob = Hlp_GetNpc(hero);
    Sprite_SetRotationSC(needle, negf(vob.trafoObjToWorld[2]), vob.trafoObjToWorld[10]);
};
