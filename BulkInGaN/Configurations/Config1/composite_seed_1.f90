program composite

! This program selects different areas of several random WZ supercells and creates a composite
! supercell using the parts of interest of the original cells

  implicit none

  integer :: n1, n2, n3, i, j, k, istart, ifinal, kstart, kfinal, diskstart, diskfinal, atom1id, atom2id
  character*128 :: format
  character*128 :: format2
  character*2 :: atom1(2), atom2(2)
  real*8 :: x1(6), x2(6), diskcenter(1:2), diskradius, temp
  logical :: disk, caxisdisk, writedisk

! USER INTERFACE STARTS HERE------------------------------------------->
! Cell parameters
  parameter(n1=64)
  parameter(n2=64)
  parameter(n3=40)

! Select atoms in x direction
  istart=1
  ifinal=64
! Select atoms in z direction
  kstart=1
  kfinal=40

! Select a disk to model well-width fluctuations, select .true. or .false.
  disk = .false.
! Direction of the disk along z (c-axis) is caxisdisk=.true. or along x is caxisdisk=.false.
  caxisdisk = .false.
! Radius in atomic steps, one atomic step means one lattice constant a. Conversion
! in indices is 1step=1i for x direction, 1step=2/sqrt(3)j for y direction and
! 1step=sqrt(3/2)k for z direction. This does not need to be an interger
  diskradius = 7.5d0
! Disk indices *along the growth direction* (whichever that is) similar to well selection above
  diskstart = 0 !33
  diskfinal = 0 !34
! Disk center (i,j) if it is c-axis growth, or (j,k) if it is not. Does not need to be an integer
  diskcenter = (/ 32.5d0, 32.5d0 /)
! USER INTERFACE ENDS HERE - DO NOT MODIFY BELOW THIS LINE------------->





  format='(A,4X,F13.6,4X,F13.6,4X,F13.6)'
  format2='(I5,4X,A,4X,I5,4X,I5,4X,I5,4X,F13.6,4X,F13.6,4X,F13.6)'

  open(unit=10,file='sc_GaN.dat',status='old')
  open(unit=20,file='sc_InGaN.dat',status='old')  
  open(unit=30,file='supercell.dat',status='unknown')
  open(unit=40,file='AtomsinDisk.dat',status='unknown')
  open(unit=50,file='AtomsOfLowerQW_Plane.dat',status='unknown')
  open(unit=60,file='AtomsOfUpperQW_Plane.dat',status='unknown')
! This unit 40 here is so we can tell how many atoms are in the disk for post determination of the indium content and to just look at the atoms in the disk.
! unit 50 and 60 are for subsequent determination of the relaxed well width. They contain the positions of all the atoms in the lower and upper well interaces. 
! These can be used to tell the width of the well before and (throught he atom ids) after relaxation.

  do k=1,n3
    do j=1,n2
      do i=1,n1
!       Read both input files
        read(10,format) atom1(1), x1(1), x1(2), x1(3)
        read(10,format) atom1(2), x1(4), x1(5), x1(6)

        read(20,format) atom2(1), x2(1), x2(2), x2(3)
        read(20,format) atom2(2), x2(4), x2(5), x2(6)

        atom1id = (k-1)*(2*n1)*n2+ (j-1)*2*n1 + 2*(i-1) +1;
        atom2id = (k-1)*(2*n1)*n2+ (j-1)*2*n1 + 2*(i-1) +2;
        
!       Evaluate if we are inside the disk region
        writedisk = .false.
        if(disk)then
          if(caxisdisk)then
            temp = dsqrt((dfloat(i)-diskcenter(1))**2+(dfloat(j)-diskcenter(2))**2)
            if(k>=diskstart.and.k<=diskfinal.and.temp<=diskradius)then
              writedisk = .false.
              write(40,format2) atom1id, atom2(1), i, j, k, x2(1), x2(2), x2(3)
              write(40,format2) atom2id, atom2(2), i, j, k, x2(4), x2(5), x2(6)
            end if
          else
            temp = dsqrt((dfloat(j)-diskcenter(1))**2+(dfloat(k)-diskcenter(2))**2)
            if(i>=diskstart.and.i<=diskfinal.and.temp<=diskradius)then
              writedisk = .false.
            end if
          end if
        end if

!       Write to output
        if(i>=istart.and.i<=ifinal.and.k>=kstart.and.k<=kfinal)then
          if(k==kstart)then
            write(50,format2) atom1id, atom2(1), i, j, k, x2(1), x2(2), x2(3)
            write(50,format2) atom2id, atom2(2), i, j, k, x2(4), x2(5), x2(6)
          end if
          if(k==kfinal)then
            write(60,format2) atom1id, atom2(1), i, j, k, x2(1), x2(2), x2(3)
            write(60,format2) atom2id, atom2(2), i, j, k, x2(4), x2(5), x2(6)
          end if
          write(30,format) atom2(1), x2(1), x2(2), x2(3)
          write(30,format) atom2(2), x2(4), x2(5), x2(6)
        else if(writedisk)then
          write(30,format) atom2(1), x2(1), x2(2), x2(3)
          write(30,format) atom2(2), x2(4), x2(5), x2(6)
        else
          write(30,format) atom1(1), x1(1), x1(2), x1(3)
          write(30,format) atom1(2), x1(4), x1(5), x1(6)
        end if
      end do
    end do
  end do

  close(10)
  close(20)
  close(30)
  close(40)
  close(50)
  close(60)
  
  return 
end
