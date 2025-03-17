clear all
dbclear if warning;
%------------------------------------
%  disp('Start C++ code to set up Hamiltonian')
%  %  !./TBCQD_rocks.out 
%  %!./TBCQD.out
%  %  !./TBCQD_Non.out
%  !./TBCQD_Non_rocks.out
%  disp('Hamiltonian done')
%  %break;
%------------------------------------
%  load S1.asc;
%  disp('S1 eingelesen')
%  i=S1(:,1)+1;
%  j=S1(:,2)+1;
%  im=sqrt(-1)
%  wert=S1(:,3);%+im*S(:,4);
%  clear S1;
%  Ht=sparse(i,j,wert,max(i),max(i));
%  size(Ht)
%  load H2_alloy;
%  size(H2_alloy)
%  pause(6)
%  size(diag(H2_alloy))
%  for(i=1:size(diag(H2_alloy)))
%  i
%  dummyHt=nnz(Ht(i,:));
%  dummyH2=nnz(H2_alloy(i,:));
%  if(dummyHt-dummyH2~=0)
%  dummyHt
%  dummyH2
%  pause(4)
%  break
%  end
%  end
%  break
%------------------------------------
%  load S1.asc;
%  %load Satome30r22sqrt27.asc;
%  disp('S1 eingelesen')
%  i=S1(:,1)+1;
%  j=S1(:,2)+1;
%  im=sqrt(-1)
%  wert=S1(:,3);%+im*S(:,4);
%  clear S1;
%  Ht=sparse(i,j,wert,max(i),max(i));
%  size(Ht)
%  %pause(2)
%  %H2=spconvert(S)
%  clear S1;
%  clear j
%  clear wert;
%  load matrix_QW.data;
%  n=16;%4;
%  h=80;%12;
%  T=reshape(matrix_QW,n,n,h);
%  for(k=1:h)
%   for(i=1:n)
%     for(j=1:n)
%     J=((j-1)+(i-1)*n+(k-1)*n*n)*4+1;
%     if(T(j,i,k)~=0)
%     %j,i,k
%     %J
%     dummy=Ht(J,:);
%     %Ht(J,:)
%     %disp('interaction matrix elements')
%     %nnz(dummy)
%     if(nnz(dummy)~=13)
%     T(j,i,k)
%     j,i,k
%     J
%     Ht(J,:)
%        pause(6)
%     break
%     end
%     end
%     end
%   end
%  end
%  break
%////////////
disp('S matrix einlesen')
load S.asc;
%load Satome30r22sqrt27.asc;
disp('S eingelesen')
i=S(:,1)+1;
j=S(:,2)+1;
im=sqrt(-1)
wert=S(:,3);%+im*S(:,4);
clear S;
H2=sparse(i,j,wert,max(i),max(i));
size(H2)
%pause(2)
%H2=spconvert(S)
clear S;
clear j
clear wert;
H=speye(max(i),max(i));
disp('H & H2 erzeugt')
clear i
clear j
clear wert
clear S
%-------------------
%  Htest=full(H2);
%  EW=eig(Htest);
%  sort(EW)
%break
%------
epsilonref=2.75%1.5%1.2%0.65%2.4%0.55%1.8%0.95;%1.6%2.5%0.9%0.7;%2.5;%1.4;%1.4;%2.5;%1.4%3.6%1.6%0.95%1.4%0.8
h3=(H2-epsilonref*H);
disp('h3 angelegt')
clear H2;
clear H;
%  save H3.mat h3;
%----------------------------------------
%  %  load H3.mat
%break
disp('Quadrieren gestartet')
A=h3*h3;%h3'*h3;
clear h3;
%H3=(H2-epsilonref*H)^2;
disp('Quadrieren beendet')
clear H2;
clear H;
%  save -v7.3 A.mat A;
%  %break
%  clear A;
%  %break;
%-----------------------------------------
%  %save H3holesCFSOatome30r18sqrt27eps08.mat H3;
%  %save H3elecCFSOatome30r18sqrt27eps14.mat H3;
%  %--------------------------------------------------------
%  %Dot+WL
%  %---------------------------------------------------------
%  %save H3InGaNAtome30radius25sqrt27elecepsref22d1c.mat H3;
%  %save H3InGaNAtome30radius25sqrt27holesepsref1d1c.mat H3;
%  %-------------------------------------------------------
%  %WL
%  %--------------------------------------------------------
%  %save H3InGaNAtome30radius25sqrt27elecepsref22d7cWL.mat H3;
%  %save H3InGaNAtome30radius25sqrt27holesepsref1d7cWL.mat H3;
%  %--------------------------------------------------------
%  %'H3 gespeichert'
%  %load H3Atome30radius22sqrt27holesepsref1d6c
%  load H3quad.mat;
%  disp('H3 eingelesen')
%load vstarttest.mat;%load vstart1.mat;
%load vstarttest_holes.mat;%load vstart1.mat;
%load vstart_strain_holes.mat;
%load vstartsmall;
%load vstart_holes_verysmall;
%load vstartholes_strange.mat;

