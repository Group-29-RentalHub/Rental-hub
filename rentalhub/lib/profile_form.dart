import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileFormPage extends StatefulWidget {
  final VoidCallback onSubmit;

  const ProfileFormPage({super.key, required this.onSubmit});

  @override
  _ProfileFormPageState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String? _selectedBudget;
  String? _selectedHouseType;
  String? _selectedHostelType;
  String? _selectedNationality;
  String? _name;
  String? _yearOfStudy;
  bool _wifi = false;
  bool _laundryServices = false;
  bool _cafeteria = false;
  bool _parking = false;
  bool _security = false;

  LatLng _selectedLocation = LatLng(0.3152, 32.5816);

  bool _isSubmitting = false;
  String? _errorMessage;

  // Method to save data to Firestore
  Future<void> _saveToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        setState(() {
          _isSubmitting = true;
          _errorMessage = null;
        });

        await FirebaseFirestore.instance.collection('user_hostel_prefs').add({
          'location':
              GeoPoint(_selectedLocation.latitude, _selectedLocation.longitude),
          'budget': _selectedBudget,
          'house_type': _selectedHouseType,
          'hostel_type': _selectedHostelType,
          'nationality': _selectedNationality,
          'name': _name,
          'year_of_study': _yearOfStudy,
          'wifi': _wifi,
          'laundry_services': _laundryServices,
          'cafeteria': _cafeteria,
          'parking': _parking,
          'security': _security,
          'user_id': user.uid, // Added user ID
        });

        // Optionally show a success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile submitted successfully!')),
        );
      } catch (e) {
        // Handle errors and show an error message
        setState(() {
          _errorMessage = 'Failed to submit profile. Please try again.';
        });
        print('Error saving profile: $e');
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'User not logged in.';
      });
    }
  }

  void _handleSubmit() async {
    await _saveToFirestore();
    widget.onSubmit();
  }

  List<Widget> _buildSteps() {
    return [
      _buildStep(
        question: 'Select your preferred location on the map',
        child: Container(
          height: 300,
          color: Colors.grey[300],
          child: FlutterMap(
            options: MapOptions(
              initialCenter: _selectedLocation,
              initialZoom: 13.0,
              minZoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: _selectedLocation,
                      child: const Icon(Icons.pin_drop)),
                ],
              ),
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: _selectedLocation,
                    color: Colors.blue.withOpacity(0.3),
                    borderStrokeWidth: 2.0,
                    borderColor: Colors.blue,
                    radius: 500, // Radius in meters (2 km)
                  ),
                ],
              )
            ],
          ),
        ),
        icon: Icons.location_on,
      ),
      _buildStep(
        question: 'Choose your budget range',
        child: _buildBudgetOptions(),
        icon: Icons.attach_money,
      ),
      _buildStep(
        question: 'Choose the type of house',
        child: _buildHouseTypeOptions(),
        icon: Icons.home,
      ),
      _buildStep(
        question: 'Choose the type of hostel',
        child: _buildHostelTypeOptions(),
        icon: Icons.hotel,
      ),
      _buildStep(
        question: 'Select your nationality',
        child: _buildNationalityDropdown(),
        icon: Icons.flag,
      ),
      _buildStep(
        question: 'Enter your name',
        child: _buildNameInput(),
        icon: Icons.person,
      ),
      _buildStep(
        question: 'Enter your year of study',
        child: _buildYearOfStudyInput(),
        icon: Icons.school,
      ),
      _buildStep(
        question: 'Select amenities',
        child: SingleChildScrollView(
          child: _buildAmenitiesCheckboxes(),
        ),
        icon: Icons.check,
      ),
    ];
  }

  Widget _buildBudgetOptions() {
    List<String> budgets = [
      '300,000 - 600,000 UGX',
      '650,000 - 850,000 UGX',
      '850,000 - 1,200,000 UGX',
      '1,300,000 - 1,500,000 UGX',
    ];
    return Column(
      children: budgets
          .map(
            (budget) => _buildCustomRadioButton(
              label: budget,
              value: budget,
              groupValue: _selectedBudget,
              onChanged: (value) {
                setState(() {
                  _selectedBudget = value;
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildHouseTypeOptions() {
    List<String> houseTypes = [
      'Double Self-Contained',
      'Double Non-Self-Contained',
      'Single Self-Contained',
      'Single Non-Self-Contained',
    ];
    return Column(
      children: houseTypes
          .map(
            (houseType) => _buildCustomRadioButton(
              label: houseType,
              value: houseType,
              groupValue: _selectedHouseType,
              onChanged: (value) {
                setState(() {
                  _selectedHouseType = value;
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildHostelTypeOptions() {
    List<String> hostelTypes = [
      'Mixed',
      'Boys',
      'Girls',
    ];
    return Column(
      children: hostelTypes
          .map(
            (type) => _buildCustomRadioButton(
              label: type,
              value: type,
              groupValue: _selectedHostelType,
              onChanged: (value) {
                setState(() {
                  _selectedHostelType = value;
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildNationalityDropdown() {
    List<String> nationalities = [
      'Ugandan',
      'Kenyan',
      'Tanzanian',
      'Others',
    ];
    return DropdownButtonFormField<String>(
      value: _selectedNationality,
      items: nationalities.map((nationality) {
        return DropdownMenuItem<String>(
          value: nationality,
          child: Text(nationality),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedNationality = value;
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Enter your name',
      ),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _buildYearOfStudyInput() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Enter your year of study',
      ),
      onChanged: (value) {
        setState(() {
          _yearOfStudy = value;
        });
      },
    );
  }

  Widget _buildAmenitiesCheckboxes() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Wifi'),
          value: _wifi,
          onChanged: (value) {
            setState(() {
              _wifi = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Laundry services'),
          value: _laundryServices,
          onChanged: (value) {
            setState(() {
              _laundryServices = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Cafeteria'),
          value: _cafeteria,
          onChanged: (value) {
            setState(() {
              _cafeteria = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Parking'),
          value: _parking,
          onChanged: (value) {
            setState(() {
              _parking = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Security'),
          value: _security,
          onChanged: (value) {
            setState(() {
              _security = value ?? false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCustomRadioButton({
    required String label,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromRGBO(70, 0, 119, 1) : Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color.fromRGBO(70, 0, 119, 1) : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String question,
    required Widget child,
    required IconData icon,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: const Color.fromRGBO(70, 0, 119, 1),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        child,
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: _buildSteps(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    ElevatedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _isSubmitting
                        ? null
                        : _currentPage < 7
                            ? () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                    ),
                    child: Text(
                      _currentPage < 7 ? 'Next' : 'Submit',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
