double calculateMatchPercentage(Map<String, dynamic> userPrefs, Map<String, dynamic> hostel) {
  int matchCount = 0;
  int totalCount = 0;

  if (userPrefs['hostel_type'] == hostel['hostel_gender'] || hostel['hostel_gender'] == 'Mixed') {
    matchCount++;
  }
  totalCount++;

  final userBudgetRange = userPrefs['budget']?.split(' - ').map((e) => num.tryParse(e.replaceAll(RegExp(r'[^\d]'), '')) ?? 0).toList() ?? [0, 0];
  final hostelPrices = hostel['room_types']?.values.map((e) => e as num).toList() ?? [];

  if (userBudgetRange.length == 2) {
    final minBudget = userBudgetRange[0];
    final maxBudget = userBudgetRange[1];
    if (hostelPrices.any((price) => price >= minBudget && price <= maxBudget)) {
      matchCount++;
    }
  }
  totalCount++;

  final userRoomType = userPrefs['house_type'];
  final hostelRoomTypes = hostel['room_types']?.keys.toList() ?? [];

  if (hostelRoomTypes.contains(userRoomType)) {
    matchCount++;
  }
  totalCount++;

  Map<String, dynamic> userAmenities = {
    'wifi': userPrefs['wifi'],
    'laundry_services': userPrefs['laundry_services'],
    'cafeteria': userPrefs['cafeteria'],
    'parking': userPrefs['parking'],
    'security': userPrefs['security'],
  };

  Map<String, dynamic> hostelAmenities = {
    'wifi': hostel['Wi-Fi'],
    'laundry_services': hostel['Laundry Service'],
    'cafeteria': hostel['Cafeteria'],
    'parking': hostel['Parking'],
    'security': hostel['Security'],
  };

  for (String amenity in userAmenities.keys) {
    var userValue = userAmenities[amenity];
    var hostelValue = hostelAmenities[amenity];

    if (userValue == null) {
      userValue = false;
    }
    if (hostelValue == null) {
      hostelValue = false;
    }

    if (userValue == hostelValue) {
      matchCount++;
    }
    totalCount++;
  }

  return (totalCount > 0) ? (matchCount / totalCount) * 100 : 0;
}
