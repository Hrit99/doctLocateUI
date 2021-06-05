List<String> dayName = [];
enum days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

List<String> timingName = ["morning", "afternoon", "evening"];
enum timings { morning, afternoon, evening }

List<String> genderName = ["male", "female", "others"];
enum genders { male, female, others }

List<String> rateRangeName = [
  "150 - 350",
  "350 - 750",
  "750 - 1000",
  "1000 - 1500"
];

List<List<int>> rateRangeVal = [
  [150, 350],
  [350, 750],
  [750, 1000],
  [1000, 1500]
];
// List<String> filterName = [
//   "availability",
//   "days",
//   "timings",
//   "genders",
//   "rateRange"
// ];
enum filters { availability, genders, rateRange }
List enumFilterList = [dayName, genderName, rateRangeName];
// List enumFilter = [days, genders, rateRange];
