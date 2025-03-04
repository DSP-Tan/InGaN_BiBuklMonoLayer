      program n_label

C     This program labels the nitrogen atoms depending on the surroun-
C     ding group III atoms. There are 15 possible combinations and,
C     hence, 15 different labels to give:
C     N1 --> Surrounded by 4 Ga
C     N2 --> Surrounded by 3 Ga, 1 Al
C     N3 --> Surrounded by 3 Ga, 1 In
C     N4 --> Surrounded by 2 Ga, 2 Al
C     N5 --> Surrounded by 2 Ga, 1 Al, 1 In
C     N6 --> Surrounded by 2 Ga, 2 In
C     N7 --> Surrounded by 1 Ga, 3 Al
C     N8 --> Surrounded by 1 Ga, 2 Al, 1 In
C     N9 --> Surrounded by 1 Ga, 1 Al, 2 In
C     N10 --> Surrounded by 1 Ga, 3 In
C     N11 --> Surrounded by 4 Al
C     N12 --> Surrounded by 3 Al, 1 In
C     N13 --> Surrounded by 2 Al, 2 In
C     N14 --> Surrounded by 1 Al, 3 In
C     N15 --> Surrounded by 4 In

      implicit none

      integer n1,n2,n3
!       parameter(n1=32,n2=32,n3=40)
!      parameter(n1=12,n2=12,n3=40)
      parameter(n1=2,n2=2,n3=2)
      
      character*2 species(n1+2,n2+2,n3+2), junk1, junk4
      character*3 label(n1+2,n2+2,n3+2), junk3
      integer i, j, k, l1, l2
      real*8 junk2, xc, yc, zc, xa, ya, za
      character*72 format, format2

      open(unit=10,file='supercell.dat',status='old')
      do k=1,n3
        do j=1,n2
          do i=1,n1
            read(10,*)species(i+1,j+1,k+1),junk2,junk2,junk2
            read(10,*)junk1,junk2,junk2,junk2
          end do
        end do
      end do
      close(10)

C     If l1=0 then the row starts with an anion. l2 indicates the orien-
C     tation of the tetrahedron

      l1=1
      l2=1

      do k=1,n3
        do j=1,n2
          do i=1,n1
            if(l1.eq.1.and.l2.eq.1)then
              if(i.eq.n1)then
                species(i+2,j+1,k+1)=species(2,j+1,k+1)
              else
                continue
              end if
              call labelling(species(i+1,j+1,k+1),species(i+2,j+1,k+1),s
     &pecies(i+1,j+2,k+1),species(i+1,j+1,k+2),junk3)
              label(i+1,j+1,k+1)=junk3
            else if(l1.eq.0.and.l2.eq.1)then
              if(i.eq.1)then
                species(i,j+1,k+1)=species(i+n1,j+1,k+1)
              else
                continue
              end if
              if(j.eq.n2)then
                species(i+1,j+2,k+1)=species(i+1,2,k+1)
              else
                continue
              end if
              call labelling(species(i,j+1,k+1),species(i+1,j+1,k+1),spe
     &cies(i+1,j+2,k+1),species(i+1,j+1,k+2),junk3)
              label(i+1,j+1,k+1)=junk3
            else if(l1.eq.0.and.l2.eq.0)then
              if(i.eq.1)then
                species(i,j+1,k+1)=species(i+n1,j+1,k+1)
              else
                continue
              end if
              if(j.eq.1)then
                species(i+1,j,k+1)=species(i+1,j+n2,k+1)
              else
                continue
              end if
              if(k.eq.n3)then
                species(i+1,j+1,k+2)=species(i+1,j+1,2)
              else
                continue
              end if
              call labelling(species(i+1,j,k+1),species(i+1,j+1,k+1),spe
     &cies(i,j+1,k+1),species(i+1,j+1,k+2),junk3)
              label(i+1,j+1,k+1)=junk3
            else if(l1.eq.1.and.l2.eq.0)then
              if(i.eq.n1)then
                species(i+2,j+1,k+1)=species(2,j+1,k+1)
              else
                continue
              end if
              if(k.eq.n3)then
                species(i+1,j+1,k+2)=species(i+1,j+1,2)
              else
                continue
              end if
              call labelling(species(i+1,j,k+1),species(i+2,j+1,k+1),spe
     &cies(i+1,j+1,k+1),species(i+1,j+1,k+2),junk3)
              label(i+1,j+1,k+1)=junk3
            end if
          end do
C     Changing l1 for next row
          if(l1.eq.0)then
            l1=1
          else
            l1=0
          end if
        end do
C     Changing l1 and l2 for the next plane
        if(l1.eq.0)then
          l1=1
        else
          l1=0
        end if
        if(l2.eq.0)then
          l2=1
        else
          l2=0
        end if
      end do

      format='(A,4X,F13.6,4X,F13.6,4X,F13.6,4X,A)'
      format2='(A,5X,F13.6,4X,F13.6,4X,F13.6,4X,A)'

C     All the labels are applied and stored. Now we need to incorporate
C     them to the "supercell.dat" file
      open(unit=20,file='supercell.dat',status='old')
      open(unit=30,file='supercell_corr.dat',status='unknown')
      do k=1,n3
        do j=1,n2
          do i=1,n1
            read(20,*)junk1,xc,yc,zc
            read(20,*)junk4,xa,ya,za
            write(30,format2)junk1,xc,yc,zc,'0 0 0'
            write(30,format)label(i+1,j+1,k+1),xa,ya,za,'0 0 0'
          end do
        end do
      end do


      stop
      end


      subroutine labelling(A,B,C,D,N)
      
      character*2 A,B,C,D
      character*3 N
      integer s

      s=0

      if(A.eq.'Al')then
        s=s+1
      else if(A.eq.'In')then
        s=s+5
      end if
      if(B.eq.'Al')then
        s=s+1
      else if(B.eq.'In')then
        s=s+5
      end if
      if(C.eq.'Al')then
        s=s+1
      else if(C.eq.'In')then
        s=s+5
      end if
      if(D.eq.'Al')then
        s=s+1
      else if(D.eq.'In')then
        s=s+5
      end if

      if(s.eq.0)then
        N='N1'
      else if(s.eq.1)then
        N='N2'
      else if(s.eq.2)then
        N='N4'
      else if(s.eq.3)then
        N='N7'
      else if(s.eq.4)then
        N='N11'
      else if(s.eq.5)then
        N='N3'
      else if(s.eq.6)then
        N='N5'
      else if(s.eq.7)then
        N='N8'
      else if(s.eq.8)then
        N='N12'
      else if(s.eq.10)then
        N='N6'
      else if(s.eq.11)then
        N='N9'
      else if(s.eq.12)then
        N='N13'
      else if(s.eq.15)then
        N='N10'
      else if(s.eq.16)then
        N='N14'
      else if(s.eq.20)then
        N='N15'
      end if
      return
      end
