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
 * Note: All symbols are prefixed with "Ninja_" to not interfere with the mod. Remove if using somewhere else!
 */

/* Constants */
const string Ninja_Compass_Tex_Back   = "NINJA_COMPASS_BACK.TGA";
const string Ninja_Compass_Tex_Needle = "NINJA_COMPASS_NEEDLE.TGA";
const int    Ninja_Compass_Size       = 150;  // Width and height in pixels
const int    Ninja_Compass_Show       = TRUE; // Switch to hide it from outside functions

/*
 * Initialization function to be called from Init_Global
 */
func void _Ninja_Compass_Init() {
    // Requires LeGo FrameFunctions and Sprite
    if (_LeGo_Flags & (LeGo_Sprite | LeGo_FrameFunctions)) {
        FF_ApplyOnce(Ninja_Compass);
    };
};

/*
 * FrameFunction to create, rotate, adjust and draw the compass on the screen
 */
func void Ninja_Compass() {
    // Create sprites once
    var int back; var int needle;
    if (!Hlp_IsValidHandle(needle)) {
        back   = Sprite_CreatePxl(0, 0, 250, 250, -1, Ninja_Compass_Tex_Back);
        needle = Sprite_CreatePxl(0, 0, 250, 250, -1, Ninja_Compass_Tex_Needle);
    };

    // Make robust to changes in screen resolution
    var int x; var int y;
    Print_GetScreenSize();
    if (Print_Screen[PS_X] != x) || (Print_Screen[PS_Y] != y) {
        x = Print_Screen[PS_X] - (Ninja_Compass_Size/2 + 15);
        y = Ninja_Compass_Size/2 + 15; // Padding of extra 15 px in case there is a status bar
        Sprite_SetPosPxl(back,   x, y);
        Sprite_SetPosPxl(needle, x, y);
        Sprite_SetDimPxl(back,   Ninja_Compass_Size, Ninja_Compass_Size);
        Sprite_SetDimPxl(needle, Ninja_Compass_Size, Ninja_Compass_Size);
        Sprite_SetRotationSC(back, FLOATNULL, FLOATONE); // Bug fix: Angles are lost for after loading
        x = Print_Screen[PS_X];
        y = Print_Screen[PS_Y];
    };

    // Auto show and hide
    var oCNpc her; her = Hlp_GetNpc(hero);
    var int on; on = _Bar_PlayerStatus() && (!(her.bitfield[0] & oCNpc_bitfield0_movlock)) && Ninja_Compass_Show;
    Sprite_SetVisible(back,   on);
    Sprite_SetVisible(needle, on);

    // Update orientation
    var zCVob vob; vob = Hlp_GetNpc(hero);
    Sprite_SetRotationSC(needle, vob.trafoObjToWorld[2], vob.trafoObjToWorld[10]);
};
