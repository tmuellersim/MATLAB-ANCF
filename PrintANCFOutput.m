function [  ] = PrintANCFOutput(SAMSMode , AnalysisType , NumModels , ...
                                ModelDimensions, ElementConnectivity, ...
                                NodeLocations, ElementProperties, NodalForces, ...
                                PositionVectorGradient, ElementType, PreSAMS_File_Name)
%PrintANCFOutput: Prints PreSAMS ANCF file
%   Detailed explanation goes here


    % open a file for writing
    fid = fopen(PreSAMS_File_Name, 'w'); % Location of the PreSAMS file used

    % Print PreSAMS File
    fprintf(fid, 'SAMS-Mode \r\n');
    fprintf(fid, '%2.0f \r\n', SAMSMode);
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, '%s',PreSAMS_File_Name);
    fprintf(fid, '\r\n');
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Analysis-Type\r\n');
    fprintf(fid, '%2.0f \r\n', AnalysisType);
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Number-of-Models\r\n');
    fprintf(fid,  '%2.0f \r\n', NumModels);
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Model_#_1_Name\r\n');
    fprintf(fid, 'Model_#_1\r\n');
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Model-Dimension\r\n');
    fprintf(fid, '%2d %12d %13d %14d %12d %13d %13d\r\n', ModelDimensions);
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Element-Connectivity\r\n');
    fprintf(fid, '%1.0f\t%1.0f\t %1.0f \r\n', ElementConnectivity');
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Nodal-Locations\r\n');

    if ElementType == 1 ...  % 2D element
    || ElementType == 2
        fprintf(fid, '%1d\t%1.0f\t %1.0f \r\n', NodeLocations');
    end
    if ElementType == 5  % 3D element
        fprintf(fid, '%d\t%f\t%f\t%f\t \r\n', NodeLocations');
    end

    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Element-Properties\r\n');
    fprintf(fid, '%1d\t%1.0f\t%f\t%f\t%f\t%1.0f\t%1.0f\t%f\t%1d\t%1d\t%1d\t%1d\t%1d\t%1d \r\n', ElementProperties');
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Nodal-Forces\r\n');  % Number of forces = number of coordinates

    if ElementType == 2 ...
    || ElementType == 6 ...
    || ElementType == 7
            fprintf(fid, '%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t %1.0f \r\n', NodalForces');
    elseif ElementType == 5
        fprintf(fid, '%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t %1.0f \r\n', NodalForces');
    elseif ElementType == 8
        fprintf(fid, '%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t%1.0f\t %1.0f \r\n', NodalForces');
    end

    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, 'Element-Position-Vector-Gradients\r\n');

    if ElementType == 2 
        fprintf(fid, '%1d\t%d\t%d\t%d\t%1.0f\t%1.0f\t%1d\t%1d\t %1d \r\n', PositionVectorGradient');
    elseif ElementType == 5
        fprintf(fid, '%1d\t%f\t%f\t%f\t%f\t%f\t%1f\t%1f\t%1f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t %1f \r\n', PositionVectorGradient');
    end
    fprintf(fid, '=======================================================================\r\n');
    fprintf(fid, ' 1000          0 \r\n');
    fprintf(fid, 'End-of-Model-1-data\r\n');
    fclose(fid);



end

