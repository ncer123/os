Practical 3 (FcFs)
#include<stdio.h>


int main(){


	int bt[10]={0},at[10]={0},tat[10]={0},wt[10]={0},ct[10]={0}, p[10];
	int n,sum=0,i,j, temp=0;
	float totalTAT=0,totalWT=0;


	printf("Enter number of processes	");
	
	scanf("%d",&n);
	
	printf("enter %d process:",n);
    for(i=0;i<n;i++)
    {
    scanf("%d",&p[i]);
    }


	printf("Enter arrival time and burst time for each process\n\n");


	for(int i=0;i<n;i++)
	{


		printf("Arrival time of process[%d]	",i+1);
		scanf("%d",&at[i]);
		
		printf("Burst time of process[%d]	",i+1);
		scanf("%d",&bt[i]);
		
		printf("\n");
	}
	
	 for(i=0; i<n; i++)
    {
        for(j=0; j<n; j++)
        {
            if(at[i]<at[j])
            {
                temp=at[i];
                at[i]=at[j];
                at[j]=temp;
                temp=bt[i];
                bt[i]=bt[j];
                bt[j]=temp;
               temp=p[j+1]; p[j+1]=p[j]; p[j]=temp;
            }


        }
    }	
	//calculate completion time of processes 	


	for(int j=0;j<n;j++)
	{
		sum+=bt[j];
		ct[j]+=sum;
	}


	//calculate turnaround time and waiting times


	for(int k=0;k<n;k++)
	{
		tat[k]=ct[k]-at[k];
		totalTAT+=tat[k];
	}


	
	for(int k=0;k<n;k++)
	{
		wt[k]=tat[k]-bt[k];
		totalWT+=wt[k];
	}
	
	printf("Solution: \n\n");
	printf("P\t AT\t BT\t CT\t TAT\t WT\t\n\n");
	
	for(int i=0;i<n;i++)
	{
		printf("P%d\t %d\t %d\t %d\t %d\t %d\n",p[i],at[i],bt[i],ct[i],tat[i],wt[i]);
	}
		
	printf("\n\nAverage Turnaround Time = %f\n",totalTAT/n);
	printf("Average WT = %f\n\n",totalWT/n);
	
	return 0;
}



Practical 4
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
    // Write C code here
    fork();
    printf("Process id=%d\n", getpid());

    return 0;
}
--------------
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
//main function begins
int main(){
    pid_t p= vfork(); //calling of fork system call
    if(p==-1)
        printf("Error occured while calling fork()");
    else if(p==0)
        printf("This is the child process with ID=%d\n", getpid());
    else
        printf("This is the parent processwith ID=%d\n", getpid());
    return 0;
}


---------------------



Practical 6

#include <stdio.h>
#include <stdlib.h>
 
// Initialize a mutex to 1
int mutex = 1;
 
// Number of full slots as 0
int full = 0;
 
// Number of empty slots as size
// of buffer
int empty = 10, x = 0;
 
// Function to produce an item and
// add it to the buffer
void producer()
{
    // Decrease mutex value by 1
    --mutex;
 
    // Increase the number of full
    // slots by 1
    ++full;
 
    // Decrease the number of empty
    // slots by 1
    --empty;
 
    // Item produced
    x++;
    printf("\nProducer produces"
           "item %d",
           x);
 
    // Increase mutex value by 1
    ++mutex;
}
 
// Function to consume an item and
// remove it from buffer
void consumer()
{
    // Decrease mutex value by 1
    --mutex;
 
    // Decrease the number of full
    // slots by 1
    --full;
 
    // Increase the number of empty
    // slots by 1
    ++empty;
    printf("\nConsumer consumes "
           "item %d",
           x);
    x--;
 
    // Increase mutex value by 1
    ++mutex;
}
 
// Driver Code
int main()
{
    int n, i;
    printf("\n1. Press 1 for Producer"
           "\n2. Press 2 for Consumer"
           "\n3. Press 3 for Exit");
 
// Using '#pragma omp parallel for'
// can  give wrong value due to
// synchronization issues.
 
// 'critical' specifies that code is
// executed by only one thread at a
// time i.e., only one thread enters
// the critical section at a given time
#pragma omp critical
 
    for (i = 1; i > 0; i++) {
 
        printf("\nEnter your choice:");
        scanf("%d", &n);
 
        // Switch Cases
        switch (n) {
        case 1:
 
            // If mutex is 1 and empty
            // is non-zero, then it is
            // possible to produce
            if ((mutex == 1)
                && (empty != 0)) {
                producer();
            }
 
            // Otherwise, print buffer
            // is full
            else {
                printf("Buffer is full!");
            }
            break;
 
        case 2:
 
            // If mutex is 1 and full
            // is non-zero, then it is
            // possible to consume
            if ((mutex == 1)
                && (full != 0)) {
                consumer();
            }
 
            // Otherwise, print Buffer
            // is empty
            else {
                printf("Buffer is empty!");
            }
            break;
 
        // Exit Condition
        case 3:
            exit(0);
            break;
        }
    }
}
--------------------------


exp 7 bannkers


