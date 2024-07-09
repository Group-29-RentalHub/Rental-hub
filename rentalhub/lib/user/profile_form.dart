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

  List<Widget> _buildSteps() {
    return [
      _buildStep(
        question: 'What type of house are you looking for?',
        child: TextField(
          decoration: InputDecoration(
            labelText: 'House Type',
          ),
        ),
        icon: Icons.home, // Using relevant icons
      ),
      _buildStep(
        question: 'What is your budget?',
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Budget',
          ),
        ),
        icon: Icons.attach_money, // Using relevant icons
      ),
      _buildStep(
        question: 'What is your preferred location?',
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Location',
          ),
        ),
        icon: Icons.location_on, // Using relevant icons
      ),
      // Add more steps as needed
    ];
  }

  Widget _buildStep({
    required String question,
    required Widget child,
    required IconData icon,
    //required String iconPath,
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
          // Image.asset(
          //   iconPath,
          //   height: 150.0,
          // ),
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
                          onPressed: () {
                            widget.onSubmit(); // Trigger callback to navigate to HomePage
                          },
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
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
