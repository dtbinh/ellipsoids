function result=run_tests_by_factory(className, varargin)
    if (strcmp(className, 'GenEllipsoid'))
        import elltool.core.test.EllFactory;
                runner = mlunitext.text_test_runner(1, 1);
                testCaseList = {'EllipsoidIntUnionTC',...
                                'EllipsoidTestCase',...
                                'EllipsoidSecTestCase',...
                                'HyperplaneTestCase',...                                
                                'ElliIntUnionTCMultiDim',...
                                'EllTCMultiDim',...
                                'EllSecTCMultiDim',...
                                'MPTIntegrationTestCase',...
                                'EllAuxTestCase',...
                                'HyperplanePlotTestCase',...
                                'EllipsoidMinkPlotTestCase',...
                                'EllipsoidBasicSecondTC',...
                                'HyperplaneDispStructTC'};  
%                                 'GenEllipsoidDispStructTC',...
%                                 'GenEllipsoidPlotTestCase',...
%                                 'GenEllipsoidTestCase',...
%'EllipsoidPlotTestCase',...
                testCaseList = strcat('elltool.core.test.mlunit.',testCaseList);
                suite = mlunitext.test_suite.fromTestCaseNameList(testCaseList,{EllFactory(className)});
                result = runner.run(suite);
    elseif (strcmp(className, 'ellipsoid'))
        import elltool.core.test.EllFactory;
               runner = mlunitext.text_test_runner(1, 1);
               testCaseList = {'EllipsoidIntUnionTC',...
                                'EllipsoidTestCase',...
                                'EllipsoidSecTestCase',...
                                'HyperplaneTestCase',...
                                'ElliIntUnionTCMultiDim',...
                                'EllTCMultiDim',...
                                'EllSecTCMultiDim',...
                                'MPTIntegrationTestCase',...
                                'EllipsoidPlotTestCase',...
                                'EllAuxTestCase',...
                                'HyperplanePlotTestCase',...
                                'EllipsoidMinkPlotTestCase',...
                                'EllipsoidBasicSecondTC',...
                                'EllipsoidDispStructTC',...
                                'HyperplaneDispStructTC',...
                                'EllipsoidSpecialTC'};        
                testCaseList = strcat('elltool.core.test.mlunit.',testCaseList);
                suite = mlunitext.test_suite.fromTestCaseNameList(testCaseList,{EllFactory(className)});
                result = runner.run(suite);
    else
        'Wrong name of class for EllFactory';
    end
