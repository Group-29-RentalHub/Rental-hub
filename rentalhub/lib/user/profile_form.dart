import 'package:flutter/material.dart';

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
  String? _selectedHostelType;
  String? _selectedNationality;
  bool _allowDrugs = false;
  bool _allowVisitors = false;

  List<Widget> _buildSteps() {
    return [
      _buildStep(
        question: 'Select your preferred location on the map',
        child: Container(
          height: 300,
          color: Colors.grey[300],
          child: Center(
            child: Text(
              'Map Placeholder',
              style: TextStyle(color: Colors.black45, fontSize: 20.0),
            ),
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
        question: 'Allow drugs and visitors to sleep over',
        child: _buildAllowanceCheckboxes(),
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
            (houseType) => _buildCustomRadioButton(
              label: houseType,
              value: houseType,
              groupValue: _selectedHouseType,
              onChanged: (value) {
                setState(() {
                  _selectedHouseType = value;
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
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter your name',
      ),
      onChanged: (value) {
        // Handle name input
      },
    );
  }

  Widget _buildYearOfStudyInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter your year of study',
      ),
      onChanged: (value) {
        // Handle year of study input
      },
    );
  }

  Widget _buildAllowanceCheckboxes() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Allow drugs'),
          value: _allowDrugs,
          onChanged: (value) {
            setState(() {
              _allowDrugs = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text('Allow visitors to sleep over'),
          value: _allowVisitors,
          onChanged: (value) {
            setState(() {
              _allowVisitors = value ?? false;
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
    required void Function(String?) onChanged,
  }) {
    bool isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(70, 0, 119, 1) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color.fromRGBO(70, 0, 119, 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.white : Color.fromRGBO(70, 0, 119, 1),
            ),
            SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Color.fromRGBO(70, 0, 119, 1),
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
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
              value: (_currentPage + 1) / 8, // Adjust according to the number of steps
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
                  _currentPage < 7
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
          ],
        ),
      ),
    );
  }
}
