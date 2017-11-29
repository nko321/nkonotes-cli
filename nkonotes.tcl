#nkonotes.tcl

proc nkonotes_enter {input} {
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
	nkonotes_add_metadata $linecount "CreatedDateTime" "[clock format [clock seconds] -format "%Y-%m-%d.%H:%M:%S-%Z"]"
}

proc nkonotes_search {input} {
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

proc nkonotes_view {input} {
	set linecount 0

	# End the script now if we don't even have a file to display from.
	if {![file exists ~/nkonotes.txt] } {puts "No NKONotes file detected."; exit;}

	# Got a file to look at? Good, let's do it!
	set filehandle [open ~/nkonotes.txt r]
	set filedata [read $filehandle]
	set linelist [split $filedata \n]
	foreach searchind [lrange $input 0 [llength $input]] {
		foreach line [lrange $linelist 0 [llength $linelist]] {
			if {[string match -nocase $searchind [lindex $line 0]]} {puts $line}
		}
		incr linecount
	}
	close $filehandle
}

proc nkonotes_add_metadata {index key value} {
	if {![string equal [lindex $key 0] $key]} {
		puts "Metadata key \"$key\" contains whitespace. Trimming to end of first word."
		set key [lindex $key 0]
	}
	if {![file exists ~/nkonotes.txt]} {puts "No NKONotes file detected. Creating file..."}
	set filehandle [open ~/nkonotes_metadata.txt a+]
	puts $filehandle "$index $key $value"
	close $filehandle
	puts "Metadata added: $index $key \"$value\"."
}

proc nkonotes_search_metadata_by_index {index} {
	set filehandle [open ~/nkonotes_metadata.txt r]
	while { [gets $filehandle line] >= 0 } {
		if {![string first $index [lindex $line 0]]} {puts $line}
		incr linecount
	}
	close $filehandle
}

if {[string match [lindex $argv 0] "enter"]} {
	puts "Enter text for new note:"
	gets stdin input
	nkonotes_enter $input
}

if {[string match [lindex $argv 0] "search"]} {
	puts "Enter search terms:"
	gets stdin input
	nkonotes_search $input
}
if {[string match [lindex $argv 0] "view"]} {
	puts "Enter note IDs (space separated):"
	gets stdin input
	nkonotes_view
}

if {[string match [lindex $argv 0] "search_metadata_by_index"]} {
	puts "Enter note ID to find all related metadata (space separated):"
	gets stdin input
	nkonotes_search_metadata_by_index $input
HELLO NADIA}
