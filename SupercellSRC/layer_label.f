      program layer_label

C     This program labels the atoms depending on which layer they are in

      implicit none

      integer n1,n2,n3
!       parameter(n1=32,n2=32,n3=40)
!       parameter(n1=12,n2=12,n3=40)
      parameter(n1=2,n2=2,n3=2)

      character*3 A
      character*4 B
      integer i, j, k, l
      real*8 x, y, z, junk,fart1,fart2,fart3, x_ind
      character*72 format1, format2

      format1='(A,4X,F13.6,4X,F13.6,4X,F13.6,4X,A)'
      format2='(A,4X,F13.6,4X,F13.6,4X,F13.6,4X,A)'

      fart1 = n1*(1*3.189+0*3.545)
      fart2 = n2*0.8660*(1*3.189 + 0*3.545)
      fart3 = n3*(1*5.186 + 0*5.703)/2.0
C     All the labels are applied and stored. Now we need to incorporate
C     them to the "supercell.dat" file
      open(unit=20,file='supercell_corr.dat',status='old')
      open(unit=30,file='supercell_corr2.dat',status='unknown')
      write(30,*)'cell'
      write(30,*)fart1,'   ',fart2,'   ',fart3
      write(30,*)'frac'
      l=1
      do k=1,n3
        do j=1,n2
          do i=1,n1
            read(20,*)A,x,y,z,junk,junk,junk
            call labelling(A,B,l)
            write(30,format1)B,x,y,z,'1 1 1'

            read(20,*)A,x,y,z,junk,junk,junk
            call labelling(A,B,l)
            write(30,format1)B,x,y,z,'1 1 1'
          end do
        end do
        if(l.eq.1)then
          l=0
        else if(l.eq.0)then
          l=1
        end if
      end do


      stop
      end


      subroutine labelling(A,B,l)
      
      character*3 A
      character*4 B
      integer l

      if(l.eq.1)then
        if(A.eq.'Al')then
          B='Al1'
        else if(A.eq.'In')then
          B='In1'
        else if(A.eq.'Ga')then
          B='Ga1'
        else if(A.eq.'N1')then
          B='N101'
        else if(A.eq.'N2')then
          B='N102'
        else if(A.eq.'N3')then
          B='N103'
        else if(A.eq.'N4')then
          B='N104'
        else if(A.eq.'N5')then
          B='N105'
        else if(A.eq.'N6')then
          B='N106'
        else if(A.eq.'N7')then
          B='N107'
        else if(A.eq.'N8')then
          B='N108'
        else if(A.eq.'N9')then
          B='N109'
        else if(A.eq.'N10')then
          B='N110'
        else if(A.eq.'N11')then
          B='N111'
        else if(A.eq.'N12')then
          B='N112'
        else if(A.eq.'N13')then
          B='N113'
        else if(A.eq.'N14')then
          B='N114'
        else if(A.eq.'N15')then
          B='N115'
        end if
      else if(l.eq.0)then
        if(A.eq.'Al')then
          B='Al2'
        else if(A.eq.'In')then
          B='In2'
        else if(A.eq.'Ga')then
          B='Ga2'
        else if(A.eq.'N1')then
          B='N201'
        else if(A.eq.'N2')then
          B='N202'
        else if(A.eq.'N3')then
          B='N203'
        else if(A.eq.'N4')then
          B='N204'
        else if(A.eq.'N5')then
          B='N205'
        else if(A.eq.'N6')then
          B='N206'
        else if(A.eq.'N7')then
          B='N207'
        else if(A.eq.'N8')then
          B='N208'
        else if(A.eq.'N9')then
          B='N209'
        else if(A.eq.'N10')then
          B='N210'
        else if(A.eq.'N11')then
          B='N211'
        else if(A.eq.'N12')then
          B='N212'
        else if(A.eq.'N13')then
          B='N213'
        else if(A.eq.'N14')then
          B='N214'
        else if(A.eq.'N15')then
          B='N215'
        end if
      end if

      return
      end