%load vstartAtome24Strain.mat;
%load vstartAtome24.mat;
%load vstart.mat;
%load vstartPiezo2.mat;
%load vstartPiezo_test.mat;
%load vstartStrain_test.mat;
%load vstartZyl.mat;
%load vstartStrain.mat;
%  if(epsilonref>=1.5)
%  load EVelecStrainPiezo_SingleDot_hoehesys59_Atome24.mat;
%  %load EVelec_CoupDot_d5c_hoehesys107_Atome24.mat
%  vstart=EV(:,1);
%  clear EV;
%  end
%  if(epsilonref<1.5)
%  %load EVholesStrainPiezo_SingleDot_hoehesys59_Atome24.mat;
%  %load EVholesStrainPiezo_CoupDot_d2c_hoehesys107_Atome24.mat
%  %load EVholesPiezo_small_In25Ga75N.mat
%  %load EVholesStrain_small_In25Ga75N.mat
%  %load EVholes_small_NoStrain_on_2.mat
%  load EVholes_small.mat
%  vstart=EV(:,1);
%  clear EV;
%  end
%111111111111111111111111111111
%  if(epsilonref>=1.6)
%  load EVelec_test.asc;
%  vstart=EVelec_test(:,1);
%  clear EVelec_test;
%  end
%  if(epsilonref<1.6)
%  load EVhole_test.asc;
%  vstart=EVhole_test(:,1);
%  clear EVhole_test;
%  end
disp('vstart eingelesen')
H3=speye(100,100);

%  if(epsilonref>=1.5)
%  load EV1Atome40hoehe68_elec.mat;
%  OPTIONS.v0=EV1;
%  clear EV1;
%  end
%load vstart157_elec.mat;
%load vstart141_holes.mat;
%load vstart157_holes_strai_piezo
%load vstart141_holes_strai_piezo
%load vstart109_holes_strai_piezo
%load vstart101_holes_strai_piezo
%load vstart125_holes_strai_Nopiezo
%load vstart109_holes_Nostrai_Nopiezo
%  load vstart101_holes_Nostrai_Nopiezo
%load vstart125_holes_Nostrai_Nopiezo
%load vstart141_holes_Nostrai_Nopiezo
%load vstart157_holes_Nostrai_Nopiezo

%  load ./Old_data/EVelec_test.asc;
%  vstart=EVelec_test(:,1);
%  clear EVelec_test;

%  load ./Old_data/EVhole_test.asc;
%  vstart=EVhole_test(:,1);
%  clear EVhole_test;


