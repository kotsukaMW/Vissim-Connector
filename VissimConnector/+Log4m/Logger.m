classdef Logger < handle

    properties
        % Loglevel for logger.
        m_logLevel (1,1) Log4m.Level = Log4m.Level.INFO;
    end
    
    methods (Access = protected)
        % Constructor. Do not allow instanciation from external sources.
        function obj = Logger(varargin)
        end
        
        % Returns strings converted from given log level, current time and who calls logger.
        function [strLevel, strDatetime, strCaller] = getLogHeaderString(obj, level, stackdepth)
            if nargin <= 2; stackdepth = 5; end
            
            strLevel = string(level);
            strDatetime = string(datetime);
            stack = dbstack;
            strCaller = "from cmd window";
            if length(stack) >= stackdepth
                strCaller = stack(stackdepth).name;
            end
        end
    end
    
    methods (Access = public)
        % Writes log if the given log level is upper than cuurent logger log level.
        function log(obj, level, varargin)
            if obj.m_logLevel <= level
                obj.logImpl(level, varargin{:});
            end
        end
        
        % Set logger log level.
        function setLevel(obj, level), obj.m_logLevel = level; end
        
        % Log.
        function trace(obj,varargin), obj.log(Log4m.Level.TRACE, varargin{:}); end
        function debug(obj,varargin), obj.log(Log4m.Level.DEBUG, varargin{:}); end
        function info(obj,varargin),  obj.log(Log4m.Level.INFO,  varargin{:}); end
        function warn(obj,varargin),  obj.log(Log4m.Level.WARN,  varargin{:}); end
        function error(obj,varargin), obj.log(Log4m.Level.ERROR, varargin{:}); end
        
    end
    
    methods (Abstract, Access = protected)
        % Writes log. Concrete operation will be given by inherited classes.
        logImpl(obj, level, varargin);
    end
    
    methods (Static)
        % Returns logger instance. The returned instance will be retained as a singleton.
        function instance =  getInstance(loggerType)
            persistent logger;
            if isempty(logger)
                logger = Log4m.StdOutLogger();
            end
            if nargin == 1
                logger = eval(strcat('Log4m.', loggerType, 'Logger()'));
            end
            instance = logger;
        end
    end
end

