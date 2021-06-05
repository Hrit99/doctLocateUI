import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:upcloud/models/doctor.dart';
import 'package:upcloud/models/filterOptions.dart';

List<Doctor> doctors = [
  Doctor(
    distFrom: 0,
    name: "doctor1",
    hospitalName: "doctor1Hosp",
    lat: 24.692357,
    long: 78.398702,
    speciality: "doctor1Spc",
    bookmark: false,
    likes: 0,
    photo: "assets/icons/picon.png",
    price: 221,
    daysAvailable: [
      days.Monday.toString(),
      days.Friday.toString(),
      days.Saturday.toString()
    ],
    gender: genders.female.toString(),
    timingsAvailable: [
      timings.afternoon.toString(),
      timings.evening.toString()
    ],
  ),
  Doctor(
    distFrom: 0,
    name: "doctor2",
    hospitalName: "doctor2Hosp",
    lat: 24.690753,
    long: 78.406854,
    speciality: "doctor2Spc",
    bookmark: false,
    likes: 0,
    photo: "assets/icons/picon.png",
    price: 222,
    daysAvailable: [
      days.Wednesday.toString(),
      days.Tuesday.toString(),
      days.Saturday.toString()
    ],
    gender: genders.male.toString(),
    timingsAvailable: [timings.morning.toString(), timings.evening.toString()],
  ),
  Doctor(
    distFrom: 0,
    name: "doctor3",
    hospitalName: "doctor3Hosp",
    lat: 24.687156,
    long: 78.408804,
    speciality: "doctor3Spc",
    bookmark: true,
    likes: 0,
    photo: "assets/icons/picon.png",
    price: 223,
    daysAvailable: [
      days.Monday.toString(),
      days.Tuesday.toString(),
      days.Saturday.toString()
    ],
    gender: genders.male.toString(),
    timingsAvailable: [
      timings.afternoon.toString(),
      timings.evening.toString()
    ],
  )
];
