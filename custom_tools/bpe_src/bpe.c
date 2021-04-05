/* Copyright 1994 by Philip Gage */

#include <stdio.h>
#include <string.h>
#include "bpe.h"

int main (int argc, char *argv[])
{
	int mode = -1;

	if (strcmp(argv[1], "compress") == 0)
		mode = 0;
	if (strcmp(argv[1], "expand") == 0)
		mode = 1;

	printf("%s", argv[0]);
	FILE *infile, *outfile;
	if (argc != 4 || mode < 0){
		printf("\n");
		printf("Usage: compress infile outfile\n");
		printf("Usage: expand infile outfile\n");
		return 1;
	} else if ((infile=fopen(argv[2],"rb"))==NULL){
		printf("Error opening input %s\n",argv[2]);
		return 1;
	} else if ((outfile=fopen(argv[3],"wb"))==NULL){
		printf("Error opening output %s\n",argv[3]);
		return 1;
	} else {

		if (mode == 0)
			compress(infile,outfile);
		else if (mode == 1)
			expand(infile,outfile);
		fclose(outfile);
		fclose(infile);
		return 0;
	}
}
