package data_structures
import "core:fmt"
import "core:mem"
import "core:mem/virtual"
//import "memory"

Key :: union {
	i64,
	string,
}

//TODO: 1. implement all the functions of a hash map including resize
//resize should be based on the linked list of memory blocks in the growing arena.
//	2. study row and column based data layout in the database internals book.
//check if there is prospect for utilising pages and layout for parallelism(ryan 

HashMap :: struct(value_t: typeid) {
	entries:  []HashEntry(typeid),
	capacity: int,
	size:     int,
}

HashEntry :: struct($value_t: typeid) {
	key:   Key,
	value: value_t,
	psl:   int,
	used:  bool,
}

@(require_results)
Hash_map_init :: proc($T: typeid, initial: int) -> (HashMap(typeid), ^T) {

	Pool: virtual.Arena
	nil_hash: HashMap(typeid)


	if error := virtual.arena_init_growing(&Pool, 1 * mem.Gigabyte);
	   error != mem.Allocator_Error.None {
		fmt.println(error)
		return nil_hash, (^T)(Pool.curr_block.base)
	}

	return HashMap(typeid) {
		capacity = 1 * mem.Gigabyte / size_of(HashEntry(typeid)),
		size = initial,
	}, (^T)(Pool.curr_block.base)

}

//have an init size for the initial commit memory. e.g 1000 does 1000 * mem.size_of(HashEntry)
//
