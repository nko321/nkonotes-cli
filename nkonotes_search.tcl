puts "Enter search terms:"
gets stdin input

set linecount 0

# End the script now if we don't even have a file to display from.
if {![file exists ~/nkonotes.txt] } {puts "No NKONotes file detected."; exit;}

# Got a file to look at? Good, let's do it!
set filehandle [open ~/nkonotes.txt r]
while { [gets $filehandle line] >= 0 } {
	foreach searchterm [lrange $input 0 [llength $input]] {
		if {[string first $searchterm $line] ne -1} {puts $line}
	}
	incr linecount
}
close $filehandle
