syms t

mat1 = [0.39*exp(-2*t)-0.19*exp(-t); -0.38*exp(-t) + 0.39*exp(-2*t)];

mat2 = [2*exp(-2*t) - exp(-t)        exp(-t) - exp(-2*t);
        -2*(exp(-t) - exp(-2*t))     2*exp(-t) - exp(-2*t)];
    
mat3 = [exp(t) - exp(2*t)/2 - 1/2; 2*exp(t) - exp(2*t)/2 - 3/2];


% assume 
u = 5;
Answer = simplify(mat1 + u*mat2*mat3)

mat = simplify(mat2*mat3);



