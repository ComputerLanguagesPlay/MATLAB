function [flag] = checkOrder(obj,id)

if  nargin < 2 
    error('input arguments not enough');
end

if isempty(obj.log)
    flag = 1;
    return;
end

recentOrders = obj.log( max(1,end-3):end, 1 );


% initialize output
flag        = 1;
% table of error types
%errorList   = { 'we prefer new recipe have not been ordered recently ' ...      %1
                
%              };
% table of judgements which corresponds to table of error types
judgements  = { ' any(recentOrders(:,1)==id)'...           
};


error_amount = size(judgements, 2);

for i = 1 : error_amount
    if eval(judgements{i})
        flag = 0;
    end
end

end


