classdef CompositeMatrixOperations<gras.mat.AMatrixOperations
    methods
        function obj=triu(self,mMatFunc)
            obj=triu@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixTriuFunc(mMatFunc);
            end
        end
        function obj=makeSymmetric(self,mMatFunc)
            obj=makeSymmetric@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixMakeSymmetricFunc(mMatFunc);
            end
        end
        function obj=pinv(self,mMatFunc)
            obj=pinv@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj= gras.mat.fcnlib.MatrixPInvFunc(mMatFunc);
            end
        end
        function obj=uminus(self,mMatFunc)
            obj=uminus@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixUMinusFunc(mMatFunc);
            end
        end
        function obj=realsqrt(self,mMatFunc)
            obj=realsqrt@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixRealSqrtFunc(mMatFunc);
            end
        end   
        function obj=transpose(self,mMatFunc)
            obj=transpose@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixTransposeFunc(mMatFunc);
            end
        end
        function obj=inv(self,mMatFunc)
            obj=inv@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixInvFunc(mMatFunc);
            end
        end
        function obj=sqrtmpos(self,mMatFunc)
            obj=sqrtmpos@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixSqrtFunc(mMatFunc);
            end
        end
        function obj=expm(self,mMatFunc)
            obj=expm@gras.mat.AMatrixOperations(self,mMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixExpFunc(mMatFunc);
            end
        end
        function obj=expmt(self,mMatFunc,t0)
            obj=expmt@gras.mat.AMatrixOperations(self,mMatFunc,t0);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixExpTimeFunc(mMatFunc,t0);
            end
        end
        function obj=matdot(self,lMatFunc,rMatFunc)
            obj=matdot@gras.mat.AMatrixOperations(self,lMatFunc,rMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixDotFunc(lMatFunc,rMatFunc);
            end
        end 
        % catDiffTimeVec
        function obj=catDiffTimeVec(self,lMatFunc,rMatFunc,dimCat,...
                timePartition,timePartitionRight)
            obj=catDiffTimeVec@gras.mat.AMatrixOperations(self,lMatFunc,rMatFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixCatDiffTimeVecFunc(lMatFunc,...
                    rMatFunc,dimCat,timePartition,timePartitionRight);
            end
        end
        % flipdim
        function obj=flipdim(self,inMatrixFunc,dimFlip)
            obj=flipdim@gras.mat.AMatrixOperations(self,inMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixFlipdimFunc(inMatrixFunc,...
                    dimFlip);
            end
        end
        % subarray
        function obj=subarray(self,inMatrixFunc,indexesList)
            obj=subarray@gras.mat.AMatrixOperations(self,inMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixSubArrayFunc(inMatrixFunc,...
                    indexesList);
            end
        end
        % subarrayInit
        function obj=subarrayInit(self,inMatrixFunc,indexesList,valueArray)
            obj=subarrayInit@gras.mat.AMatrixOperations(self,inMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixSubArrayInitFunc(inMatrixFunc,...
                    indexesList,valueArray);
            end
        end
        % reshape
        function obj=reshape(self,inMatrixFunc,newSizeVec)
            obj=reshape@gras.mat.AMatrixOperations(self,inMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixReshapeFunc(inMatrixFunc,...
                    newSizeVec);
            end
        end
        % mulHadamard
        function obj=mulHadamard(self,lMatrixFunc,rMatrixFunc)
            obj=mulHadamard@gras.mat.AMatrixOperations(self,lMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixMulHadamardFunc(lMatrixFunc,...
                    rMatrixFunc);
            end
        end
        % squeeze
        function obj=squeeze(self,lMatrixFunc,nTimePoints)
            obj=squeeze@gras.mat.AMatrixOperations(self,lMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixSqueezeFunc(lMatrixFunc,nTimePoints);
            end
        end
        % divHadamard
        function obj=divHadamard(self,lMatrixFunc,rMatrix)
            obj=divHadamard@gras.mat.AMatrixOperations(self,lMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixDivHadamardFunc(lMatrixFunc,rMatrix);
            end
        end
        % rMultiplyByVecSpecial
        function obj=rMultiplyByVecSpecial(self,lMatrixFunc,aArray,sizeMatrix)
            obj=rMultiplyByVecSpecial@gras.mat.AMatrixOperations(self,lMatrixFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixRMultiplyByVecSpecialFunc(...
                    lMatrixFunc,aArray,sizeMatrix);
            end
        end
        function obj=rMultiplyByScalar(self,lMatFunc,rScalFunc)
            obj=rMultiplyByScalar@gras.mat.AMatrixOperations(...
                self,lMatFunc,rScalFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixBinaryTimesFunc(...
                    lMatFunc,rScalFunc);
            end
        end
        function obj=rDivideByScalar(self,lMatFunc,rScalFunc)
            obj=rDivideByScalar@gras.mat.AMatrixOperations(...
                self,lMatFunc,rScalFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixRDivideByScalarFunc(...
                    lMatFunc,rScalFunc);
            end
        end
        function obj=rMultiplyByVec(self,lMatFunc,rColFunc)
            obj=rMultiplyByVec@gras.mat.AMatrixOperations(...
                self,lMatFunc,rColFunc);
            if isempty(obj)
                obj=gras.mat.fcnlib.MatrixBinaryTimesFunc(...
                    lMatFunc,rColFunc);
            end
        end
        function obj=rMultiply(self,lMatFunc,mMatFunc,rMatFunc)
            if nargin < 4
                obj=rMultiply@gras.mat.AMatrixOperations(...
                    self,lMatFunc,mMatFunc);
                if isempty(obj)
                    obj = gras.mat.fcnlib.MatrixBinaryTimesFunc(lMatFunc,...
                        mMatFunc);
                end
            else
                obj=rMultiply@gras.mat.AMatrixOperations(...
                    self,lMatFunc,mMatFunc,rMatFunc);
                if isempty(obj)
                    obj = gras.mat.fcnlib.MatrixTernaryTimesFunc(lMatFunc,...
                        mMatFunc,rMatFunc);
                end
            end
        end
        function obj=lrMultiply(self,mMatFunc,lrMatFunc,flag)
            obj=lrMultiply@gras.mat.AMatrixOperations(...
                self,mMatFunc,lrMatFunc,flag);
            if isempty(obj)
                obj = gras.mat.fcnlib.MatrixLRTimesFunc(mMatFunc,...
                    lrMatFunc,flag);
            end
        end
        function obj=lrMultiplyByVec(self,mMatFunc,lrColFunc)
            obj=lrMultiplyByVec@gras.mat.AMatrixOperations(...
                self,mMatFunc,lrColFunc);
            if isempty(obj)
                obj = gras.mat.fcnlib.MatrixLRTimesFunc(mMatFunc,...
                    lrColFunc,'R');
            end
        end
        function obj=lrDivideVec(self,mMatFunc,lrColFunc)
            obj=lrDivideVec@gras.mat.AMatrixOperations(...
                self,mMatFunc,lrColFunc);
            if isempty(obj)
                obj = gras.mat.fcnlib.MatrixLRDivideVecFunc(mMatFunc,...
                    lrColFunc);
            end
        end
        function obj=quadraticFormSqrt(self,mMatFunc,xColFunc)
            obj=quadraticFormSqrt@gras.mat.AMatrixOperations(...
                self,mMatFunc,xColFunc);
            if isempty(obj)
                obj = gras.mat.fcnlib.QuadraticFormSqrtFunc(...
                    mMatFunc,xColFunc);
            end
        end
    end
end