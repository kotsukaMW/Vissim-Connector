%% About defineVissimInterface.mlx
% This file defines the MATLAB interface to the library |VissimInterface|.
%
% Commented sections represent C++ functionality that MATLAB cannot automatically define. To include
% functionality, uncomment a section and provide values for &lt;SHAPE&gt;, &lt;DIRECTION&gt;, etc. For more
% information, see <matlab:helpview(fullfile(docroot,'matlab','helptargets.map'),'cpp_define_interface') Define MATLAB Interface for C++ Library>.



%% Setup. Do not edit this section.
function libDef = defineVissimInterface()
libDef = clibgen.LibraryDefinition("VissimInterfaceData.xml");
%% OutputFolder and Libraries 
libDef.OutputFolder = "E:\OneDrive - MathWorks\projects\vissim-connector\VissimInterfaceBuild";
libDef.Libraries = "E:\OneDrive - MathWorks\projects\vissim-connector\VissimConnectorDLL\x64\Release\VissimConnectorDLL.lib";

%% C++ class |Simulator_Veh_Data| with MATLAB name |clib.VissimInterface.Simulator_Veh_Data| 
Simulator_Veh_DataDefinition = addClass(libDef, "Simulator_Veh_Data", "MATLABName", "clib.VissimInterface.Simulator_Veh_Data", ...
    "Description", "clib.VissimInterface.Simulator_Veh_Data    Representation of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class constructor for C++ class |Simulator_Veh_Data| 
% C++ Signature: Simulator_Veh_Data::Simulator_Veh_Data()
Simulator_Veh_DataConstructor1Definition = addConstructor(Simulator_Veh_DataDefinition, ...
    "Simulator_Veh_Data::Simulator_Veh_Data()", ...
    "Description", "clib.VissimInterface.Simulator_Veh_Data    Constructor of C++ class Simulator_Veh_Data."); % Modify help description values as needed.
validate(Simulator_Veh_DataConstructor1Definition);

%% C++ class constructor for C++ class |Simulator_Veh_Data| 
% C++ Signature: Simulator_Veh_Data::Simulator_Veh_Data(Simulator_Veh_Data const & input1)
Simulator_Veh_DataConstructor2Definition = addConstructor(Simulator_Veh_DataDefinition, ...
    "Simulator_Veh_Data::Simulator_Veh_Data(Simulator_Veh_Data const & input1)", ...
    "Description", "clib.VissimInterface.Simulator_Veh_Data    Constructor of C++ class Simulator_Veh_Data."); % Modify help description values as needed.
defineArgument(Simulator_Veh_DataConstructor2Definition, "input1", "clib.VissimInterface.Simulator_Veh_Data", "input");
validate(Simulator_Veh_DataConstructor2Definition);

%% C++ class public data member |VehicleID| for C++ class |Simulator_Veh_Data| 
% C++ Signature: int Simulator_Veh_Data::VehicleID
addProperty(Simulator_Veh_DataDefinition, "VehicleID", "int32", ...
    "Description", "int32    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |VehicleType| for C++ class |Simulator_Veh_Data| 
% C++ Signature: int Simulator_Veh_Data::VehicleType
addProperty(Simulator_Veh_DataDefinition, "VehicleType", "int32", ...
    "Description", "int32    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Position_X| for C++ class |Simulator_Veh_Data| 
% C++ Signature: double Simulator_Veh_Data::Position_X
addProperty(Simulator_Veh_DataDefinition, "Position_X", "double", ...
    "Description", "double    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Position_Y| for C++ class |Simulator_Veh_Data| 
% C++ Signature: double Simulator_Veh_Data::Position_Y
addProperty(Simulator_Veh_DataDefinition, "Position_Y", "double", ...
    "Description", "double    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Position_Z| for C++ class |Simulator_Veh_Data| 
% C++ Signature: double Simulator_Veh_Data::Position_Z
addProperty(Simulator_Veh_DataDefinition, "Position_Z", "double", ...
    "Description", "double    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Orient_Heading| for C++ class |Simulator_Veh_Data| 
% C++ Signature: double Simulator_Veh_Data::Orient_Heading
addProperty(Simulator_Veh_DataDefinition, "Orient_Heading", "double", ...
    "Description", "double    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Orient_Pitch| for C++ class |Simulator_Veh_Data| 
% C++ Signature: double Simulator_Veh_Data::Orient_Pitch
addProperty(Simulator_Veh_DataDefinition, "Orient_Pitch", "double", ...
    "Description", "double    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Speed| for C++ class |Simulator_Veh_Data| 
% C++ Signature: double Simulator_Veh_Data::Speed
addProperty(Simulator_Veh_DataDefinition, "Speed", "double", ...
    "Description", "double    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Create| for C++ class |Simulator_Veh_Data| 
% C++ Signature: bool Simulator_Veh_Data::Create
addProperty(Simulator_Veh_DataDefinition, "Create", "logical", ...
    "Description", "logical    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |CreateID| for C++ class |Simulator_Veh_Data| 
% C++ Signature: int Simulator_Veh_Data::CreateID
addProperty(Simulator_Veh_DataDefinition, "CreateID", "int32", ...
    "Description", "int32    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Delete| for C++ class |Simulator_Veh_Data| 
% C++ Signature: bool Simulator_Veh_Data::Delete
addProperty(Simulator_Veh_DataDefinition, "Delete", "logical", ...
    "Description", "logical    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |ControlledByVissim| for C++ class |Simulator_Veh_Data| 
% C++ Signature: bool Simulator_Veh_Data::ControlledByVissim
addProperty(Simulator_Veh_DataDefinition, "ControlledByVissim", "logical", ...
    "Description", "logical    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |RoutingDecisionNo| for C++ class |Simulator_Veh_Data| 
% C++ Signature: int Simulator_Veh_Data::RoutingDecisionNo
addProperty(Simulator_Veh_DataDefinition, "RoutingDecisionNo", "int32", ...
    "Description", "int32    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |RouteNo| for C++ class |Simulator_Veh_Data| 
% C++ Signature: int Simulator_Veh_Data::RouteNo
addProperty(Simulator_Veh_DataDefinition, "RouteNo", "int32", ...
    "Description", "int32    Data member of C++ class Simulator_Veh_Data."); % Modify help description values as needed.

%% C++ enumeration |TurningIndicatorType| with MATLAB name |clib.VissimInterface.TurningIndicatorType| 
addEnumeration(libDef, "TurningIndicatorType", "int32",...
    [...
      "TurningIndicatorLeft",...  % 1
      "TurningIndicatorNone",...  % 0
      "TurningIndicatorRight",...  % -1
    ],...
    "MATLABName", "clib.VissimInterface.TurningIndicatorType", ...
    "Description", "clib.VissimInterface.TurningIndicatorType    Representation of C++ enumeration TurningIndicatorType."); % Modify help description values as needed.

%% C++ class |VISSIM_Veh_Data| with MATLAB name |clib.VissimInterface.VISSIM_Veh_Data| 
VISSIM_Veh_DataDefinition = addClass(libDef, "VISSIM_Veh_Data", "MATLABName", "clib.VissimInterface.VISSIM_Veh_Data", ...
    "Description", "clib.VissimInterface.VISSIM_Veh_Data    Representation of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class constructor for C++ class |VISSIM_Veh_Data| 
% C++ Signature: VISSIM_Veh_Data::VISSIM_Veh_Data()
VISSIM_Veh_DataConstructor1Definition = addConstructor(VISSIM_Veh_DataDefinition, ...
    "VISSIM_Veh_Data::VISSIM_Veh_Data()", ...
    "Description", "clib.VissimInterface.VISSIM_Veh_Data    Constructor of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.
validate(VISSIM_Veh_DataConstructor1Definition);

%% C++ class constructor for C++ class |VISSIM_Veh_Data| 
% C++ Signature: VISSIM_Veh_Data::VISSIM_Veh_Data(VISSIM_Veh_Data const & input1)
VISSIM_Veh_DataConstructor2Definition = addConstructor(VISSIM_Veh_DataDefinition, ...
    "VISSIM_Veh_Data::VISSIM_Veh_Data(VISSIM_Veh_Data const & input1)", ...
    "Description", "clib.VissimInterface.VISSIM_Veh_Data    Constructor of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.
defineArgument(VISSIM_Veh_DataConstructor2Definition, "input1", "clib.VissimInterface.VISSIM_Veh_Data", "input");
validate(VISSIM_Veh_DataConstructor2Definition);

%% C++ class public data member |VehicleID| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::VehicleID
addProperty(VISSIM_Veh_DataDefinition, "VehicleID", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |VehicleType| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::VehicleType
addProperty(VISSIM_Veh_DataDefinition, "VehicleType", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |ModelFileName| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: char [100] VISSIM_Veh_Data::ModelFileName
addProperty(VISSIM_Veh_DataDefinition, "ModelFileName", "clib.array.VissimInterface.Char", [100], ... % '<MLTYPE>' can be clib.array.VissimInterface.Char, or int8
    "Description", "clib.array.VissimInterface.Char    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |color| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::color
addProperty(VISSIM_Veh_DataDefinition, "color", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Position_X| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::Position_X
addProperty(VISSIM_Veh_DataDefinition, "Position_X", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Position_Y| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::Position_Y
addProperty(VISSIM_Veh_DataDefinition, "Position_Y", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Position_Z| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::Position_Z
addProperty(VISSIM_Veh_DataDefinition, "Position_Z", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Orient_Heading| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::Orient_Heading
addProperty(VISSIM_Veh_DataDefinition, "Orient_Heading", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Orient_Pitch| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::Orient_Pitch
addProperty(VISSIM_Veh_DataDefinition, "Orient_Pitch", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |Speed| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::Speed
addProperty(VISSIM_Veh_DataDefinition, "Speed", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |LeadingVehicleID| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::LeadingVehicleID
addProperty(VISSIM_Veh_DataDefinition, "LeadingVehicleID", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |TrailingVehicleID| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::TrailingVehicleID
addProperty(VISSIM_Veh_DataDefinition, "TrailingVehicleID", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |LinkID| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::LinkID
addProperty(VISSIM_Veh_DataDefinition, "LinkID", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |LinkName| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: char [100] VISSIM_Veh_Data::LinkName
addProperty(VISSIM_Veh_DataDefinition, "LinkName", "clib.array.VissimInterface.Char", [100], ... % '<MLTYPE>' can be clib.array.VissimInterface.Char, or int8
    "Description", "clib.array.VissimInterface.Char    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |LinkCoordinate| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double VISSIM_Veh_Data::LinkCoordinate
addProperty(VISSIM_Veh_DataDefinition, "LinkCoordinate", "double", ...
    "Description", "double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |LaneIndex| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::LaneIndex
addProperty(VISSIM_Veh_DataDefinition, "LaneIndex", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |TurningIndicator| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: TurningIndicatorType VISSIM_Veh_Data::TurningIndicator
addProperty(VISSIM_Veh_DataDefinition, "TurningIndicator", "clib.VissimInterface.TurningIndicatorType", ...
    "Description", "clib.VissimInterface.TurningIndicatorType    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |PreviousIndex| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::PreviousIndex
addProperty(VISSIM_Veh_DataDefinition, "PreviousIndex", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |NumUDAs| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::NumUDAs
addProperty(VISSIM_Veh_DataDefinition, "NumUDAs", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |UDA| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: double [16] VISSIM_Veh_Data::UDA
addProperty(VISSIM_Veh_DataDefinition, "UDA", "clib.array.VissimInterface.Double", [16], ... % '<MLTYPE>' can be clib.array.VissimInterface.Double, or double
    "Description", "clib.array.VissimInterface.Double    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |CreateID| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: int VISSIM_Veh_Data::CreateID
addProperty(VISSIM_Veh_DataDefinition, "CreateID", "int32", ...
    "Description", "int32    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class public data member |ControlledByVissim| for C++ class |VISSIM_Veh_Data| 
% C++ Signature: bool VISSIM_Veh_Data::ControlledByVissim
addProperty(VISSIM_Veh_DataDefinition, "ControlledByVissim", "logical", ...
    "Description", "logical    Data member of C++ class VISSIM_Veh_Data."); % Modify help description values as needed.

%% C++ class |VissimConnector| with MATLAB name |clib.VissimInterface.VissimConnector| 
VissimConnectorDefinition = addClass(libDef, "VissimConnector", "MATLABName", "clib.VissimInterface.VissimConnector", ...
    "Description", "clib.VissimInterface.VissimConnector    Representation of C++ class VissimConnector."); % Modify help description values as needed.

%% C++ class constructor for C++ class |VissimConnector| 
% C++ Signature: VissimConnector::VissimConnector(std::wstring const & strINPXFileName)
VissimConnectorConstructor1Definition = addConstructor(VissimConnectorDefinition, ...
    "VissimConnector::VissimConnector(std::wstring const & strINPXFileName)", ...
    "Description", "clib.VissimInterface.VissimConnector    Constructor of C++ class VissimConnector."); % Modify help description values as needed.
defineArgument(VissimConnectorConstructor1Definition, "strINPXFileName", "string", "input");
validate(VissimConnectorConstructor1Definition);

%% C++ class constructor for C++ class |VissimConnector| 
% C++ Signature: VissimConnector::VissimConnector()
VissimConnectorConstructor2Definition = addConstructor(VissimConnectorDefinition, ...
    "VissimConnector::VissimConnector()", ...
    "Description", "clib.VissimInterface.VissimConnector    Constructor of C++ class VissimConnector."); % Modify help description values as needed.
validate(VissimConnectorConstructor2Definition);

%% C++ class method |connect| for C++ class |VissimConnector| 
% C++ Signature: bool VissimConnector::connect(unsigned short simulatorFrequency,double visibilityRadius,unsigned short maxSimulatorVeh,unsigned short maxSimulatorPed,unsigned short maxSimulatorDet,unsigned short maxTotalVeh,unsigned short maxVissimPed,unsigned short maxVissimSigGrp)
connectDefinition = addMethod(VissimConnectorDefinition, ...
    "bool VissimConnector::connect(unsigned short simulatorFrequency,double visibilityRadius,unsigned short maxSimulatorVeh,unsigned short maxSimulatorPed,unsigned short maxSimulatorDet,unsigned short maxTotalVeh,unsigned short maxVissimPed,unsigned short maxVissimSigGrp)", ...
    "MATLABName", "connect", ...
    "Description", "connect    Method of C++ class VissimConnector."); % Modify help description values as needed.
defineArgument(connectDefinition, "simulatorFrequency", "uint16");
defineArgument(connectDefinition, "visibilityRadius", "double");
defineArgument(connectDefinition, "maxSimulatorVeh", "uint16");
defineArgument(connectDefinition, "maxSimulatorPed", "uint16");
defineArgument(connectDefinition, "maxSimulatorDet", "uint16");
defineArgument(connectDefinition, "maxTotalVeh", "uint16");
defineArgument(connectDefinition, "maxVissimPed", "uint16");
defineArgument(connectDefinition, "maxVissimSigGrp", "uint16");
defineOutput(connectDefinition, "RetVal", "logical");
validate(connectDefinition);

%% C++ class method |disconnect| for C++ class |VissimConnector| 
% C++ Signature: bool VissimConnector::disconnect()
disconnectDefinition = addMethod(VissimConnectorDefinition, ...
    "bool VissimConnector::disconnect()", ...
    "MATLABName", "disconnect", ...
    "Description", "disconnect    Method of C++ class VissimConnector."); % Modify help description values as needed.
defineOutput(disconnectDefinition, "RetVal", "logical");
validate(disconnectDefinition);

%% C++ class method |setDriverVehiclesData| for C++ class |VissimConnector| 
% C++ Signature: void VissimConnector::setDriverVehiclesData(int iVehicleID,Simulator_Veh_Data simulatorVehicleData)
setDriverVehiclesDataDefinition = addMethod(VissimConnectorDefinition, ...
    "void VissimConnector::setDriverVehiclesData(int iVehicleID,Simulator_Veh_Data simulatorVehicleData)", ...
    "MATLABName", "setDriverVehiclesData", ...
    "Description", "setDriverVehiclesData    Method of C++ class VissimConnector."); % Modify help description values as needed.
defineArgument(setDriverVehiclesDataDefinition, "iVehicleID", "int32");
defineArgument(setDriverVehiclesDataDefinition, "simulatorVehicleData", "clib.VissimInterface.Simulator_Veh_Data");
validate(setDriverVehiclesDataDefinition);

%% C++ class method |step| for C++ class |VissimConnector| 
% C++ Signature: bool VissimConnector::step()
stepDefinition = addMethod(VissimConnectorDefinition, ...
    "bool VissimConnector::step()", ...
    "MATLABName", "step", ...
    "Description", "step    Method of C++ class VissimConnector."); % Modify help description values as needed.
defineOutput(stepDefinition, "RetVal", "logical");
validate(stepDefinition);

%% C++ class method |getTrafficVehiclesData| for C++ class |VissimConnector| 
% C++ Signature: VISSIM_Veh_Data VissimConnector::getTrafficVehiclesData(int iNumber)
getTrafficVehiclesDataDefinition = addMethod(VissimConnectorDefinition, ...
    "VISSIM_Veh_Data VissimConnector::getTrafficVehiclesData(int iNumber)", ...
    "MATLABName", "getTrafficVehiclesData", ...
    "Description", "getTrafficVehiclesData    Method of C++ class VissimConnector."); % Modify help description values as needed.
defineArgument(getTrafficVehiclesDataDefinition, "iNumber", "int32");
defineOutput(getTrafficVehiclesDataDefinition, "RetVal", "clib.VissimInterface.VISSIM_Veh_Data");
validate(getTrafficVehiclesDataDefinition);

%% C++ class method |getTrafficVehiclesDataCount| for C++ class |VissimConnector| 
% C++ Signature: int VissimConnector::getTrafficVehiclesDataCount()
getTrafficVehiclesDataCountDefinition = addMethod(VissimConnectorDefinition, ...
    "int VissimConnector::getTrafficVehiclesDataCount()", ...
    "MATLABName", "getTrafficVehiclesDataCount", ...
    "Description", "getTrafficVehiclesDataCount    Method of C++ class VissimConnector."); % Modify help description values as needed.
defineOutput(getTrafficVehiclesDataCountDefinition, "RetVal", "int32");
validate(getTrafficVehiclesDataCountDefinition);

%% C++ class constructor for C++ class |VissimConnector| 
% C++ Signature: VissimConnector::VissimConnector(VissimConnector const & input1)
VissimConnectorConstructor3Definition = addConstructor(VissimConnectorDefinition, ...
    "VissimConnector::VissimConnector(VissimConnector const & input1)", ...
    "Description", "clib.VissimInterface.VissimConnector    Constructor of C++ class VissimConnector."); % Modify help description values as needed.
defineArgument(VissimConnectorConstructor3Definition, "input1", "clib.VissimInterface.VissimConnector", "input");
validate(VissimConnectorConstructor3Definition);

%% Validate the library definition
validate(libDef);

end
