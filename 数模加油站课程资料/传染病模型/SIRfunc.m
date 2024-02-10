function dydt = SIRfunc(t,y,lam,mu)
dydt = zeros(2,1);
dydt(1) = lam*y(1)*y(2) - mu*y(1);
dydt(2) = -lam*y(1)*y(2);
end