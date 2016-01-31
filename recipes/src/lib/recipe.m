classdef recipe < handle
    
    properties (SetAccess = private)
        name
        id
        link
        valid
        lastOrder
    end
    
    methods
        function obj = recipe(varargin)
            if nargin > 0
                obj(varargin{1},varargin{2}) = recipe();
            end
        end
        
        function rpInit(obj)
            if obj.valid
                error('Input object is already initialized!');
            end
            obj.valid = true;
            import java.util.UUID;
            obj.id = char(UUID.randomUUID());
        end
        
        function rpEdit(obj,varargin)
            if ~obj.valid
                error('Input object is not initialized yet!')
            end            
            obj.name = varargin{1};
            obj.link = varargin{2};      
        end
        
        function rpReset(obj)
            m   = size(obj, 1);
            n   = size(obj, 2);
            for i = 1 : m
                for j = 1 : n
                    if obj(i, j ).valid
                        prop    = properties(obj(i, j));
                        for k = 1 : length(prop)
                            obj(i, j).(prop{k}) = [];
                        end
                    end
                end
            end
        end
        
        function rpOrder(obj)
            sprintf('Recipe Today:');
            disp(obj.name)
            if ~isempty(obj.lastOrder)
                sprintf('Last ordered time is \n')
                str = strcat([num2str(obj.lastOrder(end,1)), ' Äê ',...
                    num2str(obj.lastOrder(end,2)), ' ÔÂ ',...
                    num2str(obj.lastOrder(end,3)), ' ÈÕ ']);
                disp(str);
                pause(1);
            end
            web(obj.link,'-browser')
            c = clock;
            obj.lastOrder = [obj.lastOrder; c(1:3)];
        end
        

        
       
        
 %%       
        function set.name(obj, value)
            validateattributes('value', {'char'},{'nonempty'});
            obj.name = value;
        end
        function set.link(obj, value)
            validateattributes('value', {'char'},{'nonempty'});
            obj.link = value;
         end
        function set.lastOrder(obj, value)
            validateattributes(value, {'double','single'},{'positive'});
            obj.lastOrder = value;
        end
        
    end
    
end