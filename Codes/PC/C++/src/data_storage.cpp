#include "data_storage.h"

// Data storage variable
FILE *fpt;

void storageProcedureInit()
{
    fpt = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/control_data.csv", "w + ");
}

void storageProcedureFinish()
{
    fclose(fpt);
}

void DLQRDataStorageProcedure(vector<DLQRExperimentData_t> data)
{
    FILE* csv;

    csv = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/control_data.csv", "w+ ");

    for (int i = 0; i < data.size(); i++)
    {
        fprintf(csv,
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f \n",

            data[i].initialTime,                             // Column 1
            data[i].time,                                    // Column 2
            data[i].sampleTime,                              // Column 3
            data[i].duration,                                // Column 4
            (double)data[i].platformId,                      // Column 5
            (double)data[i].experiment,                      // Column 6
            (double)data[i].glassInclinationCompensation,    // Column 7
            (double)data[i].translationalReferenceTracking,  // Column 8
            (double)data[i].rotaionalReferenceTracking,      // Column 9
            data[i].vision.id[data[i].platformId].rotation,  // Column 10
            data[i].vision.id[data[i].platformId].x,         // Column 11
            data[i].vision.id[data[i].platformId].y,         // Column 12
            data[i].rotationalState.position_k,              // Column 13
            data[i].rotationalState.position_k_1,            // Column 14
            data[i].rotationalState.position_k_2,            // Column 15
            data[i].rotationalState.position_k_3,            // Column 16
            data[i].rotationalState.position_k_4,            // Column 17
            data[i].rotationalState.position_k_5,            // Column 18
            data[i].rotationalState.velocity_k,              // Column 19
            data[i].rotationalState.velocity_k_1,            // Column 20
            data[i].rotationalState.velocity_k_2,            // Column 21
            data[i].rotationalState.velocity_k_3,            // Column 22
            data[i].rotationalState.control_k_1,             // Column 23
            data[i].rotationalState.control_k_2,             // Column 24
            data[i].rotationalState.control_k_3,             // Column 25
            data[i].rotationalState.control_k_4,             // Column 26
            data[i].rotationalState.control_k_5,             // Column 27
            data[i].xAxisTranslationalState.position_k,      // Column 28
            data[i].xAxisTranslationalState.position_k_1,    // Column 29
            data[i].xAxisTranslationalState.position_k_2,    // Column 30
            data[i].xAxisTranslationalState.position_k_3,    // Column 31
            data[i].xAxisTranslationalState.control_k_1,     // Column 32
            data[i].xAxisTranslationalState.control_k_2,     // Column 33
            data[i].xAxisTranslationalState.control_k_3,     // Column 34
            data[i].yAxisTranslationalState.position_k,      // Column 35
            data[i].yAxisTranslationalState.position_k_1,    // Column 36
            data[i].yAxisTranslationalState.position_k_2,    // Column 37
            data[i].yAxisTranslationalState.position_k_3,    // Column 38
            data[i].yAxisTranslationalState.control_k_1,     // Column 39
            data[i].yAxisTranslationalState.control_k_2,     // Column 40
            data[i].yAxisTranslationalState.control_k_3,     // Column 41
            data[i].control.dutyCycleVariation,              // Column 42
            data[i].control.xAxisForce,                      // Column 43
            data[i].control.yAxisForce,                      // Column 44
            data[i].control.xAxisForceCompensation,          // Column 45
            data[i].control.yAxisForceCompensation,          // Column 46
            data[i].control.currentIncXAxis,                 // Column 47
            data[i].control.currentIncYAxis,                 // Column 48
            data[i].gyro.xRaw,                               // Column 49
            data[i].gyro.yRaw,                               // Column 50
            data[i].gyro.zRaw,                               // Column 51
            data[i].gyro.xOffset,                            // Column 52
            data[i].gyro.yOffset,                            // Column 53
            data[i].gyro.zOffset,                            // Column 54
            data[i].gyro.x,                                  // Column 55
            data[i].gyro.y,                                  // Column 56
            data[i].gyro.z,                                  // Column 57
            (double)data[i].motor.M1.directionRotation,      // Column 58
            data[i].motor.M1.force,                          // Column 59
            (double)data[i].motor.M1.dutyCycle,              // Column 60
            (double)data[i].motor.M2.directionRotation,      // Column 61
            data[i].motor.M2.force,                          // Column 62
            (double)data[i].motor.M2.dutyCycle,              // Column 63
            (double)data[i].motor.M3.directionRotation,      // Column 64
            data[i].motor.M3.force,                          // Column 65
            (double)data[i].motor.M3.dutyCycle,              // Column 66
            (double)data[i].motor.M4.directionRotation,      // Column 67
            data[i].motor.M4.force,                          // Column 68
            (double)data[i].motor.M4.dutyCycle,              // Column 69
            (double)data[i].motor.M5.directionRotation,      // Column 70
            data[i].motor.M5.force,                          // Column 71
            (double)data[i].motor.M5.dutyCycle,              // Column 72
            (double)data[i].motor.M6.dutyCycleUs,            // Column 73
            data[i].rotationalGain.K1,                       // Column 74
            data[i].rotationalGain.K2,                       // Column 75
            data[i].rotationalGain.K3,                       // Column 76
            data[i].rotationalGain.K4,                       // Column 77
            data[i].rotationalGain.K5,                       // Column 78
            data[i].rotationalGain.K6,                       // Column 79
            data[i].rotationalGain.K7,                       // Column 80
            data[i].rotationalGain.K8,                       // Column 81
            data[i].rotationalGain.K9,                       // Column 82
            data[i].rotationalGain.K10,                      // Column 83
            data[i].rotationalGain.K11,                      // Column 84
            data[i].rotationalGain.K12,                      // Column 85
            data[i].rotationalGain.K13,                      // Column 86
            data[i].rotationalGain.K14,                      // Column 87
            data[i].rotationalGain.K15,                      // Column 88
            data[i].translationalGain.K1,                    // Column 89
            data[i].translationalGain.K2,                    // Column 90
            data[i].translationalGain.K3,                    // Column 91
            data[i].translationalGain.K4,                    // Column 92
            data[i].translationalGain.K5,                    // Column 93
            data[i].translationalGain.K6,                    // Column 94
            data[i].translationalGain.K7,                    // Column 95
            data[i].reference.angularPosition,               // Column 96
            data[i].reference.xAxis,                         // Column 97
            data[i].reference.yAxis,                         // Column 98
            data[i].trackingError.angularPosition,           // Column 99
            data[i].trackingError.xAxis,                     // Column 100
            data[i].trackingError.yAxis,                     // Column 101
            data[i].translationalDisturbance.maxForce,       // Column 102
            data[i].translationalDisturbance.frequency,      // Column 103
            data[i].translationalDisturbance.amplitude,      // Column 104
            data[i].translationalDisturbance.force           // Column 105
        );
    }

    fclose(csv);
}

