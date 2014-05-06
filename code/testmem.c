#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define ELEM_TYPE int
#define ELEM_VALUE 1

#define STA_ELEMS 2000000

void display_stack_info() {
	int dummy;

	printf("The top of the stack is at about: 0x%x\n", (uintptr_t)&dummy);
}

int main(int argc, char **argv) {

	int dyn_elems = 1;
	int i;
	ELEM_TYPE *p;
	ELEM_TYPE a[STA_ELEMS];

	if (argc != 2)
		return 1;

	dyn_elems = atoi(argv[1]);

	p = (ELEM_TYPE *)malloc(sizeof(ELEM_TYPE)*dyn_elems);
	for (i = 0; i < dyn_elems; i++) {
		p[i] = ELEM_VALUE;
	}

	printf("Element size: %d\n", sizeof(ELEM_TYPE));
	printf("First dynamically allocated element's location: 0x%x\n", (uintptr_t)p);
	printf("Last dynamically allocated element's location: 0x%x\n", (uintptr_t)&p[dyn_elems-1]);
	printf("Heap size: ~%d bytes\n", sizeof(ELEM_TYPE)*dyn_elems);
	display_stack_info();
	
	return 0;
}