OPTIONS.Disp=1;
OPTIONS.Tol=1e-6;%1e-6
OPTIONS.MaxIt=10000000;
OPTIONS.disp=1;%2
OPTIONS.issym=1;
%  OPTIONS.p=20;
%  OPTIONS.v0=vstart;%vstart;
OPTIONS
size(H3)
tic
%format long
%[EV,EW]=eigs(A,3,'sr',OPTIONS);%eigs(A,3,'sr',OPTIONS);%eigstefan(H3,10,'sr',OPTIONS);%jdqr(H3,10,'sr',OPTIONS);%eigs(H3,6,'sr',OPTIONS);
%5 for electrons, 15 for holes
[EV,EW]=jdqr(A,60,'sr',OPTIONS);%eigs(A,15,'sr',OPTIONS);%eigstefanreal(H3,6,'sr',OPTIONS);
EW = diag(EW);
[EWSort, Permut] = sort(EW);
EVSort = EV(:,Permut);
EV=EVSort;
%break
%  save EVtestsmall.mat EV;
%  save EWtestsmall.mat EW;
toc
if(epsilonref>=1.6)
ew=sqrt(EWSort)+epsilonref
delta_ew=diff(ew)*1000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For coulomb interaction & dipole
save('EVelec_test_large.asc','EV','-ascii');
save('EWelec_test_large.asc','ew','-ascii');
%---------------------------------
%  save EWelec_d16c_Strain_Piezo_test.mat ew;%EWelec_d16c_Strain_Piezo.mat ew;%EWelec_d12c_Non.mat ew%EWelec_d12c_Strain_Piezo.mat ew;%EWelec_d8c.mat ew;
%  save EVelec_d16c_Strain_Piezo_test.mat EV%EVelec_d16c_Strain_Piezo.mat EV%EVelec_d12c_Non.mat EV%EVelec_d12c_Strain_Piezo.mat EV%EVelec_d8c.mat EV;
end
if(epsilonref<1.6)
ew=-sqrt(EWSort)+epsilonref
delta_ew=diff(ew)*1000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For coulomb interaction & dipole
save('EVhole_test_large.asc','EV','-ascii');
save('EWhole_test_large.asc','ew','-ascii');
%---------------------------------
%  save EWholes_d16c_Strain_Piezo_test.mat ew;%EWholes_d16c_Strain_Piezo.mat ew;%EWholes_d12c_Non.mat ew;%EWholes_d12c_Strain_Piezo.mat ew;%EWholes_d8c.mat ew;
%  save EVholes_d16c_Strain_Piezo_tes.mat EV;%EVholes_d16c_Strain_Piezo.mat EV;%EVholes_d12c_Non.mat EV;%EVholes_d12c_Strain_Piezo.mat EV;%EVholes_d8c.mat EV;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%load H3Atome30radius22sqrt27holesepsref1d6c;%H3.mat;
%%load H3Atome30radius22sqrt27holesepsref08d1c;%H3.mat;
%----------------------------------------------------------
%WL+Dot
%----------------------------------------------------------
%load H3InGaNAtome30radius25sqrt27holesepsref1d5c.mat
%load H3InGaNAtome30radius25sqrt27elecepsref22d1c.mat
%----------------------------------------------------------
%WL+Dot
%----------------------------------------------------------
%load H3InGaNAtome30radius25sqrt27holesepsref1d1cWL.mat
%load H3InGaNAtome30radius25sqrt27elecepsref22d7cWL.mat
%----------------------------------------------------------

