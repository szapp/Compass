# Compass

[![Scripts](https://github.com/szapp/Compass/actions/workflows/scripts.yml/badge.svg)](https://github.com/szapp/Compass/actions/workflows/scripts.yml)
[![Validation](https://github.com/szapp/Compass/actions/workflows/validation.yml/badge.svg)](https://github.com/szapp/Compass/actions/workflows/validation.yml)
[![Build](https://github.com/szapp/Compass/actions/workflows/build.yml/badge.svg)](https://github.com/szapp/Compass/actions/workflows/build.yml)
[![GitHub release](https://img.shields.io/github/v/release/szapp/Compass.svg)](https://github.com/szapp/Compass/releases/latest)

This patch (Gothic, Gothic Sequel, Gothic 2, and Gothic 2 NotR) adds an on-screen compass.

This is a modular modification (a.k.a. patch or add-on) that can be installed and uninstalled at any time and is virtually compatible with any modification.
It supports <kbd>Gothic 1</kbd>, <kbd>Gothic Sequel</kbd>, <kbd>Gothic II (Classic)</kbd> and <kbd>Gothic II: NotR</kbd>.

<sup>Generated from [szapp/patch-template](https://github.com/szapp/patch-template).</sup>

<img src="https://github.com/szapp/Compass/assets/20203034/ada59636-7337-47cb-8c3d-0d2dc571b659" alt="Screenshot" width="29%" /> &nbsp;
<img src="https://github.com/szapp/Compass/assets/20203034/5e55e0ff-aadf-48df-9801-d93e285cd5e9" alt="Screenshot" width="51%" />

> [!NOTE]
> The compass may not be visible when the D3D11 renderer is in use.

## INI settings

The size of the compass is adjustable in the Gothic.ini in the section `[COMPASS]` under `pixelSize`.
This entry is created automatically after launching the game.

## Notes

- The graphics are made by [Feuerbarde](https://forum.worldofplayers.de/forum/members/165148).
- The implementation is based on the [compass script](https://forum.worldofplayers.de/forum/threads/?p=26483751).

## Installation

1. Download the latest release of `Compass.vdf` from the [releases page](https://github.com/szapp/Compass/releases/latest).

2. Copy the file `Compass.vdf` to `[Gothic]\Data\`. To uninstall, remove the file again.

The patch is also available on
- [World of Gothic](https://www.worldofgothic.de/dl/download_638.htm) | [Forum thread](https://forum.worldofplayers.de/forum/threads/1560392)
- [Spine Mod-Manager](https://clockwork-origins.com/spine/)
- [Steam Workshop Gothic 1](https://steamcommunity.com/sharedfiles/filedetails/?id=2787288239)
- [Steam Workshop Gothic 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2787285078)

### Requirements

<table><thead><tr><th>Gothic</th><th>Gothic Sequel</th><th>Gothic II (Classic)</th><th>Gothic II: NotR</th></tr></thead>
<tbody><tr><td><a href="https://www.worldofgothic.de/dl/download_34.htm">Version 1.08k_mod</a></td><td>Version 1.12f</td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 1.30.0.0</a></td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 2.6.0.0</a></td></tr></tbody>
<tbody><tr><td colspan="4" align="center"><a href="https://github.com/szapp/Ninja">Ninja 2.8</a> or higher</td></tr></tbody></table>

<!--

If you are interested in writing your own patch, please do not copy this patch!
Instead refer to the PATCH TEMPLATE to build a foundation that is customized to your needs!
The patch template can found at https://github.com/szapp/patch-template.

-->
