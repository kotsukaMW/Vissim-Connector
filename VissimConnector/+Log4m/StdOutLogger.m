classdef StdOutLogger < Log4m.Logger
        
    methods
        function obj = StdOutLogger(varargin)
            
        end
    end
    
    methods (Access = protected)
        function logImpl(obj, level, varargin)
            [strLevel, strDatetime, strCaller] = getLogHeaderString(obj, level);
            
            fprintf("[%s] [%s] [%s] ", strLevel, strDatetime, strCaller);
            fprintf(varargin{1:end});
            fprintf("\n");
            
        end
    end
end
