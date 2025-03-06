#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

int main(){

int i, tid,nthreads;
int j,count;
count=0;
#pragma omp parallel
#pragma omp for private(i,j)
for (i=0; i<40000; i++){
   int sum;
   tid=omp_get_thread_num();
   nthreads=omp_get_num_threads();
   printf("On thread %d of %d, i is %d, count is %d\n",tid,nthreads,i,count);
   sum=i+tid;
   count++;
   for (j=0; j<40; j++ )
       sum += i+j; 
  
   //printf("On thread %d of %d, sum is %d\n",tid,nthreads,sum);
   }

return 0;
}
