      program supercell

C     Creates a random supercell of Al(x)In(y)Ga(1-x-y)N
      
      implicit none

      integer n1, n2, n3

       parameter(n1=64)
       parameter(n2=64)
       parameter(n3=40)
!------11520 Atoms
!       parameter(n1=12) cell: 38.268 33.141 103.7
!       parameter(n2=12)
!       parameter(n3=40)
!------256--------------
!       parameter(n1=4)
!       parameter(n2=4)
!       parameter(n3=8)
!------128--------------
!       parameter(n1=1)
!       parameter(n2=1)
!       parameter(n3=2)
!------32--------------
!       parameter(n1=2)
!       parameter(n2=2)
!       parameter(n3=4)
!------16-------------
!      parameter(n1=2)
!      parameter(n2=2)
!      parameter(n3=2)
!------64--------------
!       parameter(n1=2)
!       parameter(n2=2)
!       parameter(n3=8)
!------72--------------
!       parameter(n1=3)
!       parameter(n2=3)-
!       parameter(n3=4)



      real gasdev
      real*8 x, y, z, num(n1*n2*n3,2), temp1, temp2, a0, c0, x1, x2, x3
      real*8 numb(3,2), u, f1, f2, f3, offset
      integer idum, n, nx, ny, nz, in, opt(3), i, j, k
      integer mode
      character*72 format

!       open(unit=10,file='sc_AlInN.dat',status='unknown')
      open(unit=10,file='supercell.dat',status='unknown')
      open(unit=20,file='bonds.dat',status='unknown')

C     Fractional or cartesian coordinates. mode = 1 means cartesian
      mode=0

C     Seed for random numbers routine
      idum=20

C     x is Al molar fraction, y in In, and z (do not change) is Ga
      x=0.00d0  !0.65d0
      y=0.25d0  !0.35d0
      z=1.d0-x-y

C     Lattice parameters of GaN      
      a0=3.189d0
      c0=5.185d0
      u=0.38203d0

C     Offset in z-axis
C     offset=-1.d0*c0
      offset=0.d0

      n=n1*n2*n3

      nx = n*x
      ny = n*y
      nz = n*z

      numb(1,1)=dfloat(n)*x-dfloat(nx)
      numb(2,1)=dfloat(n)*y-dfloat(ny)
      numb(3,1)=dfloat(n)*z-dfloat(nz)
      numb(1,2)=1.d0
      numb(2,2)=2.d0
      numb(3,2)=3.d0


      do i=1,3
        do j=i+1,3
          if(numb(i,1).gt.numb(j,1))then
            temp1 = numb(i,1)
            temp2 = numb(i,2)
            numb(i,1) = numb(j,1)
            numb(i,2) = numb(j,2)
            numb(j,1) = temp1
            numb(j,2) = temp2
          endif
        enddo
      enddo

      if(n-(nx+ny+nz).eq.2)then
        if(((numb(3,2).eq.1.d0).or.(numb(2,2).eq.1.d0)).and.((numb(3,2).
     &eq.2.d0).or.(numb(2,2).eq.2.d0)))then
          nx=nx+1
          ny=ny+1
        else if(((numb(3,2).eq.1.d0).or.(numb(2,2).eq.1.d0)).and.((numb(
     &3,2).eq.3.d0).or.(numb(2,2).eq.3.d0)))then
          nx=nx+1
          nz=nz+1
        else if(((numb(3,2).eq.2.d0).or.(numb(2,2).eq.2.d0)).and.((numb(
     &3,2).eq.3.d0).or.(numb(2,2).eq.3.d0)))then
          ny=ny+1
          nz=nz+1
        end if
      else if(n-(nx+ny+nz).eq.1)then
        if(numb(3,2).eq.1.d0)then
          nx=nx+1
        else if(numb(3,2).eq.2.d0)then
          ny=ny+1
        else if(numb(3,2).eq.3.d0)then
          nz=nz+1
        end if
      else
        continue
      end if
C     ------------------------------------------------------------------


      write(*,*)'Total atoms: n =',2*(nx+ny+nz)


      do i = 1,nx
        num(i,1) = gasdev(idum)
        num(i,2) = 1.d0
      end do

      do i = nx+1,nx+ny
        num(i,1) = gasdev(idum)
        num(i,2) = 2.d0
      end do

      do i = nx+ny+1,n
        num(i,1) = gasdev(idum)
        num(i,2) = 3.d0
      end do

