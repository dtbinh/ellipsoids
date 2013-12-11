classdef ObjectApproxControlParams
    properties (Constant=true)
        nAddTopElems=32;
        errorCheckMode=1.e-3;
        approxPrec=1;
        freeMemoryMode=0;
        discardIneqMode=1;
        incDim=0;
        faceDist=.9e-5;
        inApproxDist=1.e-4;
        ApproxDist=1.e-5;
        precTest=1.e-4;
        relPrec=1.e-5;
        inftyDef=1.e6;
        isVerbose=0;
    end
    methods
        
        function propVal=getPropValue(self,propName) %#ok<MANU>
            propVal=elltool.multobj.ObjectApproxControlParams.(propName);
        end
        
        function defaultValVec=getValues(self,propList)
            defaultValVec=zeros(1,numel(propList));
            for iElem=1:numel(propList)
                defaultValVec(iElem)= self.getPropValue(propList{iElem});
            end
        end
        function SParams=parseParams(self,paramsSetList,propList)
            import modgen.common.checkmultvar;
            defaultValVec=self.getValues(propList);
            fieldList=propList;
            [~,~,...
                valList{1},valList{2},valList{3},valList{4},valList{5},...
                valList{6},valList{7},valList{8},valList{9},valList{10},...
                valList{11},valList{12},valList{13}]=...
                modgen.common.parseparext(paramsSetList,...
                {propList{:};...
                defaultValVec(1),defaultValVec(2),defaultValVec(3),...
                defaultValVec(4),defaultValVec(5),defaultValVec(6),...
                defaultValVec(7),defaultValVec(8),defaultValVec(9),...
                defaultValVec(10),defaultValVec(11),defaultValVec(12)...
                defaultValVec(13);});
            
            SParamsValCMat=[fieldList;valList];
            SParams=struct(SParamsValCMat{:});
            
        end
        
    end
end