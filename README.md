# Allegro

Swift music theory.

Equal temperament is used throughout.

## Pitches and Chords

The chroma of a note, independent of octave, is represented by the `PitchClass` struct.  A `PitchClass` is specified by a number of semitones above an arbitrary base, which we call `C`.  Public constants are provided for all the natural pitches (C, D, E, F, G, A, B). Accidentals can be reached using the `flat` and `sharp` methods, or the postfix operators `♯` and `♭`.

A concrete pitch in an octave is the `Pitch` struct, which can be subscripted from a `PitchClass`.  Pitches and pitch classes can be transposed up and down by semitones or `Interval`s.

```swift
A[4]
C.sharp[3]
A[4].transposed(up: Interval.MajorThird)
A[5].transposed(semitones: -3)
```

A combination of pitches is called a `Chord`, which can be constructed explicitly or using the `|` operator.

```swift
let triad = Chord([ C[4], E[4], G[4] ])
let triad = C[4] | E[4] | G[4]
```

## Durations, Notes, ChordedNotes

The `Duration` struct describes durations with abstract length units.  There are constants and Unicode symbols for the base durations, and more can be created with the `dotted`, `triplet`, and `tuplet` methods.  Arithmetic operators work on durations, too.  

These are all equivalent:

```swift
Duration.Quarter
𝅘𝅥
𝅘𝅥𝅮+𝅘𝅥𝅮
Duration.Eighth * 2
3 * 𝅘𝅥𝅮.triplet
3 * 𝅘𝅥𝅮.tuplet(3)
```

A pitch with a duration is called a `Note`.  A chord with a duration is called a `ChordedNote`.  The division operator can be used to create these -- divide by 4 to create a quarter note, etc.  These are all equivalent:

```swift
Note(pitch: C[4], duration: Duration.Quarter)
C[4].note(Duration.Quarter)
C[4].note(𝅘𝅥)
C[4]/4
```

Rests:

```swift
R/4
Rest(Duration.Quarter)
Duration.Quarter.rest
𝄽
```

## Scales

A Scale is defined by a tonic `PitchClass` and an array of `Interval`s.  Here, subclasses define the intervals, and instances specify the tonic.

Concrete subclasses include:
* `ChromaticScale`
* `MajorScale`
* `NaturalMinorScale`
* `HarmonicMinorScale`

Scales all provide a number of methods for interacting with pitches and chords.  You can get all pitch classes, get all pitches starting in an octave, find the scale degree of a pitch, and build triads from scale degrees.

```swift
C.majorScale.dominant
// --> G
```

## Expressions

Any musical object that conforms to the `Expression` protocol has a duration, and can be combined into larger (recursive) groupings:

* `SequenceExpression`: All subexpressions are performed in sequence, one after the other.
* `ParallelExpression`: Each subexpression should start playing at the same time.

The `+` operator combines expressions into SequenceExpressions.  You can also use `*`, but be careful with precedence:

```swift
let phrase = C[4]/4 + C[4]/4 + G[4]/4 + G[4]/4
let phrase = 2 * (C[4]/4) + 2 * (G[4]/4)
let phrase = C[4]/4 * 2 + G[4]/4 * 2
```

The `|` operator combines expressions into ParallelExpressions:

```swift
let music = (A[4]/4 + B[4]/4) | A[2]/2
```

## Performance

`Performer` objects know how to realize any `Expression`.  Currently, there's only `SamplerInstrument`, which plays MIDI notes using a Soundfont that you specify.

```swift
let piano = SamplerInstrument(filename: "AJH_Piano", patchNumber: 0)!
let music = A[4]/4 + B[4]/4 + C[5]/4 + D[5]/4
piano.play(music)
```

A `SamplerInstrument` has a `Tempo` property, which defaults to 100 quarter notes per minute.
