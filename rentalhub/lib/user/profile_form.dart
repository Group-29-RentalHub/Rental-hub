import 'package:flutter/material.dart';

class ProfileFormPage extends StatefulWidget {
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
      ),
      _buildStep(
        question: 'What is your budget?',
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Budget',
          ),
        ),
      ),
      _buildStep(
        question: 'What is your preferred location?',
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Location',
          ),
        ),
      ),
      // Add more steps as needed
    ];
  }

  Widget _buildStep({required String question, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
        title: Text('Profile Form'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentPage + 1) / 3, // Adjust according to the number of steps
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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
                        child: Text('Previous'),
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
                        child: Text('Next'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          // Implement submit functionality
                        },
                        child: Text('Submit'),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Step ${_currentPage + 1} of 3'), // Adjust according to the number of steps
          ),
        ],
      ),
    );
  }
}
