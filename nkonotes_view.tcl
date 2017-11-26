puts "Enter note IDs (space separated):"
gets stdin input

set linecount 0

# End the script now if we don't even have a file to display from.
if {![file exists ~/nkonotes.txt] } {puts "No NKONotes file detected."; exit;}

# Got a file to look at? Good, let's do it!
set filehandle [open ~/nkonotes.txt r]
set filedata [read $filehandle]
set linelist [split $filedata \n]
foreach searchind [lrange $input 0 [llength $input]] {
	foreach line [lrange $linelist 0 [llength $linelist]] {
		if {[string match $searchind [lindex $line 0]]} {puts $line}
	}
	incr linecount
}
close $filehandle
