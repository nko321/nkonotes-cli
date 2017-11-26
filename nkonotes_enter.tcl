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