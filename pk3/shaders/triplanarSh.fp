/**
 * Shader that does triplanar mapping which should be great for natural terrain textures
 * The UVs are procedurally determined based on world coordinates so caves, mountains, etc automatically look good
 * This can be very useful for Doom where it's otherwise difficult or nearly impossible to align walls and flats
 * At the moment it's built to take the passed in texture and triplanar map it.
 *
 * Made with the help of these articles: 
 * https://www.martinpalko.com/triplanar-mapping/#The%20Theory
 * https://www.ronja-tutorials.com/post/010-triplanar-mapping/
 *
 * Future versions or variations might get more advanced, and you could make snowy mountains for example, by having top facing normals use a snow texture
 * 
 * Usage: Add to gldefs as explained here: https://zdoom.org/wiki/GLDEFS
 *
 * You can add either a worldScale define or uvScale define
 * By default it acts as if you passed worldScale 1.0
 * worldScale 1.0 will try to map the texture as closely to how doom would map it as possible in doom's world coordinates
 * Other values will multiply the scale
 *
 * uvScale won't take world scale into account and will just base UV's one to one with world position, so you may want very low values like .001 to look good.
 * uvScale is slightly more optimized since there's no division by texture size
 *
 * e.g.
 * material texture "textures/ogrodtex/OGRIDRST_triplanar.png"
 * {
 *   shader "shaders/triplanar.fp"
 *   define worldScale = 2
 * }
 */

vec4 Process(vec4 color)
{
    vec2 uvScaleActual =
#ifdef uvScale
        vec2(uvScale);
#else

#ifndef worldScale
#define worldScale 1.0
#endif
        //to sample the texture in "DooM" world units we divide by its size
        1.0 / textureSize(tex, 0) * worldScale;
#endif

    vec3 normals = normalize(vWorldNormal.xyz);
    vec3 blendWeights = abs(normals);

    // sharpness
#ifdef sharpness
    blendWeights = vec3(
        pow(blendWeights.x, sharpness),
        pow(blendWeights.y, sharpness),
        pow(blendWeights.z, sharpness));
#endif

    // make it so the sum of all components is 1
    blendWeights /= blendWeights.x + blendWeights.y + blendWeights.z;
    
    // Z normal faces north/south
    // Y normal faces floor/ceiling or up/down
    // X normal faces east/west

    // Floor / Ceiling need to sample in the -v direction
    // Walls sample in the -v direction as well, but also flip u depending on facing direction to more roughly match doom's texture mapping

    vec2 northSouthUVs = pixelpos.xy * vec2(sign(-normals.z), -1.0) * uvScaleActual;
    vec2 floorCeilUVs = pixelpos.xz * vec2(1.0, -1.0) * uvScaleActual;
    vec2 eastWestUVs = pixelpos.zy * vec2(sign(normals.x), -1.0) * uvScaleActual;

    return
        // North / South
        getTexel(northSouthUVs) * blendWeights.z
        // Floor / Ceiling
        + getTexel(floorCeilUVs) * blendWeights.y
        // East / West
        + getTexel(eastWestUVs) * blendWeights.x;

    // In the future, if more textures are used for other material components, sample them in a similar way
    // Future versions can also sample a totally different texture for Floor, for example, to add snow or grass to tops of hills
    // You could also sample different textures based on elevation in world coordinates, so high peaks are snowy while low areas are grassy
}
