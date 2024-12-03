package main

import "core:fmt"
import "core:log"
import "core:os"
import hs "data_structures"


no_of_elements: int : 1000

main :: proc() {
	//NOTE: the logger logs errors to the file before returning.
	//errors are handled by the calling function by just exiting/ returning from main.
	diatira_logs: os.Handle
	context.logger = log.create_file_logger(diatira_logs)

	hash, mem := hs.Hash_map_init(i128, no_of_elements)
	//hash.size = 3
	//hash.capacity = no_of_elements
	fmt.println(hash, mem)

}
