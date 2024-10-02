class mode_obj_info {
  late var value;

  late String name;

  late String firebase_name;

  late int mode;

  late int pri_stat_1;
  late int pri_stat_2;

  bool status = false;

  mode_obj_info(
      {required this.name,
      required this.mode,
      required this.firebase_name,
      required this.pri_stat_1,
      required this.pri_stat_2});
}

List<mode_obj_info> listMode1info = [
  mode_obj_info(
    name: "Calculated Engine Load",
    mode: 0x01,
    firebase_name: "2000/41/CEL",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Engine Coolant Temperature",
    mode: 0x01,
    firebase_name: "2000/41/ET",
    pri_stat_1: 1,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Short Term Fuel Trim - Bank 1",
    mode: 0x01,
    firebase_name: "2000/41/STFT1",
    pri_stat_1: 2,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Long Term Fuel Trim - Bank 1",
    mode: 0x01,
    firebase_name: "2000/41/LTFT1",
    pri_stat_1: 3,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Intake Manifold Absolute Pressure",
    mode: 0x01,
    firebase_name: "2000/41/IMAP",
    pri_stat_1: 4,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Engine Speed",
    mode: 0x01,
    firebase_name: "2000/41/ES",
    pri_stat_1: 5,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Vehicle Speed",
    mode: 0x01,
    firebase_name: "2000/41/VS",
    pri_stat_1: 6,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Timing Advance",
    mode: 0x01,
    firebase_name: "2000/41/TA",
    pri_stat_1: 7,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Intake Air Temperature",
    mode: 0x01,
    firebase_name: "2000/41/IAT",
    pri_stat_1: 8,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Throttle Position",
    mode: 0x01,
    firebase_name: "2000/41/TP",
    pri_stat_1: 9,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Oxygen Sensors Present",
    mode: 0x01,
    firebase_name: "2000/41/OSP",
    pri_stat_1: 10,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Oxygen Sensor Voltage 1",
    mode: 0x01,
    firebase_name: "2000/41/OSV1",
    pri_stat_1: 11,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Oxygen Sensor Short Term Fuel Trim 1",
    mode: 0x01,
    firebase_name: "2000/41/STFT1",
    pri_stat_1: 11,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Oxygen Sensor Voltage 2",
    mode: 0x01,
    firebase_name: "2000/41/OSV2",
    pri_stat_1: 12,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Oxygen Sensor Short Term Fuel Trim 2",
    mode: 0x01,
    firebase_name: "2000/41/STFT2",
    pri_stat_1: 12,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "OBD Standards",
    mode: 0x01,
    firebase_name: "2000/41/OBDS",
    pri_stat_1: 13,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Run Time Since Engine Start",
    mode: 0x01,
    firebase_name: "2000/41/RTES",
    pri_stat_1: 14,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Distance Traveled",
    mode: 0x01,
    firebase_name: "2000/41/DT",
    pri_stat_1: 15,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Commanded Evaporative Purge",
    mode: 0x01,
    firebase_name: "2000/41/CEP",
    pri_stat_1: 16,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Warm-ups Since Codes Cleared",
    mode: 0x01,
    firebase_name: "2000/41/WSCC",
    pri_stat_1: 17,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Distance Traveled Since Codes Cleared",
    mode: 0x01,
    firebase_name: "2000/41/DTCC",
    pri_stat_1: 18,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Absolute Barometric Pressure",
    mode: 0x01,
    firebase_name: "2000/41/ABP",
    pri_stat_1: 19,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Control Module Voltage",
    mode: 0x01,
    firebase_name: "2000/41/CMV",
    pri_stat_1: 20,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Absolute Load Value",
    mode: 0x01,
    firebase_name: "2000/41/ALV",
    pri_stat_1: 21,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Commanded Air-Fuel Equivalence Ratio",
    mode: 0x01,
    firebase_name: "2000/41/CAFER",
    pri_stat_1: 22,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Relative Throttle Position",
    mode: 0x01,
    firebase_name: "2000/41/RTP",
    pri_stat_1: 23,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Ambient Air Temperature",
    mode: 0x01,
    firebase_name: "2000/41/AAT",
    pri_stat_1: 24,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Absolute Throttle Position B",
    mode: 0x01,
    firebase_name: "2000/41/ATPB",
    pri_stat_1: 25,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Accelerator Pedal Position D",
    mode: 0x01,
    firebase_name: "2000/41/APPD",
    pri_stat_1: 26,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Accelerator Pedal Position E",
    mode: 0x01,
    firebase_name: "2000/41/APPE",
    pri_stat_1: 27,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Commanded Throttle Actuator",
    mode: 0x01,
    firebase_name: "2000/41/CTA",
    pri_stat_1: 28,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Fuel Type",
    mode: 0x01,
    firebase_name: "2000/41/FT",
    pri_stat_1: 29,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Relative Accelerator Pedal Position",
    mode: 0x01,
    firebase_name: "2000/41/RAPP",
    pri_stat_1: 30,
    pri_stat_2: 0,
  ),
];

