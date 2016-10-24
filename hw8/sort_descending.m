function [sorted_eigen_vectors, sorted_eigen_values]=sort_descending(eigen_vectors,eigen_values)
    sorted_eigen_values=diag(sort(diag(eigen_values),'descend'));
%   get the original indexes of the elements before they were sorted. the
%   columns in the eigen vectors should be rearranged to match this order
    [temp, index_matrix]=sort(diag(eigen_values),'descend'); 
    sorted_eigen_vectors=eigen_vectors(:,index_matrix);
end