# nkonotes-cli
A simple note taking suite for the CLI made for practice with TCL.

## File List
- **nkonotes_enter.tcl** is used to create new notes. All notes are, of course, text-only.
- **nkonotes_view.tcl** is used to display a specific note. Note is referenced by index. Multiple index IDs can be specified and each note will be displayed in the order they were specified.
- **nkonotes_search.tcl** is used to search the text of notes for a search term.
- **nkonotes.tcl** is all three of the above put together but each file is thrown into a procedure, so it's all in one file. To use any of the above functions, just pass it as the first argument (e.g., "nkonotes.tcl enter" or "nkonotes.tcl search" or "nkonotes.tcl view").

Notes are stored in a file, ~/nkonotes.txt. Each note is represented as a single line with an index number, a space, and then the text of the note.
