/*This is an edited version of "GoodCompare.c" which was formerly used
 * to compare lammps and gulp atomic positions and bond lengths. It will
 * now be used just to look at lammps bond lengths
 */

#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int compaare(const void *p1, const void *p2);
FILE *safe_open	( const char *filename , const char *mode );
double Distance (  double x1, double y1, double z1, double x2, double y2, double z2  );
FILE *SkipTo( FILE *fptr , const char *command , char cmdline[] );


struct atoms{
	char name[8];
	int atID;
   int type;
	double x;
	double y;
	double z;
};


int main( int argc, char** argv )
{
double aL, bL, cL; 														//These hold the Lammps final lattice constants a, b and c
char LmpLog[80], LmpDump[80],Gulp[80];								//These hold the strings which contain the names of the Lammps run output and the lammps dump file.								
char line[80];												            //Gulp holds the name of the gulp output file, line is just a string which we will use to store read in strings while we do things with them. It's contents will change as we go through the file.
FILE *fptr,*fout ;														//These two file pointers will be used to have two files open, one for reading and one for writing at the same time.
int step;																   //This will hold the final timestep from the dump file, so that we know where to look to get the final atomic and cell coords.
int natoms;																   //This holds the number of atoms in the simulations of the lammps and gulp outputs.
int i;													               //i is just an integer to use in loops. read_bin_int is just a variable to hold a position in a fscanf for an integer we don't need to use.
int nbonds,nangles;														//These are the number of bonds and angles in the system.
char name1[80], name3[80],LmpData[60];
char trash[80];
double trshD;															//This is just a place holder to use in fscanfs etc.
double rBondLammps, ravg,rmax,rmin,vmax;
double x1_unwrapped, y1_unwrapped, z1_unwrapped;
double x2_unwrapped, y2_unwrapped, z2_unwrapped;
double *xL, *yL, *zL;
struct bond *bondptr; 
struct bond *usrptr;
double cutoff=2.4;
int f1,f2,f3;

if (argc!=4)
{
printf("\nProgram Called Incorrectly\n");
printf("usage: %s LammpsLogFile supercell_corr2.dat LammpsDumpFile\n\n",argv[0]);
return -1;
}


sprintf( LmpLog  , argv[1] );	     //These are the lammps results to be read from.
sprintf( LmpDump , argv[3] );		  //This is the lammps dump file that will be read from.
sprintf( Gulp    , argv[2] );		  //This is the gulp input sheet to be read from.


/*----------------------------------------------------------------------
*- Get time step from log.lammps--------------------------------------*/

fptr = safe_open( LmpLog, "r" );

//There are three minimisations, you want step of last minimise
fptr = SkipTo( fptr, "Step", line );
puts(line);
fptr = SkipTo( fptr, "Step", line );
puts(line);
fptr = SkipTo( fptr, "Step", line );
puts(line);

fgets(line, 80, fptr);
sscanf( line, "\t%d %lf %lf %lf %lf " , &step, &trshD, &trshD, &trshD, &trshD );

fgets(line,80, fptr);
puts(line);
sscanf( line, "\t%d %lf %lf %lf %lf " , &step, &trshD, &trshD, &trshD, &trshD );
printf("step is %d\n",step);
fclose(fptr);

/*-----------------------------------Read Final Atomic Coords---------------------------------------------------------*/

//Skip to final timestep
i=0;
fptr = safe_open( LmpDump, "r" );
int t =0;
while ( t !=step && i<500 )
   {
   fptr = SkipTo ( fptr, "ITEM: TIMESTEP", line );    
   fscanf( fptr, "%d\t" , &t );
   printf("%d\n",t);
   i++;
   }
	
printf("\nThe final timestep is %d\n",t);



//Read number of atoms and declare arrays of appropriate size

fgets(line, 80 , fptr); //This reads the line ITEM: NUMBER OF ATOMS 
puts(line);

fscanf( fptr, "%d", &natoms );
printf("\n\nThere are %d atoms\n\n",natoms);

struct atoms *LmpAtoms;

LmpAtoms  = ( struct atoms * ) malloc( natoms*sizeof(struct atoms) );
xL = (double*) malloc( natoms*sizeof(double) );
yL = (double*) malloc( natoms*sizeof(double) );
zL = (double*) malloc( natoms*sizeof(double) );



//Record final lammps coords

//Skip again to ITEM ATOMS
fptr = SkipTo ( fptr,"ITEM: ATOMS", line );

//Read In Atomic Coordinates
for (i=0;i<natoms;i++)
	fscanf( fptr, "%d %lf %lf %lf", &LmpAtoms[i].atID, &LmpAtoms[i].x,&LmpAtoms[i].y,&LmpAtoms[i].z );
        

printf("Sort\n");
qsort( LmpAtoms, natoms, sizeof(struct atoms), compaare );

		
fclose(fptr);
/*--------------------------------------------------------------------*/

/*--------------------Now get final lattice coords from end of file-----------------------------------------*/

fptr = safe_open( LmpLog, "r" );

fptr = SkipTo ( fptr,"a= ", line );
sscanf( line,"%s %lf", trash, &aL );
fptr = SkipTo ( fptr,"b= ", line );
sscanf( line,"%s %lf", trash, &bL );
fptr = SkipTo ( fptr,"c= ", line );
sscanf( line,"%s %lf", trash, &cL );


printf("The final Lammps lattice constants are: \n%lf\n%lf\n%lf\n\n",aL,bL,cL);

fclose(fptr);

/*---------------------------------------------------------------------
/*----------------------------------------------------------------------
*---------------------------------------------------------------------*
*---------------------------------------------------------------------*/
/*----------Get Names from .gin or supercellcorr2 File----------------*/
/*--------------------------------------------------------------------*/

fptr = safe_open( Gulp , "r" );	

fptr = SkipTo( fptr , "frac" , line);
	
//The string cmdline now contains the line starting with "frac" and the pointer
//fptr is now pointing at the first line after frac, i.e. at the atomic data.
//So we must read in this data.
												
for ( i= 0; i<natoms ; i++)
	fscanf(fptr,"%s %lf %lf %lf %d %d %d",LmpAtoms[i].name, &vmax,&vmax,&vmax,&f1,&f2,&f3);
	
printf("\n\n");
fclose( fptr );

/*--------------------------------------------------------------------*/
/*----------------------------------------------------------------------
*Out put of lammps results in Stefan Friendly Format------------------*/

fout = safe_open( "positions.dat", "w" );
for( i=0; i< natoms; i++ ){
	fprintf(fout,"%8d  %8s\t  c\t %lf\t%lf\t%lf\t0.00\n",i+1,LmpAtoms[i].name,(LmpAtoms[i].x)/aL, (LmpAtoms[i].y)/bL , (LmpAtoms[i].z)/cL );
	printf("%d\t%20.9lf\t%20.9lf\t%20.9lf\n", LmpAtoms[i].atID, LmpAtoms[i].x,LmpAtoms[i].y,LmpAtoms[i].z );
	}
fprintf(fout,"\n\n  Final cell parameters and derivatives :\n\n");
fprintf(fout,"\n\n--------------------------------------------------------------------------------\n");
fprintf(fout,"a= %20.9lf\n",aL);
fprintf(fout,"b= %20.9lf\n",bL);
fprintf(fout,"c= %20.9lf\n",cL);
fclose( fout );

/*--------------------------------------------------------------------*/


return 0;
	
}


								/*FUNCTION DEFINITIONS*/
