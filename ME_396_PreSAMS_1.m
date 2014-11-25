

% clear all ;  % clear memory
% close all ;  % close any open figures
drawnow   ;  % update screen now
clc       ;  % clear screen

display('** Processing Data **') ;
display(' ') ;
tic

% Enter the directory and file name of your PreSAMS input file
PreSAMS_File_Name = 'C:\Users\Tim\Desktop\ME_396_PreSAMS_Temp.sam';

%% PreSAMS Models----------------------------------------------------------

% See SamsHelp page 526-257

SAMSMode = 2;   % 2 = PreSAMS (Should always == 2 !!!)
AnalysisType = 2;  % 1=FFR, 2=ANCF, 3=External Data, 4=ANCF Surface Geometry (Only AnalysisType==2 supported at this time)
NumModels = 1;  % (for this script NumModels = 1 only!!) 

% ENTER DATA HERE-----------------------

NumElements = 72;  % Enter the number of elements in your model
NumNodes = 80;   % Enter the number of nodes in your model
%---------------------------------------

ElementType = 5;  %Element type should be 5 (3D Beam)
NCKNOT = 0;    %Contiunuity (for this script NCKNOT = 0 only!!) 
Cholesky = 0;   %Cholesky Transformantion Matrix (leave as 0)
ElementTrans = 1;    % 0=Print, 1=No Print

ElementNumbers = 1:NumElements; % This is used later to fill the first col of some of the sections
ElementNumbers = ElementNumbers';
NodeNumbers = 1:NumNodes;  % This is used later to fill the first col of some of the sections
NodeNumbers = NodeNumbers';

[NumNodesPerElement , GradsPerElement] = ElementData(ElementType);  % ElementData: Returns the number of nodes
                                                                    % and gradients for a given ANCF element.

ModelDimensions = [1 NumElements NumNodes ElementType NCKNOT Cholesky ElementTrans];


%% Element Connectivity----------------------------------------------------
  
% See SamsHelp page 258

Rows = NumElements;
Cols = 1;

ElementConnectivity = zeros(Rows, Cols);  % initialize section as zeros
ElementConnectivity(:,1) = ElementNumbers;  % initialize first Col

% Add your code here for Cols 2 and 3
row1 = 1;
E1 = [];
F1 = [];

for j = 16:-2:1         % For 8 leafs with 17 nodes for first leaf, reduced by 2 nodes for successive leaf
    
    for i=1:j
        E1 = [(row1) (row1+1)];
        F1 = [F1;E1];
        row1 = row1+1;
    end
    
    row1 = row1+1;
end

ElementConnectivity = [ElementConnectivity F1];

%% Node Locations----------------------------------------------------------

% See SamsHelp page 259

NodeLocations = zeros(NumNodes, 1);
NodeLocations(:,1) = NodeNumbers;

% You can enter your node locations in the following format:
% NodeLocations = [1  x1  y1  z1;
%                  2  x2  y2  z2;
%                  3  x3  y3  z3;
%                  4  x4  y4  z4;
%                  5  x5  y5  z5;
%                  6  x6  y6  z6;
%                  7  x7  y7  z7]; % etc..
CocNodeLocations = [data(:,1) zeros(size(data,1),1) data(:,2)];
NodeLocations = [NodeLocations, CocNodeLocations];        


%% Element Properties------------------------------------------------------              

% See SamsHelp page 260

ElementProperties = zeros(NumElements,14);  % initialize as zero in case you 
ElementProperties(:,1) = ElementNumbers;     % want to enter some data in
                                            % the SAMS interface, the
                                            % format of this section will
                                            % be correct.


%In this section you can add your element properties
rhoValue = 1; % Enter the density of your material here

% NOTE!!!!!
% I have not include the d_x, d_y, d_z
% Add your code here

EValue = 100000;   % Enter the Young's modulus of your material here
PoissonRatioValue =  0.3; % enter the Poisson's ratio of your material here
GValue = EValue/(2*(1+PoissonRatioValue));
GravityValue = 0;
PhiValue = 0;
EpsValue = 0;
CoSyValue = 0;
HValue = 0;
Mu1Value = 0;
Mu2Value = 0;
% SplineValue = 0;

% In this section the previous properties are turned into vectors
rho = rhoValue*ones(NumElements, 1);

% NOTE!!!
% I have not include the d_x, d_y, d_z
% Add your code here
dx = intarclength(f,data);  % Added code for 8 leafs, starting w/17 elements and reducing by 2 for each successive leaf
dy = ones(NumElements,1)*0.25;              % Arbitrary
dz = ones(NumElements,1)*0.0100076;         % Pull from leaf spring thickness

E = EValue*ones(NumElements, 1);
PoissonRatio = PoissonRatioValue*ones(NumElements, 1);
G = GValue*ones(NumElements, 1);
Gravity = GravityValue*ones(NumElements, 1);
Phi = PhiValue*ones(NumElements, 1);
Eps = EpsValue*ones(NumElements, 1);
CoSy = CoSyValue*ones(NumElements, 1);
H = HValue*ones(NumElements, 1);
Mu1 = Mu1Value*ones(NumElements, 1);
Mu2 = Mu2Value*ones(NumElements, 1);
% Spline = Mu2Value*ones(NumElements, 1);


ElementProperties = [ElementNumbers, rho, dx, dy, dz, E, G, Gravity, ...
                      Phi, Eps, CoSy, H, Mu1, Mu2];

              
%% Nodal Forces------------------------------------------------------------

% See SamsHelp page 261

%Assuming no nodal forces
NodalForces = NoNodalForces(ElementType,NumNodes,NumNodesPerElement,NodeNumbers);

%% Position Vector Gradient------------------------------------------------

% See SamsHelp page 262

PositionVectorGradient = zeros(NumElements, 19);  % initialize as zero in case you 
PositionVectorGradient(:,1) = ElementNumbers;     % want to enter some data in
                                                  % the SAMS interface, the
                                                  % format of this section will
                                                  % be correct.

PositionVectorGradient = [ElementNumbers leafgrads(f,data)];

%% Begin Writing File======================================================

toc

display(' ') ;
display('** Writing Data **') ;
display(' ') ;

tic

PrintANCFOutput(SAMSMode , AnalysisType , NumModels , ModelDimensions, ...
                ElementConnectivity, NodeLocations, ElementProperties, ...
                NodalForces, PositionVectorGradient, ElementType, PreSAMS_File_Name)
            
            
%% End writing files-------------------------------------------------------

toc
display(' ') ;
display('** End **') ;
display(' ') ;

system( PreSAMS_File_Name );  % Open file for viewing
