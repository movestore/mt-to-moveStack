# Move2Mt to MoveStack

MoveApps

Github repository: *github.com/movestore/mt-to-moveStack*

## Description
Back-transformation of the new move2 mt (movement trajectory) object to MoveStack. To be used during transition period 2023.

## Documentation
Since the move2 mt objects is allowed to contain zero locations, this App gives back a NULL moveStack in that case. Else it transforms the object to a moveStack, also forcing single move objects (i.e. mt objects with one track) into moveStack for performant runs in MoveApps.

### Input data
Move2 movement trajectory (mt)

### Output data
MoveStack in Movebank format

### Artefacts
none

### Parameters 
none
### Null or error handling
**data:** All parts of the mt object are transformed. If it contains zero locations, NULL is returned. Else a MoveStack containing one or more move objects (i.e. tracks).
