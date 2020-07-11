function kernel = GenerateKernel(nk, method)
switch method
  case 1
     a = zeros(nk,nk);
     CT= floor(nk./2)+1;
     for i = 1:nk
         for j = 1:nk
            a(i,j) = (i-CT)^2+(j-CT)^2;
         end
     end
      kernel = exp(-sqrt(a)); 
      kernel = kernel ./sum(kernel(:)); % kernel norm
      
    otherwise
     kernel = fspecial('gaussian',[nk,nk],1);
end