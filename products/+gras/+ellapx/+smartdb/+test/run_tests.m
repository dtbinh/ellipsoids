function results=run_tests(varargin)
runner = mlunitext.text_test_runner(1, 1);
loader = mlunitext.test_loader;

suite1 = loader.load_tests_from_test_case(...
    'gras.ellapx.smartdb.test.mlunit.EllTubePlotPropTest',... 
    @(varargin)(gras.ellapx.smartdb.rels.EllUnionTube.fromEllTubes(...
    gras.ellapx.smartdb.rels.EllTube.fromQArrays(varargin{:}))));
suite2 = loader.load_tests_from_test_case(...
    'gras.ellapx.smartdb.test.mlunit.EllTubePlotPropTest',... 
    @gras.ellapx.smartdb.rels.EllTube.fromQArrays);
suite3 = loader.load_tests_from_test_case(...
    'gras.ellapx.smartdb.test.mlunit.SuiteEllTube');
suite4 = loader.load_tests_from_test_case(...
    'gras.ellapx.smartdb.test.mlunit.EllTubePlotTestCase');
suite5 = loader.load_tests_from_test_case(...
    'gras.ellapx.smartdb.test.mlunit.ExamplesTC');

resList{1} = runner.run(suite1);
resList{2} = runner.run(suite2);
resList{3} = runner.run(suite3);
resList{4} = runner.run(suite4);
resList{5} = runner.run(suite5);
results=[resList{:}];