function[cov] = positivedefinite2(cov2)%makes cov 2x2 positive definite
cov = cov2;%put equal to previous one
if(cov2(1,1) ~= Inf(1,1))%if elements aren't infinite
    eigen = eig(cov);%find eigenvalues
    while(eigen(1,1) <= 0.00001 || eigen(2,1) <= 0.00001)
        cov = diag(eig(cov)+ exp(-5));%add a little value to make covariance positive definite
        eigen = eig(cov);
    end
end
end