// Banker's Algorithm  
#include <stdio.h>  
int main()  
{  
    // P0, P1, P2, P3, P4 are the Process names here  
  
    int n, m, i, j, k;  
    n = 5;                         // Number of processes  
    m = 3;                         // Number of resources  
    int alloc[5][3] = {{0, 1, 0},  // P0 // Allocation Matrix  
                       {2, 0, 0},  // P1  
                       {3, 0, 2},  // P2  
                       {2, 1, 1},  // P3  
                       {0, 0, 2}}; // P4  
  
    int max[5][3] = {{7, 5, 3},  // P0 // MAX Matrix  
                     {3, 2, 2},  // P1  
                     {9, 0, 2},  // P2  
                     {2, 2, 2},  // P3  
                     {4, 3, 3}}; // P4  
  
    int avail[3] = {3, 3, 2}; // Available Resources  
  
    int f[n], ans[n], ind = 0;  
    for (k = 0; k < n; k++)  
    {  
        f[k] = 0;  
    }  
    int need[n][m];  
    for (i = 0; i < n; i++)  
    {  
        for (j = 0; j < m; j++)  
            need[i][j] = max[i][j] - alloc[i][j];  
    }  
    int y = 0;  
    for (k = 0; k < 5; k++)  
    {  
        for (i = 0; i < n; i++)  
        {  
            if (f[i] == 0)  
            {  
                int flag = 0;  
                for (j = 0; j < m; j++)  
                {  
                    if (need[i][j] > avail[j])  
                    {  
                        flag = 1;  
                        break;  
                    }  
                }  
                if (flag == 0)  
                {  
                    ans[ind++] = i;  
                    for (y = 0; y < m; y++)  
                        avail[y] += alloc[i][y];  
                    f[i] = 1;  
                }  
            }  
        }  
    }  
    int flag = 1;  
    for (int i = 0; i < n; i++)  
    {  
        if (f[i] == 0)  
        {  
            flag = 0;  
            printf("The following system is not safe");  
            break;  
        }  
    }  
    if (flag == 1)  
    {  
        printf("Following is the SAFE Sequence\n");  
        for (i = 0; i < n - 1; i++)  
            printf(" P%d ->", ans[i]);  
        printf(" P%d", ans[n - 1]);  
    }  
    return (0);  
}  

---------------------------------

exp 8 fifo
#include<stdio.h> 
int main()
{
    int incomingStream[] = {4, 1, 2, 4, 5};
    int pageFaults = 0;
    int frames = 3;
    int m, n, s, pages;

    pages = sizeof(incomingStream)/sizeof(incomingStream[0]);

    printf("Incoming \t Frame 1 \t Frame 2 \t Frame 3");
    int temp[frames];
    for(m = 0; m < frames; m++)
    {
        temp[m] = -1;
    }

    for(m = 0; m < pages; m++)
    {
        s = 0;

        for(n = 0; n < frames; n++)
        {
            if(incomingStream[m] == temp[n])
            {
                s++;
                pageFaults--;
            }
        }
        pageFaults++;
        
        if((pageFaults <= frames) && (s == 0))
        {
            temp[m] = incomingStream[m];
        }
        else if(s == 0)
        {
            temp[(pageFaults - 1) % frames] = incomingStream[m];
        }
      
        printf("\n");
        printf("%d\t\t\t",incomingStream[m]);
        for(n = 0; n < frames; n++)
        {
            if(temp[n] != -1)
                printf(" %d\t\t\t", temp[n]);
            else
                printf(" - \t\t\t");
        }
    }

    printf("\nTotal Page Faults:\t%d\n", pageFaults);
    return 0;
}
-----------------------

exp 9 best fit

#include <stdio.h>
void implimentBestFit(int blockSize[], int blocks, int processSize[], int processes)
{
// This will store the block id of the allocated block to a process
int allocation[processes];
// initially assigning -1 to all allocation indexes
// means nothing is allocated currently
for(int i = 0; i < processes; i++){
allocation[i] = -1;
}
// pick each process and find suitable blocks
// according to its size ad assign to it

for (int i=0; i<processes; i++)
{
int indexPlaced = -1;
for (int j=0; j<blocks; j++)
{
if (blockSize[j] >= processSize[i])
{
// place it at the first block fit to accomodate process
if (indexPlaced == -1)
indexPlaced = j;
// if any future block is better that is
// any future block with smaller size encountered
// that can accomodate the given process
else if (blockSize[j] < blockSize[indexPlaced])
indexPlaced = j;
}
}
// If we were successfully able to find block for the process
if (indexPlaced != -1)
{
// allocate this block j to process p[i]
allocation[i] = indexPlaced;
// Reduce available memory for the block
blockSize[indexPlaced] -= processSize[i];
}
}
printf("\nProcess No.\tProcess Size\tBlock no.\n");
for (int i = 0; i < processes; i++)
{
printf("%d \t\t\t %d \t\t\t", i+1, processSize[i]);
if (allocation[i] != -1)
printf("%d\n",allocation[i] + 1);
else
printf("Not Allocated\n");
}
}
// Driver code
int main()
{
int blockSize[] = {50, 20, 100, 90};
int processSize[] = {10, 30, 60, 30};
int blocks = sizeof(blockSize)/sizeof(blockSize[0]);
int processes = sizeof(processSize)/sizeof(processSize[0]);
implimentBestFit(blockSize, blocks, processSize, processes);
return 0 ;
}

