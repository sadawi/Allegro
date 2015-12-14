# Allegro

Swift music theory.

## Pitches

The chroma of a note, independent of octave, is represented by the `PitchClass` struct.  A `PitchClass` is defined as a number of semitones above an arbitrary base, which we call `C`.  Public constants are provided for all the natural pitches (C, D, E, F, G, A, B). Accidentals can be reached using the `flat` and `sharp` methods, or the postfix operators `♯` and `♭`.

A concrete pitch in an octave is the `Pitch` struct, which can be subscripted from a `PitchClass`.  Pitches and pitch classes can be transposed up and down by semitones or `Interval`s.

```swift
A[4]
C.sharp[3]
A[4].transposed(up: Interval.majorThird)
A[5].transposed(semitones: -3)
```

## Notes and Chords

## Scales