%  clear
%  %  load H3elecCFSOatome30r18sqrt27eps14.mat
%  load H3.mat;
%  
%  'H3 eingelesen'
%  
%  dim=size(h3)
%  half=dim(1,1)./2
%  quarter=dim(1,1)./4
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %1.)
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %  h31=H3(:,1:half);%H3(1:half,:);
%  h31a=h3(1:quarter,:)*h3;
%  clear h3;
%  
%  h31=h31a';
%  
%  clear h31a;
%  %  
%  [i11,j11]=find(h31);
%  save i11.mat i11;
%  save j11.mat j11;
%  clear i11;
%  clear j11;
%  wert1=nonzeros(h31);
%  clear h31;
%  
%  %  save i11.mat i11;
%  %  save j11.mat j11;
%  save wert1.mat wert1;
%  
%  %  clear i11;
%  %  clear j11;
%  clear wert1;
%  'i11 angelegt'
%  
%  %break
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %2.)
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  load H3.mat;
%  %  h32=H3(:,(half+1):end);%H3((half+1):end,:);
%  h32a=h3((quarter+1):half,:)*h3;
%  clear h3;
%  h32=h32a';
%  
%  clear h32a;
%  
%  
%  [i12,j12]=find(h32);
%  save i12.mat i12;
%  save j12.mat j12;
%  clear i12;
%  clear j12;
%  wert2=nonzeros(h32);
%  clear h32;
%  
%  %  save i12.mat i12;
%  %  save j12.mat j12;
%  save wert2.mat wert2;
%  
%  
%  clear i12;
%  clear j12;
%  clear wert2;
%  'i12 angelegt'
%  
%  
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %3.)
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  load H3.mat;
%  %  h32=H3(:,(half+1):end);%H3((half+1):end,:);
%  h33a=h3((half+1):(3*quarter),:)*h3;
%  clear h3;
%  
%  h33=h33a';
%  
%  clear h33a;
%  
%  
%  [i13,j13]=find(h33);
%  save i13.mat i13;
%  save j13.mat j13;
%  clear i13;
%  clear j13;
%  
%  wert3=nonzeros(h33);
%  clear h33;
%  
%  %  save i13.mat i13;
%  %  save j13.mat j13;
%  save wert3.mat wert3;
%  
%  
%  clear i13;
%  clear j13;
%  clear wert3;
%  'i13 angelegt'
%  
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %4.)
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  load H3.mat;
%  %  h32=H3(:,(half+1):end);%H3((half+1):end,:);
%  h34a=h3((3*quarter+1):end,:)*h3;
%  
%  clear h3;
%  h34=h34a';
%  
%  clear h34a;
%  
%  
%  [i14,j14]=find(h34);
%  save i14.mat i14;
%  save j14.mat j14;
%  clear i14;
%  clear j14;
%  
%  wert4=nonzeros(h34);
%  clear h34;
%  
%  %  save i14.mat i14;
%  %  save j14.mat j14;
%  save wert4.mat wert4;
%  
%  clear i14;
%  clear j14;
%  clear wert4;
%  'i14 angelegt'
%  
%  %break;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  clear h3
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %clear H3
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %3.) Zusammensetzen
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  load i11;
%  load i12;
%  load i13;
%  load i14;
%  
%  %  i1test=[i11;i12;i13;i14];
%  i1=[i11;i12;i13;i14];
%  clear i11;
%  clear i12;
%  clear i13;
%  clear i14;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  !rm i11.mat;
%  !rm i12.mat;
%  !rm i13.mat;
%  !rm i14.mat;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  'i1test angelegt'
%  %  save i1test.mat i1test;
%  %  clear i1test
%  save i1test.mat i1;
%  clear i1;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  clear h3;
%  load j11;
%  'j11 eingelesen'
%  load j12;
%  'j12 eingelesen'
%  load j13;
%  'j13 eingelesen'
%  load j14;
%  'j14 eingelesen'
%  
%  %j1test=[j11;j12+quarter;j13+half;j14+3*quarter];
%  %j1=[j11;j12+quarter;j13+half;j14+3*quarter];
%  
%  j1a=[j11;j12+quarter];%;j13+half;j14+3*quarter];
%  
%  clear j11;
%  clear j12;
%  j1b=[j13+half;j14+3*quarter];
%  clear j13;
%  clear j14;
%  
%  j1=[j1a;j1b];
%  
%  clear j1a;
%  clear j1b;
%  
%  'j1test angelegt'
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  !rm j11.mat;
%  !rm j12.mat;
%  !rm j13.mat;
%  !rm j14.mat;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %  save j1test.mat j1test;
%  save j1test.mat j1;
%  %  break;
%  clear j1;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %wert=nonzeros(H3);
%  clear h3;
%  load wert1;
%  load wert2;
%  wert12=[wert1;wert2];
%  'wert12 angelegt'
%  clear wert1;
%  clear wert2;
%  %  save wert12.mat wert12;
%  wert12real=real(wert12);
%  wert12imag=imag(wert12);
%  clear wert12;
%  save wert12real.mat wert12real;
%  save wert12imag.mat wert12imag;
%  clear wertreal12;
%  clear wertimag12;
%  clear wert12real;
%  clear wert12imag;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  !rm wert1.mat;
%  !rm wert2.mat;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  whos
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  clear h3;
%  load wert3;
%  load wert4;
%  wert34=[wert3;wert4];
%  'wert34 angelegt'
%  clear wert3;
%  clear wert4;
%  
%  wert34real=real(wert34);
%  wert34imag=imag(wert34);
%  clear wert34;
%  save wert34real.mat wert34real;
%  save wert34imag.mat wert34imag;
%  clear wert34real;
%  clear wert34imag;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %  load wert12;
%  %  wert=[wert12;wert34];
%  %  'wert angelegt'
%  %  clear wert12;
%  %  clear wert34;
%  load wert12real.mat;
%  load wert34real.mat;
%  %load wert12imag.mat;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  !rm wert3.mat;
%  !rm wert4.mat;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %-------------------------------------
%  %wertreal=real(wert);%Realteil
%  %wertimag=imag(wert);%Imaginärteil
%  %clear wert;
%  wertreal=[wert12real;wert34real];
%  'wertreal angelegt'
%  save wertreal.mat wertreal;
%  'wertreal gespeichert'
%  clear wertreal;
%  clear wert12real;
%  clear wert34real;
%  !rm wert12real.mat;
%  !rm wert34real.mat;
%  
%  whos
%  
%  load wert12imag.mat;
%  load wert34imag.mat;
%  wertimag=[wert12imag;wert34imag];
%  'wertimag angelegt'
%  save wertimag.mat wertimag;
%  'wertimag gespeichert'
%  clear wertimag;
%  clear wert12imag;
%  clear wert34imag;
%  !rm wert12imag.mat;
%  !rm wert34imag.mat;
%  
%  %-------------------------------------
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  load i1test;
%  load j1test;
%  %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %  Htest=sparse(i1test,j1test,wert,max(i1test),max(j1test));
%  %  
%  %  clear i1test;
%  %  clear j1test;
%  %  clear wert;
%  
%  %break;
%  %  [i1,j1]=find(H3);
%  %  %break;
%  %--------------------------------------------------------------
%  'j1 speichern'
%  %save('j.asc','j1','-ascii');
%  fid=fopen('j.asc','wt')
%  c=fprintf(fid,'%d\n',j1);%Als integer abspeichern \n=Newline
%  'j1 gespeichert'
%  clear j1;
%  !rm j1test.mat
%  %-------------------------------------------------------------
%  'i1 speichern'
%  %save('i.asc','i1','-ascii');
%  fid=fopen('i.asc','wt')
%  c=fprintf(fid,'%d\n',i1);
%  'i1 gespeichert'
%  %-------------------------------------------------------------
%  whos
%  dim=size(i1)
%  clear i1;
%  !rm i1test.mat
%  %clear j1;
%  %wert=nonzeros(H3);
%  %  %------------------------------------------------------------
%  %  'wert speichern'
%  %  save('wert.asc','wert','-ascii');
%  %  'wert gespeichert'
%  %  %-------------------------------------------------------------
%  %------------------------------------------------------------
%  nonzeroshalf=(dim(1,1)/2)%67984018%VORSICHT!!!
%  load wertreal;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %'wertreal speichern'
%  %save('wertreal.asc','wertreal','-ascii');
%  %'wertreal gespeichert'
%  %clear wertreal;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  wertreal1=wertreal(1:nonzeroshalf);
%  'wertreal1 speichern'
%  save('wertreal1.asc','wertreal1','-ascii');
%  'wertreal1 gespeichert'
%  clear wertreal1;
%  
%  wertreal2=wertreal((nonzeroshalf+1):end);
%  'wertreal2 speichern'
%  save('wertreal2.asc','wertreal2','-ascii');
%  'wertreal2 gespeichert'
%  clear wertreal2;
%   
%  clear wertreal;
%  !rm wertreal.mat
%  
%  %-------------------------------------------------------------
%  load wertimag;
%  %'wertimag speichern'
%  %save('wertimag.asc','wertimag','-ascii');
%  %'wertimag gespeichert'
%  %clear wertimag;
%  %!rm wertimag.mat
%  
%  wertimag1=wertimag(1:nonzeroshalf);
%  'wertimag1 speichern'
%  save('wertimag1.asc','wertimag1','-ascii');
%  'wertimag1 gespeichert'
%  clear wertimag1;
%  
%  wertimag2=wertimag((nonzeroshalf+1):end);
%  'wertimag2 speichern'
%  save('wertimag2.asc','wertimag2','-ascii');
%  'wertimag2 gespeichert'
%  clear wertimag2;
%   
%  clear wertimag;
%  !rm wertimag.mat
%  
%  %-------------------------------------------------------------
%  
%  
%  
%  %  %save EWtest.mat EW;
%  %  %save EVtest.mat EV;