// Reads a matrix from a CSV file and returns it as a 2D vector
vector<vector<double>> readMatrixFromCSV(const string &filename)
{
    vector<vector<double>> matrix;
    ifstream file(filename);

    if (!file.is_open()) {
        throw runtime_error("Could not open file: " + filename);
    }

    string line;
    while (getline(file, line)) {
        vector<double> row;
        stringstream ss(line);
        string cell;

        while (getline(ss, cell, ',')) {
            row.push_back(stod(cell));  // Convert string to double
        }

        matrix.push_back(row);
    }

    file.close();
    return matrix;
}

void checkLoadedMatrix(vector<vector<double>> matrix)
{
    cout << "Loaded matrix:\n";
    for (const auto& row : matrix) {
        for (double value : row) {
            cout << value << " ";
        }
        cout << "\n";
    }
}

// Reads a CSV file and returns it as an Eigen::MatrixXd
MatrixXd readCSVtoEigen(const string& filename) 
{
    ifstream file(filename);
    if (!file.is_open()) {
        throw runtime_error("Unable to open file: " + filename);
    }

    string line;
    vector<vector<double>> data;
    size_t columnCount = 0;

    // Read file line by line
    while (getline(file, line)) {
        stringstream ss(line);
        string cell;
        vector<double> row;

        // Split each line by comma
        while (getline(ss, cell, ',')) {
            row.push_back(stod(cell));
        }

        // Ensure consistent column count
        if (columnCount == 0) {
            columnCount = row.size();
        }
        else if (row.size() != columnCount) {
            throw runtime_error("Inconsistent number of columns in CSV file.");
        }

        data.push_back(row);
    }

    file.close();

    // Convert to Eigen::MatrixXd
    size_t rowCount = data.size();
    MatrixXd matrix(rowCount, columnCount);

    for (size_t i = 0; i < rowCount; ++i) {
        for (size_t j = 0; j < columnCount; ++j) {
            matrix(i, j) = data[i][j];
        }
    }

    return matrix;
}

