#ifndef PC_DRIVER_DATA_STORAGE
#define PC_DRIVER_DATA_STORAGE

#include <stdio.h>
#include <cctype>
#include <iostream>
#include <string>
#include <fstream>
#include <ctime>
#include <math.h>
#include "data_structures.h"
#include "control.h"
#include <eigen3/Eigen/Dense>

using namespace std;
using namespace Eigen;

extern void storageProcedureInit();
extern void storageProcedureFinish();

// Data storage variable
extern FILE *fpt;

extern void DLQRDataStorageProcedure(vector<DLQRExperimentData_t> data);
extern vector<vector<double>> readMatrixFromCSV(const string &filename);
extern void checkLoadedMatrix(vector<vector<double>> matrix);
extern MatrixXd readCSVtoEigen(const string& filename);
extern void DLMIDataStorageProcedure(vector<DLMIExperimentData_t> data);

#endif //PC_DRIVER_DATA_STORAGE
