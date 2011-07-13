/*
 * FunkeySynth - A synthesizer application for MeeGo tablets
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
#ifndef CONSTANTS_TYPES_H
#define CONSTANTS_TYPES_H

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define M_PI_PER2 (M_PI/2)

#define SAMPLE_RATE   (44100)
#define MS_IN_SAMPLES ((float)SAMPLE_RATE/1000)
#define FRAMES_PER_BUFFER  (512)

#define BUFFER_SIZE (2048)

#define KEYS_AMOUNT 36
#define KEYS_IN_OCTAVE 12

#define FREQ_C      16.35
#define FREQ_Cis    17.32
#define FREQ_D      18.35
#define FREQ_Dis    19.45
#define FREQ_E      20.60
#define FREQ_F      21.83
#define FREQ_Fis    23.12
#define FREQ_G      24.50
#define FREQ_Gis    25.96
#define FREQ_A      27.50
#define FREQ_Bb     29.14
#define FREQ_B      30.87
#define FREQ_C2     32.70

const float FREQZTABLE[KEYS_IN_OCTAVE] = { FREQ_C, FREQ_D, FREQ_E, FREQ_F,
                                           FREQ_G, FREQ_A, FREQ_B, FREQ_Cis,
                                           FREQ_Dis, FREQ_Fis,
                                           FREQ_Gis, FREQ_Bb };


#endif // CONSTANTS_TYPES_H
