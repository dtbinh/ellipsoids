  1. Old "reach" class responsible for calculating reach sets for both discrete and continous systems is replaced with new elltool.reach.ReachContinuous and elltool.reach.ReachDiscrete classes. These new classes feature
    1. all new solvers performing the internal consistency checks for ellipsoidal approximations to make sure that ellipsoidal tubes are calculated with the desired precision
    1. all new visualization engine with improved visual effects and capable of displaying the touch curves and good curves l(t) for the tight approximations.
    1. ability to recognize LTI systems (with constant A) to use a more precise algorithm of ellipsoidal approximation calculation.
    1. built-in quadratic regularization for linear systems with uncertainty
  1. New command-line tool gras.ellapx.uncertcalc.run for calculating the tight ellipsoidal approximations for the linear systems defined via user-friendly configuration files. The tool features the same plotting features and is based on the same solver as elltool.reach.ReachContinuous used
  1. Regularization for degenerate ellipsoidal constraints for control, initial state and disturbance in ReachContinuous and ReachDiscrete classes.
  1. New command-line tool gras.ellapx.uncertmixcalc.run for calculating the non-tight approximations by algorithm developed by A.B. Kurzhansky and A.N. Daryin. In features the same user-friendly command-line interface.
  1. New methods of ellipsoid class:
    * fromRepMat - creates an array of equal ellipsoids of specified size
    * getCenterVec - returns center of ellipsoid
    * getShapeMat  - returns configuration matrix of ellipsoid
    * getBoundary - returns a triangulation approximating a boundary of ellipsoid
    * toPolytope - creates a polytope approximating an ellipsoid with a desired precision
  1. The following methods of ellipsoid class has been changed
    * eq - checks if two arrays of ellipsoids are the same element-wise. Now this method accepts additional paramter maxTol that specifies a precision of ellipsoid comparison.  Also eq returns reportStr containing a detailed information about the differences between the ellipsoid arrays if they are found
  1. New method of ellipsoid-to-ellipsoid/ellipsoid-to-point distance calculation
    1. Lin, A. and Han, S. On the Distance between Two Ellipsoids.
> > > SIAM Journal on Optimization, 2002, Vol. 13, No. 1 : pp. 298-308
    1. Stanley Chan, "Numerical method for Finding Minimum Distance to an
> > > Ellipsoid".
> > > http://videoprocessing.ucsd.edu/~stanleychan/publication/unpublished/Ellipse.pdf
  1. New Ellipsoid Toolbox configuration subsystem that replaces the legacy global variable ellOptions. Now all the parameters can be changed in a user-friendly way via the special command line tool elltool.conf.editconf by editing the toolbox configurations as text files.
  1. Yalmip solver for SDP problem is replaced with more reliable CVX (http://cvxr.com/cvx/) which allowed to fix a lot of bugs and solve problems in the following methods of ellipsoid class:
    * contains - checks if one ellipsoid contains the other. The condition for E1 = firstEllArr to contain E2 = secondEllArr is min(rho(l | E1) - rho(l | E2)) > 0, subject to <l, l> = 1.
    * intersect - checks if the union or intersection of ellipsoids intersects
> > > given ellipsoid, hyperplane or polytope.
    * isContainedInIntersection - checks if the intersection of ellipsoids contains the union or intersection of given ellipsoids or polytopes.
    * ellintersection\_ia - computes maximum volume ellipsoid that is contained
    * ellunion\_ea - computes minimum volume ellipsoid that contains union of given ellipsoids.
    * distance - computes distance between the given ellipsoid (or array of ellipsoids) to the specified object (or arrays of objects):vector, ellipsoid, hyperplane or polytope.
  1. Implemented a new ellipsoid class capable of representing both unbounded and degenerate ellipsoids. Has a reduced functionality compared to ellipsoid class. However all the implemented methods are capable of dealing with all cases of ellipsoids being degenerate/unbounded. These methods are:
    * minkSumEa - external approximation of E1+E2
    * minkSumIa - internal approximation of E1+E2
    * minkDiffEa - external approximation of E1-E2
    * minkDiffIa - internal approximation of E1-E2
    * inv - create generalized ellipsoid whose matrix in pseudoinverse to the matrix of input generalized ellipsoid
    * rho - calculate support function for input generalized ellipsoid
    * plot - plots ellipsoids in 2D or 3D.
    * eq - compares two arrays of ellipsoids
    * dimension - returns dimensionality of input ellipsoid
  1. Improved matrix S calculation algorithm introduced by A.N. Daryain and A.B. Kurzhansky in "Method of invariant sets for linear systems of high dimensionality under uncertain disturbances", "Doklady Akademii Nauk", 2012 for internal ellipsoidal approximations of E\_1+E\_2. This results into less calculation-expensive and more robust ellipsoidal approximations for both ellipsoidal sums and reachability domains of linear systems.
  1. Implemented the functions for
    * checking for positive (non-negative) definiteness,
    * checking forsymmetry;
    * matrix square root extraction for non-negative matrices these functions are used everywhere in the toolbox (in ReachContinuous,ReachDiscrete, ellipsoid and GenEllipsoid classes). This results into more robust calculation logic and user-friendly problem reporting.
  1. Integration between Ellipsoidal Toolbox and Multi-Parametric Toolbox has been improoved, particularly new
    * contains method for ellipsoid and polytop has been significantly speed up for high-dimensional inputs
    * Fixed a problem in intersection\_ea for ellipsoid E and polytope P. In intersection\_ea each facet F(i) of polytope P with number i is transformed into a half-space defined by hyperplane H(i). Then, starting with E\_0=E, E\_i was build as minimum-volume external appproximation of intersection between E(i-1) and H(i). Before the fix E\_i on each step was multiplied by sqrt(1+absTol) which resulted into accumulated calculated error equal to absTol (number of constraints in polytope). The fix has removed that multiplication.
    * Fixed a problem in hpintersection for intersecting ellipsoid E and hyperplane H. Prior the fix the method checked if distance (H,E) > 0 which lead to not-robust results. As part of the fix this check was replaced with distance(E,H)>absTol
    * isinside was renamed into isContainedInIntersection
    * new isInside method that is opposite to "contains" method
  1. Many methods of ellipsoid class now support for multi-dimensional inputs
  1. Incorporated log4j framework for logging which made debugging of Ellipsoidal Toolbox classes easier.
  1. All classes of the toolbox has been re-written using the modern implemenentaiton of object oriented programming in recent Matlab versions. Now the toolbox requires Matlab 2012a or later.
  1. All classes and functions of the toolbox has been convered with the unit tests which resulted in a lot of bug fixes. All tests are run on a daily basis on a dedicated hardware, the tests results are automatically set to the subscribers of the following Google Group: http://groups.google.com/group ellipsoids-tests-notification The link to this group has been publishes on the project web site. The unit tests has been implemented using MLUNITEXT framework (see http://code.google.com/p/ellipsoids/wiki/MLUNITEXT_unit_testing_framework_description)
  1. **(In Progress)** The user manual (tech report) for the toolbox has been updated.