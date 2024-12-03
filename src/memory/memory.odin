package memory

import "core:mem/virtual"

Memory :: struct {
	chunks: [^]virtual.Memory_Block,
}
