import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';

class Car {
  const Car({
    required this.title,
    required this.plateNumber,
    required this.specs,
    required this.odometer,
    required this.location,
    required this.imagePath,
    required this.status,
  });

  final String title;
  final String plateNumber;
  final String specs;
  final String odometer;
  final String location;
  final String imagePath;
  final CarStatus status;
}

enum CarStatus { onTrip, inGarage }

extension CarStatusStyle on CarStatus {
  String get label {
    switch (this) {
      case CarStatus.onTrip:
        return 'On Trip';
      case CarStatus.inGarage:
        return 'In Garage';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CarStatus.onTrip:
        return AppColors.warningBackground;
      case CarStatus.inGarage:
        return AppColors.garageBackground;
    }
  }

  Color get foregroundColor {
    switch (this) {
      case CarStatus.onTrip:
        return AppColors.accentWarning;
      case CarStatus.inGarage:
        return AppColors.accentSuccess;
    }
  }
}

class Trip {
  const Trip({
    required this.title,
    required this.plateNumber,
    required this.specs,
    required this.route,
    required this.driverName,
    required this.inspected,
    required this.odometer,
    required this.dateLabel,
    required this.imagePath,
    required this.status,
  });

  final String title;
  final String plateNumber;
  final String specs;
  final String route;
  final String driverName;
  final bool inspected;
  final String odometer;
  final String dateLabel;
  final String imagePath;
  final TripStatus status;
}

enum TripStatus { onTrip, inWorkshop }

extension TripStatusStyle on TripStatus {
  String get label {
    switch (this) {
      case TripStatus.onTrip:
        return 'On Trip';
      case TripStatus.inWorkshop:
        return 'In Workshop';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TripStatus.onTrip:
        return AppColors.warningBackground;
      case TripStatus.inWorkshop:
        return AppColors.dangerBackground;
    }
  }

  Color get foregroundColor {
    switch (this) {
      case TripStatus.onTrip:
        return AppColors.accentWarning;
      case TripStatus.inWorkshop:
        return AppColors.accentDanger;
    }
  }
}