C     To sort the random numbers from lower to higher
      do i=1,n
        do j=i+1,n
          if(num(i,1).gt.num(j,1))then
            temp1 = num(i,1)
            temp2 = num(i,2)
            num(i,1) = num(j,1)
            num(i,2) = num(j,2)
            num(j,1) = temp1
            num(j,2) = temp2
          endif
        enddo
      enddo


      x1=0.d0
      x2=0.d0
      x3=0.d0+offset

      opt(1)=0
      opt(2)=0
      opt(3)=0

      in=0

      format='(A,4X,F13.6,4X,F13.6,4X,F13.6)'

C     Factors for the fractional coordinates:
      if(mode.eq.1)then
        f1=1.d0
        f2=1.d0
        f3=1.d0
      else
        f1=1.d0/(n1*a0)
        f2=1.d0/(n2*a0*sqrt(3.d0)/2.d0)
        f3=1.d0/(n3/2.d0*c0)
      end if

C     Distributes the cordinates for the wurtzite structure:
      do i=1,n3
        do j=1,n2
          do k=1,n1
            in=in+1
            if(opt(1).eq.0.and.opt(3).eq.0)then
C           These are the cordinates of the group III atom:
            if(num(in,2).eq.1.d0)then
              write(10,format) 'Al', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.2.d0)then
              write(10,format) 'In', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.3.d0)then
              write(10,format) 'Ga', x1*f1, x2*f2, x3*f3
            end if
C           These are the cordinates of the N atom:
              write(10,format) 'N ', (x1+a0/2.d0)*f1, (x2+a0/sqrt(12.d0)
     &)*f2, (x3+(.5d0-u)*c0)*f3
              call bond1(x1+a0/2.d0,x2+a0/sqrt(12.d0),x3+(.5d0-u)*c0,a0,
     &c0,x1,x2,x3,u)

            else if(opt(1).eq.0.and.opt(3).eq.1)then
C           These are the cordinates of the group III atom:
            if(num(in,2).eq.1.d0)then
              write(10,format) 'Al', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.2.d0)then
              write(10,format) 'In', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.3.d0)then
              write(10,format) 'Ga', x1*f1, x2*f2, x3*f3
            end if
C           These are the cordinates of the N atom:
              write(10,format) 'N ', (x1+a0/2.d0)*f1, (x2-a0/sqrt(12.d0)
     &)*f2, (x3+(.5d0-u)*c0)*f3
              call bond2(x1+a0/2.d0,x2-a0/sqrt(12.d0),x3+(.5d0-u)*c0,a0,
     &c0,x1,x2,x3,u)

            else if(opt(1).eq.1.and.opt(3).eq.0)then
C           These are the cordinates of the group III atom:
            if(num(in,2).eq.1.d0)then
              write(10,format) 'Al', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.2.d0)then
              write(10,format) 'In', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.3.d0)then
              write(10,format) 'Ga', x1*f1, x2*f2, x3*f3
            end if
C           These are the cordinates of the N atom:
              write(10,format) 'N ', (x1-a0/2.d0)*f1, (x2+a0/sqrt(12.d0)
     &)*f2, (x3+(.5d0-u)*c0)*f3
              call bond1(x1-a0/2.d0,x2+a0/sqrt(12.d0),x3+(.5d0-u)*c0,a0,
     &c0,x1,x2,x3,u)

            else if(opt(1).eq.1.and.opt(3).eq.1)then
C           These are the cordinates of the group III atom:
            if(num(in,2).eq.1.d0)then
              write(10,format) 'Al', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.2.d0)then
              write(10,format) 'In', x1*f1, x2*f2, x3*f3
            else if(num(in,2).eq.3.d0)then
              write(10,format) 'Ga', x1*f1, x2*f2, x3*f3
            end if
C           These are the cordinates of the N atom:
              write(10,format) 'N ', (x1-a0/2.d0)*f1, (x2-a0/sqrt(12.d0)
     &)*f2, (x3+(.5d0-u)*c0)*f3
              call bond2(x1-a0/2.d0,x2-a0/sqrt(12.d0),x3+(.5d0-u)*c0,a0,
     &c0,x1,x2,x3,u)

            end if
            x1=x1+a0
          end do
C         In the next row, the first atom will be placed +-a/2 from the 
C         x position of the first atom in the previous row
          if(opt(1).eq.0)then
            x1=a0/2.d0
            opt(1)=1
          else if(opt(1).eq.1)then
            x1=0.d0
            opt(1)=0
          end if
          x2=x2+sqrt(3.d0)/2.d0*a0
        end do
