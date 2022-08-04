# Compile and Run the Melisma Music Temperley

The original software was written by David Temperley, Daniel Sleator, and Craig Sapp.

The Melisma Music Analyzer, among other things, performs Automatic Roman Numeral Analysis.

The end-to-end workflow for processing a score in Humdrum format requires several components
- The `melisma2003` codebase with
    - a `harmony` program
    - a `key` program
    - a `meter` program
- Two utility scripts for processing the scores
    - `harmony2humdrum`
    - `key2humdrum`
- The `humextra` codebase, particularly
    - the `tsroot` program

This `Dockerfile` downloads everything, compiles, and gets it working.

## Run

Build the image

```
docker build . -t melisma
```

Run

```
docker run melisma
```
