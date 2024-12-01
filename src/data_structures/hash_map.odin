package data_structures
import "core:fmt"
import "core:mem"
import "core:mem/virtual"

Key :: union {
	i64,
	string,
}

//TODO: 1. implement all the functions of a hash map including resize
//resize should be based on the linked list of memory blocks in the growing arena.
//	2. study row and column based data layout in the database internals book.
//check if there is prospect for utilising pages and layout for parallelism(ryan fleury).
HashPool: virtual.Arena

HashMap :: struct {
	entries:  []HashEntry,
	capacity: int,
	size:     int,
}

HashEntry :: struct {
	key:   Key,
	value: i64,
	psl:   int,
	used:  bool,
}


hash_map_init :: proc() -> HashMap {
	//reserve and allocate memory
	if error := virtual.arena_init_growing(&HashPool, 1 * mem.Gigabyte);
	   type_of(error) == mem.Allocator_Error {
		fmt.println(error)
		panic("failed to reserve memory for hashmap")
	}
	//working under the assumption that all the fields of the arena type have been initialized
	//to the default values save for the commited memory

	new_hash_map: HashMap
	//TODO: confirm the best value for capacity to use.
	new_hash_map.capacity = 1000
	new_hash_map.size = 0
	new_hash_map.entries = (HashPool.curr_block.base)

	//study pages and cache locality and their effects on fetching data if any
	//if the pages affect the fetching of data, see how to change page size for windows.
	//set(and cast)? the pointer to our allocated memory to be the []HashEntry field in our HashMap

}
