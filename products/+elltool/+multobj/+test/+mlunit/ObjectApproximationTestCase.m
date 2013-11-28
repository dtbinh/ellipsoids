classdef ObjectApproximationTestCase < mlunitext.test_case
    
    methods
        
        function self = ObjectApproximationTestCase(varargin)
            self = self@mlunitext.test_case(varargin{:});
        end
        
        function self = testIsConvexHull(self)
            prec=1.e-4;
            calcConvexHull = @(x,y,z,p,q) elltool.multobj.calcConvexHull(x,y,z,p,q);
            %2D case, convex hull contains not all points
            pointsMat = [1 1;0 2; 3 5; 1 6; 2 7; 0.5 8];
            convexMatExp = [0.8944    0.4472;...
                    0.5547    0.8321; 0.8944   -0.4472;...
                    -0.7071   -0.7071; -0.9965    0.0830];
            convexVecExp = zeros(1,5)';
            discrVecExp = zeros(1,5);
            vertMatExp = [3 5;0 2; 0.5 8; 1 1; 2 7];
            [convexMat convexVec discrVec vertMat]= calcConvexHull(pointsMat,[],[],1,{'relPrec',1.e-7});
            mlunitext.assert(all(all((convexMatExp - convexMat)<prec))&&all((convexVecExp - convexVec)<prec)...
                &&all((discrVecExp - discrVec)<prec)&&all(all((vertMatExp - vertMat)<prec)));
            
            %2D case, convex hull contains all the points
            pointsMat = [0 0;0.5 0.1; 0 2.24; 5.3 7];
            convexMatExp = [ 0.8209   -0.5711;  0.1961   -0.9806;...
                           -0.6682 0.7440; -1.0000 0];
            convexVecExp = [ -0.3533; 0; -1.6665; 0];         
            discrVecExp = zeros(1,4);
            vertMatExp = [5 7;0 0; 0 2.24; 0.5 0.1];
            [convexMat convexVec discrVec vertMat]= calcConvexHull(pointsMat,[],[],0,{});
            mlunitext.assert(all(all((convexMatExp - convexMat)<prec))&&all((convexVecExp - convexVec)<prec)...
                &&all((discrVecExp - discrVec)<prec)&&all(all((vertMatExp - vertMat)<prec)));
            
            %3D case
            pointsMat = [0 0 0; 1 0 1; 1 1 0; 2 3 6; 9 1 1];
            convexMatExp = [ 0.1231   -0.9847   -0.1231;...
                             0.1077   -0.8619    0.4956;...
                             -0.5145   -0.6860    0.5145;...
                             0.1231   -0.1231   -0.9847;...
                             0.0403    0.9459   -0.3220;...
                            -0.7022    0.7022   -0.1170];
            convexVecExp = [-0.0000;-0.6033;  0.0000; 0.0000;...
                                                       -0.9861;0.0000]; 
                                                   
            discrVecExp = 1.0e-07*[0.4470 0 0.2839 0.8941 0.6333];
            
            vertMatExp =  [9 1 1; 0 0 0; 2 3 6; 1 1 0; 1 0 1];
     
            
            [convexMat convexVec discrVec vertMat] = calcConvexHull(pointsMat,[],[],1,{'relPrec',1.e-8});
            mlunitext.assert(all(all((convexMatExp - convexMat)<prec))&&all((convexVecExp - convexVec)<prec)...
                &&all((discrVecExp - discrVec)<prec)&&all(all((vertMatExp - vertMat)<prec)));
            
            %3D case,convex hull is empty
            pointsMat = [0 0 0; 0.5 2 1; 1 4 2];
            
            [convexMat convexVec discrVec vertMat]=...
                                      calcConvexHull(pointsMat,[],[],0,{});
           mlunitext.assert((0==numel(convexMat))&&(0 ==numel(convexVec))...
                &&(0 == numel(discrVec))&&(0 == numel(vertMat)));
            
          
            %wrong input
            pointsMat=[1 2 3; 2 8 0];
            self.runAndCheckError('calcConvexHull(pointsMat,[],[],0,{})',...
                'wrongSize');
        end
        %
        function self = testIsEllipsoidApprox(self)
            prec=1.e-4;
            calcEllipsoidApprox = @(x,y,z,p,q,t)elltool.multobj.calcEllipsoidApprox(x,y,z,p,q,t);
            %
            centerVec = [0 0];
            semiaxesVec=[0.16 0.64];
            approxMatExp =  [-0.9476    0.3194;   -0.9640    0.2659;...
                0.9476    0.3194;    0.9640    0.2659;    0.9476   -0.3194;...
                0.9640   -0.2659;   -0.9476   -0.3194;   -0.9640   -0.2659;...
               -0.8841    0.4673;   -0.9229    0.3850;    0.8841    0.4673;...
                0.9229    0.3850;   -0.8841   -0.4673;   -0.9229   -0.3850;...
                0.8841   -0.4673;    0.9229   -0.3850;   -0.7078    0.7064;...
                -0.8197    0.5727;    0.7078    0.7064;    0.8197    0.5727;...
                 0.7078   -0.7064;    0.8197   -0.5727;   -0.7078   -0.7064;...
               -0.8197   -0.5727;   -0.1928    0.9812;   -0.5103    0.8600;...
                0.5103    0.8600;    0.1928    0.9812;   -0.1928   -0.9812;...
                -0.5103   -0.8600;    0.1928   -0.9812;    0.5103   -0.8600;...
                -0.9997    0.0246;   -0.9971    0.0756;    0.9997    0.0246;...
                 0.9971    0.0756;   -0.9971   -0.0756;   -0.9997   -0.0246;...
                 0.9971   -0.0756;    0.9997   -0.0246;   -0.9796   -0.2010;...
                -0.9912   -0.1325;    0.9796   -0.2010;    0.9912   -0.1325;...
                -0.9796    0.2010;   -0.9912    0.1325;    0.9796    0.2010;...
                 0.9912    0.1325];
             
            approxVecExp = [-0.2542; -0.2294; -0.2542; -0.2294; -0.2542;...
               -0.2294;   -0.2542;   -0.2294;   -0.3304;   -0.2869;   -0.3304;...
               -0.2869;   -0.3304;   -0.2869;   -0.3304;   -0.2869;   -0.4655;...
               -0.3888;   -0.4655;   -0.3888;   -0.4655;   -0.3888;   -0.4655;...
               -0.3888;   -0.6280;   -0.5558;   -0.5558;   -0.6280;   -0.6280;...
               -0.5558;  -0.6280;   -0.5558;   -0.1600;   -0.1659;   -0.1600;...
              -0.1659;   -0.1659;   -0.1600;   -0.1659;   -0.1600;   -0.2018;  ...
               -0.1790;   -0.2018;   -0.1790;   -0.2018;   -0.1790;   -0.2018;   -0.1790];
           
            discrVecExp = 1.0e-03 *[ 0.9212    0.2767    0.9212    0.2767 ...
                0.9212    0.2767    0.9212    0.2767    0.3985    0.3460    0.3985    0.3460    0.3985 ...
                0.3460    0.3985    0.3460    0.5614    0.4689    0.5614    0.4689    0.5614    0.4689 ...
                0.5614    0.4690    0.7573    0.6702    0.6703    0.7574    0.7574    0.6702    0.7574 ...
                0.6702    0.7739    0.8028    0.7739    0.8028    0.8028    0.7739    0.8028    0.7739 ...
                0.9764    0.8659    0.9764    0.8659    0.9763    0.8659    0.9763    0.8659];         
            
            
            
            vertMatExp =  [0.1600  0;   -0.1600  0; 0 0.6400; 0 -0.6400;...
                           0.1131   -0.4525; -0.1131   -0.4525;  0.1131    0.4525; -0.1131    0.4525;...
                           0.0612    0.5913;   -0.0612    0.5913;   -0.0612   -0.5913;    0.0612   -0.5913;...
                           -0.1478    0.2449;    0.1478    0.2449;   -0.1478   -0.2449;    0.1478   -0.2449;...
                           0.0312   -0.6277;   -0.0312   -0.6277;   -0.0312    0.6277;    0.0312    0.6277;...
                           0.0889   -0.5321;   -0.0889   -0.5321;   -0.0889    0.5321;    0.0889    0.5321;...
                           0.1330    0.3556;   -0.1330    0.3556;    0.1330   -0.3556;   -0.1330   -0.3556;...
                           0.1569   -0.1249;   -0.1569   -0.1249;    0.1569    0.1249;   -0.1569    0.1249;...
                           0.0157   -0.6369;   -0.0157   -0.6369;    0.0157    0.6369;   -0.0157    0.6369;...
                           -0.0464   -0.6124;    0.0464   -0.6124;    0.0464    0.6124;   -0.0464    0.6124;...
                           0.0754   -0.5644;   -0.0754   -0.5644;    0.0754    0.5644;   -0.0754    0.5644;...
                           -0.1015   -0.4947;    0.1015   -0.4947;    0.1015    0.4947;   -0.1015    0.4947;...
                           -0.1074    0.4742;    0.1074    0.4742;    0.1074   -0.4742;   -0.1074   -0.4742;...
                           -0.0684    0.5786;   -0.0823    0.5489;    0.0684    0.5786;    0.0823    0.5489;...
                           -0.0684   -0.5786;   -0.0823   -0.5489;    0.0684   -0.5786;    0.0823   -0.5489;...
                           -0.0389    0.6208;   -0.0539    0.6026;    0.0389    0.6208;    0.0539    0.6026;...
                           0.0389   -0.6208;    0.0539   -0.6026;   -0.0389   -0.6208;   -0.0539   -0.6026;...
                           -0.0079    0.6392;   -0.0235    0.6331;    0.0235    0.6331;    0.0079    0.6392;...
                           -0.0079   -0.6392;   -0.0235   -0.6331;    0.0079   -0.6392;    0.0235   -0.6331;...
                           -0.1592    0.0627;   -0.1531    0.1858;    0.1592    0.0627;    0.1531    0.1858;...
                           -0.1531   -0.1858;   -0.1592   -0.0627;    0.1531   -0.1858;    0.1592   -0.0627;...
                           -0.1237   -0.4060;   -0.1411   -0.3017;    0.1237   -0.4060;    0.1411   -0.3017;...
                           -0.1237    0.4060;   -0.1411    0.3017;    0.1237    0.4060;    0.1411    0.3017];
           [approxMat approxVec discrVec vertMat]= calcEllipsoidApprox(centerVec,semiaxesVec,[],[],0,{});
            mlunitext.assert(all(all((approxMatExp - approxMat)<prec))&&all((approxVecExp - approxVec)<prec)...
                &&all((discrVecExp - discrVec)<prec)&&all(all((vertMatExp - vertMat)<prec)));
        
            
          
            %wrong input
            centerVec1=[0 0];
            semiaxesVec1 = [1 3 5;1 5 2];
            self.runAndCheckError('calcEllipsoidApprox(centerVec1,semiaxesVec1,[],[],0,{})',...
                'wrongSize');
            centerVec2=[0 0];
            semiaxesVec2 = [1 3 5];   
            self.runAndCheckError('calcEllipsoidApprox(centerVec2,semiaxesVec2,[],[],0,{})',...
                'wrongSizes');
            centerVec3=[0 0 0];
            semiaxesVec3 = [1 1 1]; 
            properties={'relPrec','1e-6'};
            self.runAndCheckError('calcEllipsoidApprox(centerVec3,semiaxesVec3,[],[],1,properties)',...
                'wrongParamsType');
        end
    end
end