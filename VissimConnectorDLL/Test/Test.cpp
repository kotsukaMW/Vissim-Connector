
#include <iostream>
#include "VissimConnector.h"
#include "DrivingSimulatorProxy.h"

int main()
{

    std::wstring strFileName(L"E:\\OneDrive - MathWorks\\projects\\vissim-connector\\VissimScenario\\MyVIssimScenario.inpx");

    //VissimConnector* obj = new VissimConnector(strFileName);
    VissimConnector* obj = new VissimConnector(strFileName);

    bool bSuccess = false;
    int frequency = 10;
    int radius = -1;
    bSuccess = obj->connect(frequency, radius, 10, 10, 0, 50000, 50000, 0);

    if (!bSuccess) {
        exit(1);
    }

    int iMaxCount = 1000;
    for (int i = 0; i < iMaxCount; i++) {
        Simulator_Veh_Data ego = Simulator_Veh_Data{};
        ego.VehicleID = 1;
        ego.VehicleType = 100;
        obj->setDriverVehiclesData(1, ego);

        bool bSuccess = obj->step();

        int numVehicles = obj->getTrafficVehiclesDataCount();
        std::wcout << L"Num of vehicles at " << i << ": " << numVehicles << std::endl;
        for (int j = 0; j < numVehicles; j++)
        {
            VISSIM_Veh_Data actor = obj->getTrafficVehiclesData(j);
            std::wcout << "    Vehicle " << j << ": [" <<
                actor.Position_X << "," << actor.Position_Y << "]" << std::endl;
        }
    }

    obj->disconnect();
}
