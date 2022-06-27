function [multi_z] = multi_pdf_func(datum, mean, sigma)
    multi_z = normpdf(double(datum),mean,sigma);
end

