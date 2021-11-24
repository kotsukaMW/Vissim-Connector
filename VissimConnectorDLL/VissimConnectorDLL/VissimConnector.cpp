#include "pch.h"
#include "VissimConnector.h"
#include "DrivingSimulatorProxy.h"

#include <string>
#include <iostream>
#include <algorithm>
#include <vector>
#include <stdlib.h>

VissimConnector::VissimConnector() :
	m_bIsConnected(false),
	m_bSimulatorVehicleDataSpawned(false),
	m_strINPXFilename(L"C:\\Users\\hichikaw\\OneDrive - MathWorks\\projects\\vissim-connector\\VissimScenario\\MyVIssimScenario.inpx")
{

}

//TODO
VissimConnector::VissimConnector(const std::wstring& strINPXFileName) :
	m_bIsConnected(false),
	m_bSimulatorVehicleDataSpawned(false),
	m_strINPXFilename(strINPXFileName)
{

}

VissimConnector::~VissimConnector()
{

}

bool VissimConnector::connect(
	unsigned short simulatorFrequency = 10,
	double visibilityRadius = -1.0,
	unsigned short maxSimulatorVeh = 1000,
	unsigned short maxSimulatorPed = 1000,
	unsigned short maxSimulatorDet = 100, 
	unsigned short maxTotalVeh = 1000,
	unsigned short maxVissimPed = 1000,
	unsigned short maxVissimSigGrp = 1000)
{
	std::wcout << L"Filename = " << this->m_strINPXFilename << std::endl;

	bool bSuccess = VISSIM_Connect(
		2100,
		this->m_strINPXFilename.c_str(),
		simulatorFrequency,
		visibilityRadius,
		maxSimulatorVeh,
		maxSimulatorPed,
		maxSimulatorDet,
		maxTotalVeh,
		maxVissimPed,
		maxVissimSigGrp);

	this->m_bIsConnected = bSuccess;

	return bSuccess;

}

bool VissimConnector::disconnect()
{
	bool bSuccess = false;
	if (this->m_bIsConnected)
	{
		bSuccess = VISSIM_Disconnect();
	}
	return bSuccess;
}

void VissimConnector::setDriverVehiclesData(int iVehicleID, Simulator_Veh_Data simulatorVehicleData)
{
	if (std::find(this->m_vRegisteredVehicles.begin(),
		this->m_vRegisteredVehicles.end(),
		iVehicleID) == this->m_vRegisteredVehicles.end())
	{
		this->m_vRegisteredVehicles.push_back(iVehicleID);
		simulatorVehicleData.Create = true;
	}
	else {
		simulatorVehicleData.Create = false;
	}
	simulatorVehicleData.ControlledByVissim = false;
	this->m_vSimulatorVehicleData.push_back(simulatorVehicleData);
}

bool VissimConnector::step()
{
	// Set ego vehicles and clear info in queue
	Simulator_Veh_Data* pEgoData = this->m_vSimulatorVehicleData.data();
	int iEgoDataSize = this->m_vSimulatorVehicleData.size();
	bool bSuccess1 = VISSIM_SetDriverVehicles(iEgoDataSize, pEgoData);
	this->m_vSimulatorVehicleData.clear();

	// Get actor vehicles and set info to queue
	this->m_vVissimVehicleData.clear();
	int iActorDataCount;
	VISSIM_Veh_Data* pActorData = nullptr;
	VISSIM_GetTrafficVehicles(&iActorDataCount, &pActorData);
	for (int i = 0; i < iActorDataCount; i++)
	{
		this->m_vVissimVehicleData.push_back(pActorData[i]);
	}

	return bSuccess1;
}

VISSIM_Veh_Data VissimConnector::getTrafficVehiclesData(int iNumber)
{
	if (iNumber < this->m_vVissimVehicleData.size())
	{
		return this->m_vVissimVehicleData[iNumber];
	}
	else {
		return VISSIM_Veh_Data{};
	}
}

int VissimConnector::getTrafficVehiclesDataCount()
{
	return this->m_vVissimVehicleData.size();
}