/*-------------------------------------------------------------------------------------------------------------------*/



	
FILE *safe_open( const char *filename , const char *mode)
{
	/*This function is more or less just fopen with some added safety features
	* the mode here is the same mode in fopen, where r is for read, w is for write,
	* rb is for read binary, wb is for write binary. The arguments work the exact same
	* as fopen. */
	
	FILE *fptr;
	
	if( ( fptr = fopen ( filename, mode) ) == NULL )        
		{
		puts ( "Cannot open input file " );
		puts ( filename ) ;
		exit( 1 );
		}
return fptr;
}



FILE *SkipTo( FILE *fptr , const char *command , char cmdline[] )
{
/* The char array cmdline[] contains the last string read in by the function, which should be the string which
 * starts with the letters of "command" */		
int i,size,yes;
size = (int) ( strlen(command) );

while(fgets ( cmdline,80, fptr ) != NULL )
	{
	yes =0;
	for (i=0; i < size ;i++)
		if ( cmdline[i] == command[i] )
			yes++;
	if ( yes == size )
		break;
	}
	
return fptr;	
}



double Distance ( double x1, double y1, double z1, double x2, double y2, double z2 ) //Function to calculate distances between two different atoms
{
return sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) + (z1-z2)*(z1-z2) );
}





int compaare(const void *p1, const void *p2)
{
   const struct atoms *elem1 = p1;    
   const struct atoms *elem2 = p2;
   return (int)(elem1->atID - elem2->atID);
}







