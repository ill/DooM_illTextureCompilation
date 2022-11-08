# DooM_illTextureCompilation
A compilation of various zdoom compatible texture packs into one giant pack, all cleaned and ready to go. Should be a good base for projects as you develop, and then use a cleanup tool to remove unneeded textures once you're ready to release. Most of these are curated/recovered from Realm667.

The original info files are all included internally by the original authors of the various texture packs. At this time I take no credit for any textures myself, but I may add some of my own here in the future.  I take credit for the hard work it took to compile this massive pack and make sure there aren't any conflicts or redundant entries and that it works as correctly and smoothly as possible in GZDoom and SLADE. I also wrote some new ZDoom Texture management tools for SLADE to help create this pack.

I'd appreciate a bit of credit if you use this pack, and I'm sure the original authors would appreciate it too.  I must admit, I'm probably breaking the contract of some of the texture pack authors by including their work here and modifying things slightly, but a lot of it was from the 90s, and I'm in no way trying to take credit for their work.  I'm just trying to make it easier to use their work in 2022 with all the doom mods people may be working on nowadays.

You should be able to add the pk3 folder as a resource when working with doom builder or other similar editors.

When you're ready to release your map pack that uses these textures, clean up the unneeded textures using the latest version of SLADE.
Archive -> Maintenance -> Remove Unused ZDoomTextures.

Note: This transforms a lot of the original texture packs to be cleaned up for GZDoom using some of my new SLADE tools.
- All TEXTURE files have been converted to the ZDoom format
- All TEXTURE files have been cleaned up so only necessary entries exist
  - No iWAD texture definitions are present in the TEXTURE files
  - All Textures that can be represented by a single image exist as image files under the textures folders
    - This means no single patch texture definitions (Using the "Clean Single Patch Textures" tool I wrote for SLADE)
    - I also tried to eliminate tiled patch texture definitions by hand whenever I saw any
    - If the texture definition has anything special, like high res defs, or more than 1 patch, or patches not at 0, 0 filling the image, it stays a texture
  - Texture files are named TEXTURE.\<name of texture pack\> to be compatible with Zandronum and GZdoom
- All ANIMDEF files follow the same convention of having the extension being the original texture pack name
- Lots of original Readme/Info files also follow this naming convention, based on how they were originally named
  - e.g 2mbrown.txt stays named 2mbrown.txt
  - INFO.txt and CREDITS.txt files are renamed to INFO.\<name of texture pack\>
- All non-TEXTURE file textures exist under textures
- All flats were moved to flats folders
- All other resources were moved to their folders too, e.g. sounds are under sounds
- Every asset type has a subfolder with the name of the original asset pack it's from, corresponding to the extension on TEXTURE and other types of files as described above
  - e.g. All the textures from Too Much Brown pack are under textures/2mbrown
- In order to prevent conflicts, some files have been renamed from their original names
  - Sometimes files have the same name as assets from Doom2.wad and I renamed them so they don't override doom2.wad textures/flats
  - A lot of files conflicted with each other within this texture pack alone. Imagine how many had a generic texture named BRICK or METAL. If you notice random names like GLASS_sof it's because I renamed the GLASS texture that came with the Soldier of Fortune pack so it doesn't conflict with other textures named GLASS.
  - I wrote tools for SLADE to help detect naming conflicts across Texture definitions, Patches, and Flats so you can be sure you don't have any issues in Zdoom