void DLMIDataStorageProcedure(vector<DLMIExperimentData_t> data)
{
    FILE* csv;

    csv = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/control_data.csv", "w+ ");

    for (int i = 0; i < data.size(); i++)
    {
        fprintf(csv,
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f,"
            "%f, %f, %f, %f \n",

            data[i].initialTime,                                  // Column 1
            data[i].time,                                         // Column 2
            data[i].sampleTime,                                   // Column 3
            data[i].duration,                                     // Column 4
            (double)data[i].platformId,                           // Column 5
            (double)data[i].experiment,                           // Column 6
            (double)data[i].glassInclinationCompensation,         // Column 7
            (double)data[i].translationalReferenceTracking,       // Column 8
            (double)data[i].rotaionalReferenceTracking,           // Column 9
            data[i].vision.id[data[i].platformId].rotation,       // Column 10
            data[i].vision.id[data[i].platformId].x,              // Column 11
            data[i].vision.id[data[i].platformId].y,              // Column 12
            data[i].rotationalState.position_k,                   // Column 13
            data[i].rotationalState.position_k_1,                 // Column 14
            data[i].rotationalState.position_k_2,                 // Column 15
            data[i].rotationalState.position_k_3,                 // Column 16
            data[i].rotationalState.position_k_4,                 // Column 17
            data[i].rotationalState.position_k_5,                 // Column 18
            data[i].rotationalState.velocity_k,                   // Column 19
            data[i].rotationalState.velocity_k_1,                 // Column 20
            data[i].rotationalState.velocity_k_2,                 // Column 21
            data[i].rotationalState.velocity_k_3,                 // Column 22
            data[i].rotationalState.control_k_1,                  // Column 23
            data[i].rotationalState.control_k_2,                  // Column 24
            data[i].rotationalState.control_k_3,                  // Column 25
            data[i].rotationalState.control_k_4,                  // Column 26
            data[i].rotationalState.control_k_5,                  // Column 27
            data[i].xAxisTranslationalState.controller_k(0, 0),   // Column 28
            data[i].xAxisTranslationalState.controller_k(1, 0),   // Column 29
            data[i].xAxisTranslationalState.controller_k(2, 0),   // Column 30
            data[i].xAxisTranslationalState.controller_k(3, 0),   // Column 31
            data[i].xAxisTranslationalState.controller_k_1(0, 0), // Column 32
            data[i].xAxisTranslationalState.controller_k_1(1, 0), // Column 33
            data[i].xAxisTranslationalState.controller_k_1(2, 0), // Column 34
            data[i].xAxisTranslationalState.controller_k_1(3, 0), // Column 35
            data[i].xAxisTranslationalState.position(0, 0),       // Column 36
            data[i].xAxisTranslationalState.control(0, 0),        // Column 37
            data[i].yAxisTranslationalState.controller_k(0, 1),   // Column 38
            data[i].yAxisTranslationalState.controller_k(1, 1),   // Column 39
            data[i].yAxisTranslationalState.controller_k(2, 1),   // Column 40
            data[i].yAxisTranslationalState.controller_k(3, 1),   // Column 41
            data[i].yAxisTranslationalState.controller_k_1(0, 1), // Column 42
            data[i].yAxisTranslationalState.controller_k_1(1, 1), // Column 43
            data[i].yAxisTranslationalState.controller_k_1(2, 1), // Column 44
            data[i].yAxisTranslationalState.controller_k_1(3, 1), // Column 45
            data[i].yAxisTranslationalState.position(0, 0),       // Column 46
            data[i].yAxisTranslationalState.control(0, 0),        // Column 47
            data[i].control.dutyCycleVariation,                   // Column 48
            data[i].control.xAxisForce,                           // Column 49
            data[i].control.yAxisForce,                           // Column 50
            data[i].control.xAxisForceCompensation,               // Column 51
            data[i].control.yAxisForceCompensation,               // Column 52
            data[i].control.currentIncXAxis,                      // Column 53
            data[i].control.currentIncYAxis,                      // Column 54
            data[i].gyro.xRaw,                                    // Column 55
            data[i].gyro.yRaw,                                    // Column 56
            data[i].gyro.zRaw,                                    // Column 57
            data[i].gyro.xOffset,                                 // Column 58
            data[i].gyro.yOffset,                                 // Column 59
            data[i].gyro.zOffset,                                 // Column 60
            data[i].gyro.x,                                       // Column 61
            data[i].gyro.y,                                       // Column 62
            data[i].gyro.z,                                       // Column 63
            (double)data[i].motor.M1.directionRotation,           // Column 64
            data[i].motor.M1.force,                               // Column 65
            (double)data[i].motor.M1.dutyCycle,                   // Column 66
            (double)data[i].motor.M2.directionRotation,           // Column 67
            data[i].motor.M2.force,                               // Column 68
            (double)data[i].motor.M2.dutyCycle,                   // Column 69
            (double)data[i].motor.M3.directionRotation,           // Column 70
            data[i].motor.M3.force,                               // Column 71
            (double)data[i].motor.M3.dutyCycle,                   // Column 72
            (double)data[i].motor.M4.directionRotation,           // Column 73
            data[i].motor.M4.force,                               // Column 74
            (double)data[i].motor.M4.dutyCycle,                   // Column 75
            (double)data[i].motor.M5.directionRotation,           // Column 76
            data[i].motor.M5.force,                               // Column 77
            (double)data[i].motor.M5.dutyCycle,                   // Column 78
            (double)data[i].motor.M6.dutyCycleUs,                 // Column 79
            data[i].rotationalGain.K1,                            // Column 80
            data[i].rotationalGain.K2,                            // Column 81
            data[i].rotationalGain.K3,                            // Column 82
            data[i].rotationalGain.K4,                            // Column 83
            data[i].rotationalGain.K5,                            // Column 84
            data[i].rotationalGain.K6,                            // Column 85
            data[i].rotationalGain.K7,                            // Column 86
            data[i].rotationalGain.K8,                            // Column 87
            data[i].rotationalGain.K9,                            // Column 88
            data[i].rotationalGain.K10,                           // Column 89
            data[i].rotationalGain.K11,                           // Column 90
            data[i].rotationalGain.K12,                           // Column 91
            data[i].rotationalGain.K13,                           // Column 92
            data[i].rotationalGain.K14,                           // Column 93
            data[i].rotationalGain.K15,                           // Column 94
            data[i].reference.angularPosition,                    // Column 95
            data[i].reference.xAxis,                              // Column 96
            data[i].reference.yAxis,                              // Column 97
            data[i].trackingError.angularPosition,                // Column 98
            data[i].trackingError.xAxis,                          // Column 99
            data[i].trackingError.yAxis,                          // Column 100
            data[i].translationalDisturbance.maxForce,            // Column 101
            data[i].translationalDisturbance.frequency,           // Column 102
            data[i].translationalDisturbance.amplitude,           // Column 103
            data[i].translationalDisturbance.force                // Column 104
        );
    }

    fclose(csv);
}