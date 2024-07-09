import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileFormPage extends StatefulWidget {
  final VoidCallback onSubmit;

  ProfileFormPage({required this.onSubmit});

  @override
  _ProfileFormPageState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  String? _selectedBudget;
  String? _selectedHouseType;
  LatLng? _selectedLocation;

  List<Widget> _buildSteps() {
    return [
      _buildStep(
        question: 'Select your preferred location on the map',
        child: _buildMap(),
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
    ];
  }

  Widget _buildMap() {
    return Container(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0.3476, 32.5825), // Centered on Kampala, Uganda
          zoom: 12,
        ),
        onTap: (LatLng position) {
          setState(() {
            _selectedLocation = position;
          });
        },
        markers: _selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('selectedLocation'),
                  position: _selectedLocation!,
                )
              }
            : {},
      ),
    );
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
            (budget) => RadioListTile<String>(
              title: Text(budget),
              value: budget,
              groupValue: _selectedBudget,
              onChanged: (value) {
                setState(() {
                  _selectedBudget = value;
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
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
            (houseType) => RadioListTile<String>(
              title: Text(houseType),
              value: houseType,
              groupValue: _selectedHouseType,
              onChanged: (value) {
                setState(() {
                  _selectedHouseType = value;
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildStep({
    required String question,
    required Widget child,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100.0,
            color: Color.fromRGBO(70, 0, 119, 1), // Theme color
          ),
          SizedBox(height: 16.0),
          Text(
            question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Form', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
      ),
      body: Container(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentPage + 1) / 3, // Adjust according to the number of steps
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
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
                  _currentPage > 0
                      ? ElevatedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text('Previous', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
                          ),
                        )
                      : Container(),
                  _currentPage < 2
                      ? ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text('Next', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
                          ),
                        )
                      : ElevatedButton(
                          onPressed: widget.onSubmit,
                          child: Text('Submit', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Step ${_currentPage + 1} of 3', // Adjust according to the number of steps
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
