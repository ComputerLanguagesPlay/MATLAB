classdef recipes < handle
  properties (SetAccess = private)
      M
      log
      savepath
      blockSize 
      ptr 
      maxId
  end
  
  methods
      function obj = recipes(varargin)
          obj.savepath = './Recipes';
          obj.blockSize = int16(10);
          obj.ptr = int16(1);
          obj.maxId = obj.blockSize;
          obj.M = recipe(obj.blockSize, 1);
      end
      
      function rpsInsert(obj, name, link)
          if obj.ptr > obj.maxId - 2
              obj.maxId = obj.maxId + obj.blockSize;
              obj.M(obj.maxId, 1) = recipe();
          end
          rpInit(obj.M(obj.ptr,1));
          rpEdit(obj.M(obj.ptr,1), name, link);
          obj.ptr = obj.ptr + 1;
      end
      
      function rpsOrder(obj)
          stop = false;
          MAXLOOP = 500;
          counter = 1;
          flag = false;
          if obj.ptr < 2
              disp('No recipe inside!');
              return;
          end
          while ~stop
              id = randi(obj.ptr - 1);
              [result] = checkOrder(obj,id);
              if result
                  flag = true;
                  stop = true;
              end
              if counter > MAXLOOP
                  stop = true;
              end
              counter = counter + 1; 
          end
          
          if flag
              sprintf('successfully find recipe!')
          else
              sprintf('failed to find best recipe! Give you a random one...')
          end
          c = clock;
          obj.log = [obj.log; id,c(1:3) ];
          rpOrder(obj.M(id, 1));
          
      end
      
      function rpsResetLog(obj)
          obj.log = [];
      end
  end
  
end