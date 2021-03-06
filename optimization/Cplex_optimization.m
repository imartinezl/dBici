clear all
clc
close all

addpath('C:\Program Files\IBM\ILOG\CPLEX_Studio125\cplex\matlab\x64_win64');
addpath('C:\Program Files\IBM\ILOG\CPLEX_Studio125\cplex\examples\src\matlab');

%load('test.mat')
A = importdata('A.csv');
b = importdata('b.csv');
c = importdata('c.csv');

m = size(A,1);
n = size(A,2);

lb = zeros(n,1);
ub = inf(n,1);
ub = 100*ones(n,1);

lhs = b;
rhs = b; %rhs = b+1;
ctype = repmat('I', 1, n);

% Initialize the CPLEX object
cplex = Cplex('lpex1');
cplex.Model.sense = 'minimize';
cplex.Model.ctype = ctype;
cplex.Model.obj   = c;
cplex.Model.lb    = lb;
cplex.Model.ub    = ub;
cplex.Model.A     = A;
cplex.Model.lhs   = lhs;
cplex.Model.rhs   = rhs;

% cplex.solve();

% Optimize the problem
cplex.feasOpt(lhs, rhs, lb, ub);
slacks = cplex.Model.rhs - cplex.Solution.ax;
plot(slacks)
slacks(slacks~=0);
find(slacks)
% cplex.Param.lpmethod.Cur = 3;
% cplex.solve();


% Write the solution
fprintf ('\nSolution status = %s\n',cplex.Solution.statusstring);
fprintf ('Solution value = %f\n',cplex.Solution.objval);
disp ('Values = ');
% disp (cplex.Solution.x');
plot(cplex.Solution.x,'*');

csvwrite('x.csv',cplex.Solution.x);
csvwrite('ax.csv',cplex.Solution.ax);









