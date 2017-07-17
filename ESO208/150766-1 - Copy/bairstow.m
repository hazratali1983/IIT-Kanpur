%bairstow
function [x1] = bairstow (~)
syms x
str=input('function:','s');
f=@(t)subs(str,x,t);
prompt={'Enter r:', 'Enter s:', 'Enter max. number of iterations:', 'Enter max %error:'};
dlg_title='Input data';
num_lines=1;
p=inputdlg(prompt,dlg_title,num_lines);
v=str2double(p);
a=v(1);
b=v(2);
c=v(3);
d=v(4);
u = -a;
v = -b;

for i = 1:n
  gx = x^2 + u*x + v;
  [R, rem] = quorem (f, gx, x);
  [U, rem2] = quorem(R, gx, x);
  M = sym2poly(rem);
  if (length(M)==2)
    c = M(1); d = M(2);
  end
  if (length(M)==1)
    c = M(1); d = 0;
  end
  if (isempty(M))
    c = 0; d = 0;
  end
  M = sym2poly(rem2);
  if (length(M)==2)
    g = M(1); h = M(2);
  end
  if (length(M)==1)
    g = M(1); h = 0;
  end
  if (isempty(M))
    g = 0; h = 0;
  end
  if (c==0 && d==0)
    break;
  end
  u = u - (g*d-c*h)/(v*g*g-h*(h-u*g));
  v = v - (-g*v*c + (g*u-h)*d)/(v*g*g-h*(h-u*g));
end

r1 = (-u + (u^2 - 4*v)^0.5)/2;
r2 = (-u - (u^2 - 4*v)^0.5)/2;

fprintf('\n Root 1: \n');
disp(r1); 
fprintf('\n Root 2: \n');
disp(r2); 

fplot(f, [-10,+10]); 
  


end