%%%%%%%%%%%%
clear all
close all 
clc


syms Pk ru1 k
Pk=%input threshold value
lam=%input lamda
k=%input k value
eqn1=(1-ru1)*ru1*k == Pk;
ru1= solve(eqn1,ru1);
ru1=eval(ru1);
ru= max(ru1)

mu= lam/ru

% mu=eval(mu)
 

      
    
   

