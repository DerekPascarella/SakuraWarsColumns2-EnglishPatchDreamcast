/* expand.c */
/* Copyright 1994 by Philip Gage */
/* source "A New Algorithm for Data Compression" - Philip Gage 1994 */

#include <stdio.h>

/* Decompress data from input to output */
void expand (FILE *input, FILE *output)
{
	unsigned char left[256], right[256], stack[30];
	short int c, count, i, size;
	/* Unpack each block until end of file */
	while ((count = getc(input)) != EOF) {

		/* Set left to itself as literal flag */
		for (i = 0; i < 256; i++)
			left[i] = i;

		/* Read pair table */
		for (c = 0;;) {

			/* Skip range of literal bytes */
			if (count > 127) {
				c += count - 127;
				count = 0;
			}
			if (c == 256) break;

			/* Read pairs, skip right if literal */
			for (i = 0; i <= count; i++, c++) {
				left[c] = getc(input);
				if (c != left[c])
					right[c] = getc(input);
			}
			if (c == 256) break;
			count = getc(input);
		}

		/* Calculate packed data block size */
		size = 256 * getc(input) + getc(input);

		/* Unpack data block */
		for (i = 0;;) {

			/* Pop byte from stack or read byte */
			if (i)
				c = stack[--i];
			else {
				if (!size--) break;
				c = getc(input);
			}

			/* Output byte or push pair on stack */
			if (c == left[c])
				putc(c,output);
			else {
				stack[i++] = right[c];
				stack[i++] = left[c];
			}
		}
	}
}
