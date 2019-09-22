#include <stdio.h>
#include <time.h>
#include <math.h>

float sq_root(int number) {
	float temp, sqrt;
	sqrt = number/2;
	temp = 0;

	while(sqrt != temp) {
		temp = sqrt;
		sqrt = (number/temp + temp)/2;
	}
}

int main() {
  int desiredInputs = 1000;
  srand(time(NULL)); // Set random seed based on current time

  FILE *inputData, *expectedOutput;

  inputData = fopen("inputDataPart3", "w");
  expectedOutput = fopen("expectedOutputPart3", "w");

  fprintf(expectedOutput, "0\n0\n"); // To match output file

  int i, a, b, c;
  int sum = 0;
  float root;

  for (i=0; i<desiredInputs; i++) {
    a = rand() % 256;
    fprintf(inputData, "%x\n", a);
    a = a*a;
    sum = sum + a;
    root = sq_root(sum);
    fprintf(expectedOutput, "%x\n", floor(root));
  }

  fclose(inputData);
  fclose(expectedOutput);
}