C       In the next plane, the first atom will be placed +-a/2 from the 
C       x position and +-a/sqrt(12) from the y position of the first
C       atom in the previous plane
        if(opt(2).eq.0)then
          x1=a0/2.d0
          x2=a0/sqrt(12.d0)
          opt(2)=1
          opt(1)=1
        else if(opt(2).eq.1)then
          x1=0.d0
          x2=0.d0
          opt(2)=0
          opt(1)=0
        end if
        if(opt(3).eq.0)then
          opt(3)=1
        else if(opt(3).eq.1)then
          opt(3)=0
        end if
        x3=x3+c0/2.d0
      end do

      close(10)
      close(20)

      stop
      end










C     Gaussian distribution of width sqrt(2) ---> exp(-x²/2)
      function gasdev(idum)
      real v1,v2,r,fac,gasdev,ran2
      integer idum
1     continue
        v1=2.*ran2(idum)-1.
        v2=2.*ran2(idum)-1.
        r=(v1**(2.))+(v2**(2.))
        if (r.ge.1.) go to 1
        fac=sqrt(-2.*log(r)/r)
        gasdev=v2*fac
      return
      end

C     Random numbers
      FUNCTION ran2(idum)
      INTEGER idum,IM1,IM2,IMM1,IA1,IA2,IQ1,IQ2,IR1,IR2,NTAB,NDIV
      real ran2,AM,EPS,RNMX
      PARAMETER (IM1=2147483563,IM2=2147483399,AM=1.e0/IM1,IMM1=IM1-1, 
     & IA1=40014,IA2=40692,IQ1=53668,IQ2=52774,IR1=12211,IR2=3791,
     & NTAB=32,NDIV=1+IMM1/NTAB,EPS=1.2e-7,RNMX=1.e0-EPS)
      INTEGER idum2,j,k,iv(NTAB),iy
      SAVE iv,iy,idum2
      DATA idum2/123456789/, iv/NTAB*0/, iy/0/
      if (idum.le.0) then
        idum=max(-idum,1)
        idum2=idum
        do 11 j=NTAB+8,1,-1
          k=idum/IQ1
          idum=IA1*(idum-k*IQ1)-k*IR1
          if (idum.lt.0) idum=idum+IM1
          if (j.le.NTAB) iv(j)=idum
11      continue
        iy=iv(1)
      endif
      k=idum/IQ1
      idum=IA1*(idum-k*IQ1)-k*IR1
      if (idum.lt.0) idum=idum+IM1
      k=idum2/IQ2
      idum2=IA2*(idum2-k*IQ2)-k*IR2
      if (idum2.lt.0) idum2=idum2+IM2
      j=1+iy/NDIV
      iy=iv(j)-idum2
      iv(j)=idum
      if(iy.lt.1)iy=iy+IMM1
      ran2=min(AM*iy,RNMX)
      return
      END
!  (C) Copr. 1986-92 Numerical Recipes Software 1(-V%'2150)-3.


      subroutine bond1(x10,x20,x30,a0,c0,x1,x2,x3,u)
      
      real*8 a0, c0, x1, x2, x3, u, x10, x20, x30

      write(20,*) x10, x20, x30, -a0/2.d0, -a0/sqrt(12.d0), -c0*(.5d0-u)
      write(20,*) x10, x20, x30, a0/2.d0, -a0/sqrt(12.d0), -c0*(.5d0-u)
      write(20,*) x10, x20, x30, 0.d0, a0/sqrt(3.d0), -c0*(.5d0-u)
      write(20,*) x10, x20, x30, 0.d0, 0.d0, c0*u

      return
      end

      subroutine bond2(x10,x20,x30,a0,c0,x1,x2,x3,u)
      
      real*8 a0, c0, x1, x2, x3, u, x10, x20, x30

      write(20,*) x10, x20, x30, -a0/2.d0, a0/sqrt(12.d0), -c0*(.5d0-u)
      write(20,*) x10, x20, x30, a0/2.d0, a0/sqrt(12.d0), -c0*(.5d0-u)
      write(20,*) x10, x20, x30, 0.d0, -a0/sqrt(3.d0), -c0*(.5d0-u)
      write(20,*) x10, x20, x30, 0.d0, 0.d0, c0*u

      return
      end
