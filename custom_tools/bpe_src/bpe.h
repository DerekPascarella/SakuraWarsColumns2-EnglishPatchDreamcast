#ifndef BPE_H_
#define BPE_H_

/* Decompress data from input to output */
void expand (FILE *input, FILE *output);

/* Compress from input file to output file */
void compress (FILE *infile, FILE *outfile);

#endif /* BPE_H_ */
