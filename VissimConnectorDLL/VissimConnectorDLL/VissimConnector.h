#pragma once

#ifdef VISSIMCONNECTORDLL_EXPORTS
#define VISSIMCONNECTORDLL_API __declspec(dllexport)
#else
#define VISSIMCONNECTORDLL_API __declspec(dllimport)
#endif

#include <vector>
#include <string>
#include "DrivingSimulatorProxy.h"

//#define NAME_MAX_LENGTH  100
//#define MAX_UDA           16
//
//enum TurningIndicatorType : int
//{
//	TurningIndicatorLeft = 1,
//	TurningIndicatorNone = 0,
//	TurningIndicatorRight = -1
//};
//
//struct Simulator_Veh_Data
//{
//	int    VehicleID;          /* vehicle number in Vissim, irrelevant for new vehicles */
//	int    VehicleType;        /* vehicle type number in Vissim */
//	double Position_X;         /* front center of the vehicle in min m */
//	double Position_Y;         /* front center of the vehicle in min m */
//	double Position_Z;         /* front center of the vehicle in min m */
//	double Orient_Heading;     /* in radians, eastbound = zero, northbound = +Pi/2 */
//	double Orient_Pitch;       /* in radians, uphill = positive */
//	double Speed;              /* in m/s */
//	bool   Create;             /* new vehicle to be placed in the network */
//	int    CreateID;           /* unique ID for the new vehicle to be returned in VISSIM_Veh_Data */
//	bool   Delete;             /* vehicle to be removed from the network */
//	bool   ControlledByVissim; /* affects next time step */
//	int    RoutingDecisionNo;  /* used once if ControlledByVissim is changed from false to true */
//	int    RouteNo;            /* used once if ControlledByVissim is changed from false to true */
//};
//
//struct VISSIM_Veh_Data
//{
//	int    VehicleID;
//	int    VehicleType;                      /* vehicle type number from Vissim */
//	char   ModelFileName[NAME_MAX_LENGTH];   /* *.v3d */
//	int    color;                            /* RGB */
//	double Position_X;                       /* front center of the vehicle in m */
//	double Position_Y;                       /* front center of the vehicle in m */
//	double Position_Z;                       /* front center of the vehicle in m */
//	double Orient_Heading;                   /* in radians, eastbound = zero, northbound = +Pi/2 */
//	double Orient_Pitch;                     /* in radians, uphill = positive */
//	double Speed;                            /* in m/s */
//	int    LeadingVehicleID;                 /* relevant vehicle in front */
//	int    TrailingVehicleID;                /* next vehicle back on the same lane */
//	int    LinkID;                           /* Vissim link attribute "Number" */
//	char   LinkName[NAME_MAX_LENGTH];        /* empty if "Name" not set in Vissim */
//	double LinkCoordinate;                   /* in m */
//	int    LaneIndex;                        /* 0 = rightmost */
//	TurningIndicatorType TurningIndicator;   /* 1 = left, 0 = none, -1 = right */
//	int    PreviousIndex;                    /* for interpolation: index in the array in the previous Vissim time step, < 0 = new in the visibility area */
//	int    NumUDAs;                          /* the number of UDA values in the following array */
//	double UDA[MAX_UDA];                     /* the first MAX_UDA user-defined numeric vehicle attributes */
//	int    CreateID;                         /* unique ID as passed from the simulator for the new vehicle, else zero */
//	bool   ControlledByVissim;               /* false for vehicles controlled by the Driving Simulator */
//};



class VISSIMCONNECTORDLL_API VissimConnector {
private:
	std::vector<Simulator_Veh_Data> m_vSimulatorVehicleData;
	std::vector<VISSIM_Veh_Data> m_vVissimVehicleData;
	std::vector<int> m_vRegisteredVehicles;
	bool m_bIsConnected = false;
	bool m_bSimulatorVehicleDataSpawned = false;
	std::wstring m_strINPXFilename;
public:
	VissimConnector(const std::wstring &strINPXFileName);
	VissimConnector();
	~VissimConnector();
	bool connect(
		unsigned short simulatorFrequency,
		double visibilityRadius,
		unsigned short maxSimulatorVeh,
		unsigned short maxSimulatorPed,
		unsigned short maxSimulatorDet, 
		unsigned short maxTotalVeh,
		unsigned short maxVissimPed,
		unsigned short maxVissimSigGrp);

	bool disconnect();
	void setDriverVehiclesData(int iVehicleID, Simulator_Veh_Data simulatorVehicleData);
	bool step();
	VISSIM_Veh_Data getTrafficVehiclesData(int iNumber);
	int getTrafficVehiclesDataCount();

};