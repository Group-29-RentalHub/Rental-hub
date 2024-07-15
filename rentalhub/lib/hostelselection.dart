import 'package:flutter/material.dart';

class HostelSelectionForm extends StatefulWidget {
  final Function(String residentType, String hostelType, String location)
      onSubmit;

  const HostelSelectionForm({required this.onSubmit});

  @override
  _HostelSelectionFormState createState() => _HostelSelectionFormState();
}

class _HostelSelectionFormState extends State<HostelSelectionForm> {
  String _residentType = "";
  String _hostelType = "";
  String _location = "";
  String _drugRecord = "";
  String _budget = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Selection',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hostel Selection'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Resident Type:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: _residentType,
                  onChanged: (value) => setState(() => _residentType = value!),
                ),
                const Text('Male'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "Female",
                  groupValue: _residentType,
                  onChanged: (value) => setState(() => _residentType = value!),
                ),
                const Text('Female'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "Mixed",
                  groupValue: _residentType,
                  onChanged: (value) => setState(() => _residentType = value!),
                ),
                const Text('Mixed'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Hostel Type:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "Double (Self Contained)",
                  groupValue: _hostelType,
                  onChanged: (value) => setState(() => _hostelType = value!),
                ),
                const Text('Double (Self Contained)'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "Double (Not Self Contained)",
                  groupValue: _hostelType,
                  onChanged: (value) => setState(() => _hostelType = value!),
                ),
                const Text('Double (Not Self Contained)'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "Single (Self Contained)",
                  groupValue: _hostelType,
                  onChanged: (value) => setState(() => _hostelType = value!),
                ),
                const Text('Single (Self Contained)'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "Single (Not Self Contained)",
                  groupValue: _hostelType,
                  onChanged: (value) => setState(() => _hostelType = value!),
                ),
                const Text('Single (Not Self Contained)'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Location:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "Kikoni",
                  groupValue: _location,
                  onChanged: (value) => setState(() => _location = value!),
                ),
                const Text('Kikoni'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "Wandegeya",
                  groupValue: _location,
                  onChanged: (value) => setState(() => _location = value!),
                ),
                const Text('Wandegeya'),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Drug Record:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "Yes",
                  groupValue: _drugRecord,
                  onChanged: (value) => setState(() => _drugRecord = value!),
                ),
                const Text('Yes'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "No",
                  groupValue: _drugRecord,
                  onChanged: (value) => setState(() => _drugRecord = value!),
                ),
                const Text('No'),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Budget:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "UGX 300,000 - UGX 500,000",
                  groupValue: _budget,
                  onChanged: (value) => setState(() => _budget = value!),
                ),
                const Text('UGX 300,000 - UGX 500,000'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "UGX 550,000 - UGX 800,000",
                  groupValue: _budget,
                  onChanged: (value) => setState(() => _budget = value!),
                ),
                const Text('UGX 550,000 - UGX 800,000'),
                const SizedBox(width: 10.0),
                Radio<String>(
                  value: "UGX 850,000 - UGX 1,300,000",
                  groupValue: _budget,
                  onChanged: (value) => setState(() => _budget = value!),
                ),
                const Text('UGX 850,000 - UGX 1,300,000'),
              ],
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // Handle selection here
                print("Resident Type: $_residentType");
                print("Hostel Type: $_hostelType");
                print("Location: $_location");
              },
            ),
          ]),
        ),
      ),
    );
  }
}
