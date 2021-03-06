classdef Log4jConfigurator<modgen.logging.log4j.Log4jConfigurator
%LOG4JCONFIGURATOR - simplifies log4j configuration, 
%                    especially when Parallel Computing
%                    Toolbox is used. In the latter case
%                    the class forwards the logs of
%                    different processees in separate log
%                    files
%
% $Author: Peter Gagarinov  <pgagarinov@gmail.com> $
% $Date: 2011-05-18 $
% $Copyright: Moscow State University,
%             Faculty of Computational Mathematics
%             and Computer Science,
%             System Analysis Department 2011 $    
properties (Constant)
        %
        MASTER_LOG_FILE_NAME='master';
        CHILD_LOG_FILE_NAME_PREFIX='child';
        LOG_FILE_EXT='log';
        MAIN_LOG_FILE_PREFIX='main.';
    end
    properties(Constant)
        SP_MAIN_LOG_FILE_NAME='elltool.log4j.logfile.main.name'
        SP_CUR_PROCESS_NAME='elltool.log4j.curProcessName'
        SP_LOG_DIR_WITH_SEP='elltool.log4j.logfile.dirwithsep'
        SP_LOG_FILE_EXP='elltool.log4j.logfile.ext'
        CONF_REPO_MGR_CLASS='elltool.conf.ConfRepoMgr';
    end
    methods (Access=private)
        function self=Log4jConfigurator()
        end
    end
    methods (Static)
        function configure(confSource,varargin)
            % CONFIGURE - performs log4j configuration
            %
            import modgen.common.throwerror;
            self=elltool.logging.Log4jConfigurator();
            if isa(confSource,self.CONF_REPO_MGR_CLASS)
                if ~confSource.isParam('logging.log4jSettings')
                    throwerror('wrongConfVersion',...
                        'Consider updating your configuration');
                end
                %
                logPropStr=confSource.getParam(...
                    'logging.log4jSettings');
            else
                throwerror('wrongInput',...
                    ['configuration source should be either ',...
                    'a property string or a reference',...
                    'to ',self.CONF_REPO_MGR_CLASS,' object']);
            end
            self.configureInternal(logPropStr,varargin{:});
        end
        function logFileName=getMainLogFileName()
            self=elltool.logging.Log4jConfigurator();
            logFileName=self.getMainLogFileNameInternal();
        end
    end
end
