#ifndef SINBAD_TOON_INCLUDED
#define SINBAD_TOON_INCLUDED

// Define number of toon bands
#ifndef SINBAD_TOON_BANDS
#define SINBAD_TOON_BANDS 3
#endif


// Turn range 0-1 into discrete values, with tolerance smooth transition
// define SINBAD_TOON_BANDS to determine number, default is 3
half SinbadToon(half input, half tolerance)
{
    // Rounded to nearest with tolerance at middle of each band having smooth transition
    half bandSize = 1.0 / SINBAD_TOON_BANDS;
    half midpoint = bandSize * 0.5;
    half hi = midpoint+tolerance;
    half lo = midpoint-tolerance;

	// Bias the input towards light before quantising
	// This makes it look more like the ramp textures we'd normally define
	input = 1.0-pow(1.0-input, 3);

    half sum = 0.0;
    for (int i = 0; i < SINBAD_TOON_BANDS; i++)
    {
        sum += smoothstep(lo, hi, input - (i * bandSize)) * bandSize;
    }
    return sum;

}

#endif
