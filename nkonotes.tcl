#nkonotes.tcl

proc nkonotes_enter {} {
	puts "Enter text for new note:"
	gets stdin input

	set linecount 0

	if { [file exists ~/nkonotes.txt] } {
		# Read in the last entry's index ID
		# TODO: Wrap this in a try / catch thingie
		set filehandle [open ~/nkonotes.txt r]
		while { [gets $filehandle line] >= 0 } {
			incr linecount
		}
		close $filehandle
	} else {
		puts "No NKONotes file detected. Creating file..."
	}
	set filehandle [open ~/nkonotes.txt a+]
	puts $filehandle "$linecount $input"
	close $filehandle
	puts "Note added. Note index is $linecount."
}

proc nkonotes_search {} {
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
}

proc nkonotes_view {} {
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
}

if {[string match [lindex $argv 0] "enter"]} {nkonotes_enter}
if {[string match [lindex $argv 0] "search"]} {nkonotes_search}
if {[string match [lindex $argv 0] "view"]} {nkonotes_view}