List<mode_obj_info> listMode4info = [
  mode_obj_info(
    name: "Injector 1",
    mode: 0x30,
    firebase_name: "2000/70/INJ1",
    pri_stat_1: 0x10,
    pri_stat_2: 1,
  ),
  mode_obj_info(
    name: "Injector 2",
    mode: 0x30,
    firebase_name: "2000/70/INJ2",
    pri_stat_1: 0x10,
    pri_stat_2: 2,
  ),
  mode_obj_info(
    name: "Injector 3",
    mode: 0x30,
    firebase_name: "2000/70/INJ3",
    pri_stat_1: 0x10,
    pri_stat_2: 3,
  ),
  mode_obj_info(
    name: "Injector 4",
    mode: 0x30,
    firebase_name: "2000/70/INJ4",
    pri_stat_1: 0x10,
    pri_stat_2: 4,
  ),
  mode_obj_info(
    name: "Fuel Pump",
    mode: 0x30,
    firebase_name: "2000/70/ACT/11",
    pri_stat_1: 0x11,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Purge Control Solenoid Valve",
    mode: 0x30,
    firebase_name: "2000/70/ACT/12",
    pri_stat_1: 0x12,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Ignition Timing 5 BTDC",
    mode: 0x30,
    firebase_name: "2000/70/ACT/13",
    pri_stat_1: 0x13,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Vent Solenoid Valve",
    mode: 0x30,
    firebase_name: "2000/70/ACT/17",
    pri_stat_1: 0x17,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "A/C Compressor Relay",
    mode: 0x30,
    firebase_name: "2000/70/ACT/18",
    pri_stat_1: 0x18,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Oil Feeder Control Valve",
    mode: 0x30,
    firebase_name: "2000/70/ACT/19",
    pri_stat_1: 0x19,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Cooling Fan Relay(High)",
    mode: 0x30,
    firebase_name: "2000/70/ACT/14",
    pri_stat_1: 0x14,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Cooling Fan Relay(Low)",
    mode: 0x30,
    firebase_name: "2000/70/ACT/15",
    pri_stat_1: 0x15,
    pri_stat_2: 0,
  ),
];

List<mode_obj_info> listMode6info = [
  mode_obj_info(
    name: "O2 Sensor Bank 1 Sensor 1",
    mode: 0x06,
    firebase_name: "2000/46/OSBS",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Catalyst Monitor Bank 1",
    mode: 0x06,
    firebase_name: "2000/46/CMB",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 1 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD1/0B",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 1 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD1/0C",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 2 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD2/0B",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 2 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD2/0C",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 3 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD3/0B",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 3 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD3/0C",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 4 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD4/0B",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
  mode_obj_info(
    name: "Misfile Cylinder 4 Data",
    mode: 0x06,
    firebase_name: "2000/46/MCD4/0C",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
];

List<mode_obj_info> listMode3info = [
  mode_obj_info(
    name: "Stored DTC",
    mode: 0x03,
    firebase_name: "2000/43/DTC",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
];

List<mode_obj_info> listMode7info = [
  mode_obj_info(
    name: "Pending DTC",
    mode: 0x07,
    firebase_name: "2000/47/DTC",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
];

List<mode_obj_info> listMode9info = [
  mode_obj_info(
    name: "VIN",
    mode: 0x09,
    firebase_name: "2000/49/VIN",
    pri_stat_1: 0,
    pri_stat_2: 0,
  ),
];
