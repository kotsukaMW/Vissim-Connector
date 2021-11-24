classdef MATLABLogger < Log4m.Logger
    
    methods    
        function obj = MATLABLogger(varargin)
            
        end
    end
    
    methods (Access = protected)
        function logImpl(obj, level, varargin)
            switch(level)
                case Log4m.Level.ERROR
                    error(varargin{:});
                case Log4m.Level.WARN
                    warning(varargin{:});
                otherwise
                    fprintf(varargin{:});
            end
        end
    end
end
