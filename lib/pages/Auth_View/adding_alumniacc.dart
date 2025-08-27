import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddALumniAccountDialog extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback closeAddAlumni;

  AddALumniAccountDialog({
    super.key,
    required this.closeAddAlumni,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  _AddALumniAccountDialogState createState() => _AddALumniAccountDialogState();
}

class _AddALumniAccountDialogState extends State<AddALumniAccountDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _yearGraduatedController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedTrack = '';
  String _selectedStrand = '';
  String? _emailError;
  bool _isPasswordVisible = false; // Add this new state variable

  List<DropdownMenuItem<String>> _getStrandItems() {
    if (_selectedTrack == 'Academic Track') {
      return [
        'Humanities and Social Sciences (HUMSS)',
      ]
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();
    } else if (_selectedTrack == 'Technical-Vocational-Livelihood (TVL)') {
      return [
        'Food and Beverages Services (FBS)',
        'Cosmetology',
        'Drafting',
        'Information and Communication Technology (ICT)',
      ]
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();
    }
    return [];
  }

  Future<String?> _emailValidator(String? value) async {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    // Convert entered email to lowercase to perform case-insensitive comparison
    String enteredEmail = value.trim().toLowerCase();

    // Call the function that checks if the email already exists (case-insensitive check)
    bool isInUse = await _isEmailInUse(enteredEmail);

    if (isInUse) {
      return 'Email is already in use';
    }

    return null;
  }

  Future<bool> _isEmailInUse(String email) async {
    try {
      // Query all users in Firestore
      final snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      // Convert entered email to lowercase for case-insensitive comparison
      String emailLowerCase = email.toLowerCase();

      // Loop through the documents to compare case-insensitive email
      for (var doc in snapshot.docs) {
        String storedEmail = (doc['email_Address'] as String)
            .toLowerCase(); // Convert stored email to lowercase

        // Check if the stored email matches the entered email
        if (storedEmail == emailLowerCase) {
          return true; // Email found, it's already in use
        }
      }

      return false; // Email not found
    } catch (e) {
      // Handle error if query fails
      print("Error checking email: $e");
      return false; // Default to email not found
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

        final firstName = _firstNameController.text;
        final middleName = _middleNameController.text;
        final lastName = _lastNameController.text;
        final adress = _addressController.text;
        final yearGraduated = _yearGraduatedController.text;
        final email = _emailController.text;
        final password = _passwordController.text;

        // Get the current Firebase options
        final options = Firebase.app().options;
        final tempAppName = 'tempApp-${DateTime.now().millisecondsSinceEpoch}';
        final tempApp = await Firebase.initializeApp(
          name: tempAppName,
          options: FirebaseOptions(
            apiKey: options.apiKey,
            appId: options.appId,
            messagingSenderId: options.messagingSenderId,
            projectId: options.projectId,
            authDomain: options.authDomain,
            storageBucket: options.storageBucket,
          ),
        );

        try {
          final tempAuth = FirebaseAuth.instanceFor(app: tempApp);
          final userCredential = await tempAuth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

          final uid = userCredential.user?.uid;
          if (uid == null) {
            throw Exception('Failed to create user: No UID generated');
          }

          Map<String, dynamic> userData = {
            'first_name': firstName,
            'middle_name': middleName,
            'last_name': lastName,
            'adress': adress,
            'email_Address': email,
            'accountType': 'alumni',
            'Status': 'active',
            'Track': _selectedTrack,
            'Strand': _selectedStrand,
            'yearGraduated': yearGraduated,
            'uid': uid,
            //track and strand
          };

          // Save the user data to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .set(userData);

          await tempAuth.signOut();

          // Close loading indicator
          Navigator.pop(context);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
              children: [
                Image.asset('balungaonhs.png', scale: 40),
                SizedBox(width: 10),
                Text('Instructor account added successfully!'),
              ],
            )),
          );

          // Close the add instructor dialog
          if (mounted) {
            widget.closeAddAlumni();
          }
        } finally {
          await tempApp.delete();
        }
      } catch (e) {
        // Close loading indicator
        Navigator.pop(context);

        print('Error adding instructor: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
            children: [
              Image.asset('balungaonhs.png', scale: 40),
              SizedBox(width: 10),
              Text('Failed to create instructor account: ${e.toString()}'),
            ],
          )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.closeAddAlumni,
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: widget.screenWidth / 2,
                height: widget.screenHeight / 1.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: widget.closeAddAlumni,
                          style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                          ),
                          child:
                              Text('Back', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Add Alumni Account',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField(
                                _firstNameController,
                                'First Name',
                                'Please enter a first name',
                                TextInputType.name,
                                false, [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]'))
                            ] // Allow only letters and spaces
                                ),
                            _buildTextField(
                              _middleNameController,
                              'Middle Name',
                              'Please enter a middle name',
                              TextInputType.name,
                              false,
                              [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[a-zA-Z\s]"))
                              ],
                            ),
                            _buildTextField(
                              _lastNameController,
                              'Last Name',
                              'Please enter a last name',
                              TextInputType.name,
                              false,
                              [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[a-zA-Z\s]"))
                              ],
                            ),
                            // For subject name field
                            _buildTextField(
                              _addressController, 'Address',
                              'Please enter an address',
                              TextInputType.streetAddress,
                              false,
                              [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[a-zA-Z0-9\s.,\-#]"))
                              ], // Letters, numbers, common symbols
                            ),
                            _buildTextField(
                              _yearGraduatedController,
                              'Year Graduated',
                              'Please enter a year graduated',
                              TextInputType.number,
                              false,
                              [
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            DropdownButtonFormField<String>(
                              value: _selectedTrack.isEmpty
                                  ? null
                                  : _selectedTrack,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: 'Select a Track',
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 101, 100, 100)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                               
                              ),
                              items: [
                                'Academic Track',
                                'Technical-Vocational-Livelihood (TVL)'
                              ]
                                  .map((String value) =>
                                      DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTrack = value!;
                                  _selectedStrand = '';
                                });
                              },
                            ),

                      SizedBox(height: 8),

