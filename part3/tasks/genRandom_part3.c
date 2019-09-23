#include <stdio.h>
#include <time.h>
#include <math.h>

float sq_root(int in_num) {
	float root, var;
	root = in_num/2;
	var = 0;

	while(root != var) {
		var = root;
		root = in_num/var;
		root = root + var;
		root = root/2;
	}
	return root;
}

int main() {
  int desiredInputs = 1000;
  srand(time(NULL)); // Set random seed based on current time

  FILE *inputData, *expectedOutput;

  inputData = fopen("inputDataPart3", "w");
  expectedOutput = fopen("expectedOutputPart3", "w");

  fprintf(expectedOutput, "0\n0\n0\n"); // To match output file

  int i, a, b, c;
  int sum = 0;
  float root=0;
  int root_int=0;

  for (i=0; i<desiredInputs; i++) {
    a = rand() % 256;
    b = rand() % 2;
    fprintf(inputData, "%x\n", a);
    fprintf(inputData, "%x\n", b);
    a = a*a;
    if (b==1) {
    	sum = sum + a;
	root = sq_root(sum);
	root_int = root/1;
    }
    fprintf(expectedOutput, "%x\n", root_int);
  }

  fclose(inputData);
  fclose(expectedOutput);
}
