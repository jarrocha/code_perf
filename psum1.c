/*
 * psum : This program was used to demonstrate compiler and manual
 *	   optimization.
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define OP +

struct vec {
	long int len;
	long int result;
	int *data;
};


long int vec_length(struct vec* v)
{
	return v->len;
}


void combine1(struct vec* v)
{
	long int i, dest;
	int val;

	for (i = 0; i < vec_length(v); i++) {
		get_vec_element(v, i, &val);
		dest = dest OP val;
	}
	v->result = dest;
}


int get_vec_element(struct vec * v, long int index, int* dest)
{
	if (index < 0 || index >= v->len)
		return 0;
	*dest = v->data[index];
	return 1;
}


struct vec * new_vec(long int len)
{
	int i;
	int *dat_ptr;

	struct vec *alloc = malloc(sizeof(struct vec));
	if(!alloc) {
		printf("Error allocating\n");
		exit(EXIT_FAILURE);
	}
	alloc->len = len;
	if (len > 0) {
		alloc->data = malloc(len * sizeof(int));
		if (alloc->data == NULL) {
			free((void *) alloc);
			printf("Error allocating data\n");
			exit(EXIT_FAILURE);
		}
	}
	dat_ptr = alloc->data;
	for (i = 0; i < len; i++)
		*(dat_ptr + i) = rand() % 10 + 1;

	return alloc;
}


int main()
{
	long int num;
	struct vec *vec_ptr;
	srand(time(NULL));

	printf("Enter size of array: ");
	scanf("%ld", &num);
	printf("User entered %ld\n", num);
	vec_ptr = new_vec(num);
	combine1(vec_ptr);

    	printf("Final result %ld\n", vec_ptr->result);
	
	free(vec_ptr);
	return(EXIT_SUCCESS);
}


