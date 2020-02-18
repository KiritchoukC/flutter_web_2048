import 'package:swipedetector/swipedetector.dart';

const String anonymousPicture =
    'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png';

RegExp emailValidationRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

SwipeConfiguration swipeConfiguration = SwipeConfiguration(
  verticalSwipeMinVelocity: 5.0,
  verticalSwipeMinDisplacement: 5.0,
  verticalSwipeMaxWidthThreshold: 1000.0,
  horizontalSwipeMaxHeightThreshold: 1000.0,
  horizontalSwipeMinDisplacement: 5.0,
  horizontalSwipeMinVelocity: 5.0,
);
