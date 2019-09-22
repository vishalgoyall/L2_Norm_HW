#include <stdio.h>
#include <time.h>

int main() {
  int desiredInputs = 1000;
  srand(time(NULL)); // Set random seed based on current time

  FILE *inputData, *expectedOutput;

  inputData = fopen("inputDataPart2", "w");
  expectedOutput = fopen("expectedOutputPart2", "w");

  fprintf(expectedOutput, "0\n0\n"); // To match output file

  int i, a, b, c;
  int sum = 0;

  for (i=0; i<desiredInputs; i++) {
    a = rand() % 256;
    fprintf(inputData, "%x\n", a);
    a = a*a;
    sum = sum + a;
    fprintf(expectedOutput, "%x\n", sum);
  }

  fclose(inputData);
  fclose(expectedOutput);
}