// Conditionally show Strand Dropdown
                            if (_selectedTrack.isNotEmpty)
                              DropdownButtonFormField<String>(
                                value: _selectedStrand.isEmpty
                                    ? null
                                    : _selectedStrand,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Select a Strand',
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 101, 100, 100)),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                               
                                ),
                                items: _getStrandItems(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStrand = value!;
                                  });
                                },
                              ),
                                                    SizedBox(height: 8),

                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(),
                                errorText:
                                    _emailError, // Display error message here
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                setState(() {
                                  _emailError =
                                      null; // Clear error message on input change
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                }
                                // Synchronous check for email validation
                                bool isInUse = false;
                                _isEmailInUse(value).then((result) {
                                  isInUse = result;
                                  if (isInUse) {
                                    setState(() {
                                      _emailError =
                                          'Email is already in use'; // Set error state
                                    });
                                  }
                                });
                                if (isInUse) {
                                  return 'Email is already in use';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 8),

                            _buildTextField(
                                _passwordController,
                                'Password',
                                'Please enter a password',
                                TextInputType.visiblePassword,
                                true),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: widget.screenWidth,
                        height: widget.screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 5,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Save Changes',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    String errorMessage, [
    TextInputType? keyboardType,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters, // Add this line
  ]) {
    if (labelText == 'Password') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            // Add suffix icon inside the password field
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          keyboardType: keyboardType,
          obscureText: !_isPasswordVisible, // Toggle visibility based on state
          validator: (value) => value?.isEmpty ?? true ? errorMessage : null,
        ),
      );
    }
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters, // Apply formatters here

          validator: (value) => value?.isEmpty ?? true ? errorMessage : null,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
