#include <stdio.h>  // printf
#include <string.h> // strlen

int v[4][3] = {
  /* 
  { 0,  0,  1},
  { 0,  1,  0},
  { 1,  0,  0},
  { 0,  0, -1}
  */
  { 1,  1,  1},
  {-1, -1,  1},
  {-1,  1, -1},
  { 1, -1, -1}
/*
  { 5,  5,  5},
  {-5, -5,  5},
  {-12,  12, -12},
  { 6, -6, -6}
  */
/*
  { 5,  0,  0},
  {0, 5,  0},
  {0,  0, 5},
  { 3, 3, 3}
  */
/*
  { 5,  7},
  {-7,  6},
  { 8, -4},
  {-6, -9}
*/
};
/*
int v[4][2] = {
  { 1,  1},
  {-1,  1},
  { 1, -1},
  {-1, -1}
};
*/

int main(int argc, char **argv) {
  FILE *input;
  char c = '\0';
  int x = 0,
      y = 0,
      z = 0,
      pos = 0,
      skip;
      //write;

  printf("0, 0, 0\n");

  input = fopen(argv[1], "r");
  skip = atoi(argv[3]) - 1;
  while (c != '\n')
    fread(&c, 1, 1, input);
  fread(&c, 1, 1, input);
  while (!feof(input) && (pos < atoi(argv[2]))) {
    //write = 0;
    if (pos >= skip) {
      switch (c) {
        case 'a':
        case 'A':
          x += v[0][0];
          y += v[0][1];
          z += v[0][2];
          //write = 1;
          break;
        case 'c':
        case 'C':
          x += v[1][0];
          y += v[1][1];
          z += v[1][2];
          //write = 1;
          break;
        case 'g':
        case 'G':
          x += v[2][0];
          y += v[2][1];
          z += v[2][2];
          //write = 1;
          break;
        case 't':
        case 'T':
          x += v[3][0];
          y += v[3][1];
          z += v[3][2];
          //write = 1;
      }//switch 
      //if (write)
      printf("%i, %i, %i\n", x, y, z);
      if (!(pos % 5000))
        fprintf(stderr, "set label \"%i\" at %i,%i,%i font \"Symbol,10\"\n", 
                pos, x, y, z);
    }//if
    pos++;
    fread(&c, 1, 1, input);
  }//while

  fclose(input);
  return 0;
}//main
