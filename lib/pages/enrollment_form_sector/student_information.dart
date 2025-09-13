import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class StudentInformation extends StatefulWidget {
  final double spacing;
  final Function(Map<String, dynamic>) onDataChanged;
  final Function(File?) onImageFileChanged;
  final Function(Uint8List?) onWebImageDataChanged;
  final Function(String?) onImageUrlChanged;

  StudentInformation({
    required this.spacing,
    required this.onDataChanged,
    required this.onImageFileChanged,
    required this.onWebImageDataChanged,
    required this.onImageUrlChanged,
    Key? key
  }) : super (key: key);

  @override
  State<StudentInformation> createState() => StudentInformationState();
}

class StudentInformationState extends State<StudentInformation>
    with AutomaticKeepAliveClientMixin {
  final _householdIdFocusNode = FocusNode();
  final _motherTongueFocusNode = FocusNode();
  final FocusNode _religionFocusNode = FocusNode();
  final FocusNode _schoolYearFocusNode = FocusNode();
  final FocusNode _placeOfBirthFocusNode = FocusNode();
  final FocusNode _psaFocusNode = FocusNode();
  final FocusNode _lrnFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _birthdateFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _indigenousFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  final FocusNode _middleNameFocusNode = FocusNode();
  final FocusNode _extensionNameFocusNode = FocusNode();

  final _householdIdController = TextEditingController();
  final _motherTongueController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _lrnController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _psaController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _extensionNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _indigenousController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  String _is4PsBeneficiary = '';



  // Method to reset form
  void resetFields() {
    setState(() {
    _householdIdController.clear();
    _motherTongueController.clear();
    _religionController.clear();
    _placeOfBirthController.clear();
    _psaController.clear();
    _schoolYearController.clear();
    _lrnController.clear();
    _lastNameController.clear();
    _firstNameController.clear();
    _middleNameController.clear();
    _extensionNameController.clear();
    _ageController.clear();
    _birthdateController.clear();
    _emailAddressController.clear();
    _indigenousController.clear();
    _genderController.clear();
    _phoneNumberController.clear();
    _gender = '';
    _is4PsBeneficiary = '';
    _indigenousGroup = '';
    
    // Reset image-related fields
    _imageFile = null;
    _webImageData = null;
    _imageUrl = null;
    });

  }

  String _gender = '';
  String _indigenousGroup = '';
  File? _imageFile;
  Uint8List? _webImageData;
  String? _imageUrl;
  String? _emailError;


  @override
  void initState() {
    super.initState();
    _householdIdController.addListener(_notifyParent);
    _motherTongueController.addListener(_notifyParent);
    _religionController.addListener(_notifyParent);
    _placeOfBirthController.addListener(_notifyParent);
    _psaController.addListener(_notifyParent);
    _schoolYearController.addListener(_notifyParent);
    _lrnController.addListener(_notifyParent);
    _lastNameController.addListener(_notifyParent);
    _firstNameController.addListener(_notifyParent);
    _middleNameController.addListener(_notifyParent);
    _extensionNameController.addListener(_notifyParent);
    _ageController.addListener(_notifyParent);
    _birthdateController.addListener(_notifyParent);
    _emailAddressController.addListener(_notifyParent);
    _indigenousController.addListener(_notifyParent);
    _genderController.addListener(_notifyParent);
    _phoneNumberController.addListener(_notifyParent);

    _householdIdFocusNode.addListener(_onFocusChange);
    _motherTongueFocusNode.addListener(_onFocusChange);
    _lrnFocusNode.addListener(_onFocusChange);
    _religionFocusNode.addListener(_onFocusChange);
    _psaFocusNode.addListener(_onFocusChange);
    _placeOfBirthFocusNode.addListener(_onFocusChange);
    _schoolYearFocusNode.addListener(_onFocusChange);
    _lastNameFocusNode.addListener(_onFocusChange);
    _firstNameFocusNode.addListener(_onFocusChange);
    _middleNameFocusNode.addListener(_onFocusChange);
    _extensionNameFocusNode.addListener(_onFocusChange);
    _ageFocusNode.addListener(_onFocusChange);
    _birthdateFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _indigenousFocusNode.addListener(_onFocusChange);
    _genderController.addListener(_onFocusChange);
    _phoneNumberFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _householdIdController.dispose();
    _householdIdFocusNode.dispose();
    _motherTongueController.dispose();
    _motherTongueFocusNode.dispose();
    _religionController.dispose();
    _religionFocusNode.dispose();
    _placeOfBirthController.dispose();
    _placeOfBirthFocusNode.dispose();
    _psaController.dispose();
    _psaFocusNode.dispose();
    _schoolYearController.dispose();
    _schoolYearFocusNode.dispose();
    _lrnController.dispose();
    _lrnFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _firstNameController.dispose();
    _middleNameFocusNode.dispose();
    _middleNameController.dispose();
    _extensionNameFocusNode.dispose();
    _extensionNameController.dispose();
    _ageFocusNode.dispose();
    _ageController.dispose();
    _birthdateFocusNode.dispose();
    _birthdateController.dispose();
    _emailFocusNode.dispose();
    _emailAddressController.dispose();
    _indigenousFocusNode.dispose();
    _indigenousController.dispose();
    _genderFocusNode.dispose();
    _genderController.dispose();
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _onFocusChange() {
    setState(() {});
  }

  void _notifyParent() {
    widget.onDataChanged(getFormData());
  }
  

  Map<String, dynamic> getFormData() {
  return {
    'school_year': _schoolYearController.text,
    'lrn': _lrnController.text,
    'psa': _psaController.text,
    'last_name': _lastNameController.text,
    'first_name': _firstNameController.text,
    'middle_name': _middleNameController.text,
    'extension_name': _extensionNameController.text,
    'age': _ageController.text,
    'birthdate': _birthdateController.text,
    'gender': _gender,
    'place_of_birth': _placeOfBirthController.text,
    'indigenous_group': _indigenousGroup,
    'email_Address': _emailAddressController.text,
    'religion': _religionController.text,
    'phone_number': _phoneNumberController.text,
    'mother_tongue': _motherTongueController.text,
    'is_4ps_beneficiary': _is4PsBeneficiary,
    if (_is4PsBeneficiary == 'Yes')
      '4ps_household_id': _householdIdController.text,
  };
}


    Future<void> _pickImage() async {
    if (kIsWeb) {
      final uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();
      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((e) {
          final imageData = reader.result as Uint8List;
          setState(() {
            _webImageData = imageData;
            widget.onWebImageDataChanged(imageData);
          });
        });
      });
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
           _imageFile = File(pickedFile.path);
          widget.onImageFileChanged(File(pickedFile.path));
        });
      }
    }
  }


    Future<void> _uploadImage() async {
    if (_imageFile == null && _webImageData == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('student_pictures/${DateTime.now().toIso8601String()}.png');

    try {
      if (kIsWeb) {
        await imageRef.putData(_webImageData!);
      } else {
        await imageRef.putFile(_imageFile!);
      }

      final imageUrl = await imageRef.getDownloadURL();
      widget.onImageUrlChanged(imageUrl); 

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(
          children: [
            Image.asset('assets/LOGOFORSALOMAGUE.png', scale: 40),
                      SizedBox(width: 10),
            Text('Image Uploaded Successfully'),
          ],
        )),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(
          children: [
            Image.asset('assets/LOGOFORSALOMAGUE.png', scale: 40),
                      SizedBox(width: 10),
            Text('Failed to Upload Image: $e'),
          ],
        )),
      );
    }
  }

    Future<bool> checkIfEmailExists() async {
  // Use the value of the controller, not the controller object itself
  final String email = _emailAddressController.text;

  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users') // Replace 'users' with your actual collection name
      .where('email_Address', isEqualTo: email) // Query based on the email field value
      .get();

  return snapshot.docs.isNotEmpty; // Return true if the email exists
}


    @override
    Widget build(BuildContext context) {
      super.build(context);
          // Determine the screen width and breakpoints
  double screenWidth = MediaQuery.of(context).size.width;

  // Define width for text fields based on screen size
  double fieldWidth;
  if (screenWidth >= 1200) {
    // Large screens (Web/Desktop)
    fieldWidth = 300;
  } else if (screenWidth >= 800) {
    // Medium screens (Tablet)
    fieldWidth = 250;
  } else {
    // Small screens (Mobile)
    fieldWidth = screenWidth * 0.8; // Adjust to take most of the screen width
  }

  // Define spacing between fields
  double spacing = screenWidth >= 800 ? 16.0 : 8.0;
  bool isMobile = screenWidth < 800;

      return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Student Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile
            ? Column(
                children: [
                  // Upload 2x2 picture on top for mobile
                 Hero(
                  tag: isMobile ? 'profile_picture_mobile' : 'profile_picture_desktop',
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF03b97c), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: _imageFile == null && _webImageData == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.profile_circle_copy,
                                    color: Color.fromARGB(255, 101, 100, 100),
                                    size: 50.0,
                                  ),
                                  Text(
                                    'Upload your 2x2 picture',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 101, 100, 100),
                                      fontSize: 8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : (_webImageData != null
                              ? Image.memory(
                                  _webImageData!,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ),
                ),

                  SizedBox(height: 16.0), // Spacing between fields
                  // LRN field below for mobile
                  Container(
                    width: screenWidth * 0.8, // Adjust width for mobile
                    child: TextFormField(
                      controller: _lrnController,
                      focusNode: _lrnFocusNode,
                      decoration: InputDecoration(
                        labelText: null,
                        label: RichText(
                          text: TextSpan(
                            text: 'Learner Reference Number',
                            style: TextStyle(
                              color: Color.fromARGB(255, 101, 100, 100),
                              fontSize: 16,
                            ),
                            children: [
                              if (_lrnFocusNode.hasFocus || _lrnController.text.isNotEmpty)
                                TextSpan(
                                  text: '(if applicable)',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 101, 100, 100), 
                                  ),
                                ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty && value.length != 12) {
                          return 'LRN must be exactly 12 digits';
                        }
                        return null;
                      },

                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),

          // NEW: School Year Field (Mobile)
          Container(
  width: screenWidth * 0.8,
  child: TextFormField(
    controller: _schoolYearController,
    focusNode: _schoolYearFocusNode,
    keyboardType: TextInputType.number, 
    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
    decoration: InputDecoration(
      label: RichText(
        text: TextSpan(
          text: 'School Year',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 100, 100),
            fontSize: 16,
          ),
          children: [
            if (_schoolYearFocusNode.hasFocus || _schoolYearController.text.isNotEmpty)
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter school year';
      }
      return null;
    },
    onChanged: (text) {
      setState(() {});
    },
  ),
),

        ],
      )
              
            : Row(
                children: [
                  // LRN field
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _lrnController,
                      focusNode: _lrnFocusNode,
                      decoration: InputDecoration(
                        labelText: null,
                        label: RichText(
                          text: TextSpan(
                            text: 'Learner Reference Number',
                            style: TextStyle(
                              color: Color.fromARGB(255, 101, 100, 100),
                              fontSize: 16,
                            ),
                            children: [
                              if (_lrnFocusNode.hasFocus || _lrnController.text.isNotEmpty)
                                TextSpan(
                                  text: '(if applicable)',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 101, 100, 100), 
                                  ),
                                ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty && value.length != 12) {
                          return 'LRN must be exactly 12 digits';
                        }
                        return null;
                      },

                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                      ],
                    ),
                  ),
                   SizedBox(width: spacing),

          // NEW: School Year Field (Desktop)
          Container(
            width: 200,
            child: TextFormField(
              controller: _schoolYearController,
              focusNode: _schoolYearFocusNode,
              keyboardType: TextInputType.number, 
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'S.Y: yyyy - yyyy',
                    style: TextStyle(
                      color: Color.fromARGB(255, 101, 100, 100),
                      fontSize: 16,
                    ),
                    children: [
                      if (_schoolYearFocusNode.hasFocus || _schoolYearController.text.isNotEmpty)
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter school year';
                }
                return null;
              },
              onChanged: (text) {
                setState(() {});
              },
            ),
          ),

          SizedBox(width: widget.spacing),
                  // Upload 2x2 picture
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF03b97c), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: _imageFile == null && _webImageData == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.profile_circle_copy,
                                    color: Color.fromARGB(255, 101, 100, 100),
                                    size: 50.0,
                                  ),
                                  Text(
                                    'Upload your 2x2 picture',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 101, 100, 100),
                                      fontSize: 8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : (_webImageData != null
                              ? Image.memory(
                                  _webImageData!,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ),
                ],
              ),
      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                Container(
      width: fieldWidth,
      child: TextFormField(
        controller: _psaController,
        focusNode: _psaFocusNode,
        keyboardType: TextInputType.number, 
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
        decoration: InputDecoration(
          labelText: null,
          label: RichText(
            text: TextSpan(
              text: 'PSA Birth Certificate No.',
              style: TextStyle(
                color: Color.fromARGB(255, 101, 100, 100),
                fontSize: 16,
              ),
              children: [
                if (_psaFocusNode.hasFocus || _psaController.text.isNotEmpty)
                  TextSpan(
                    text: '(if available upon registration)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 101, 100, 100),
                    ),
                  ),
              ],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your PSA Birth Certificate No.';
          }
          return null;
        },
        onChanged: (text) {
          setState(() {});
        },
      ),
    ),
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _lastNameController,
                    focusNode: _lastNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Last Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_lastNameFocusNode.hasFocus || _lastNameController.text.isNotEmpty)
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red, // Red color for the asterisk
                            ),
                            ),
                        ],
                      ),
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]')),TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText);
                    }),
                    ],
                  ),
                ),
                // SizedBox(width: widget.spacing),
                Container(
                width: fieldWidth,
                child: TextFormField(
                  controller: _firstNameController,
                  focusNode: _firstNameFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: null,
                    label: RichText(
                      text: TextSpan(
                        text: 'First Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_firstNameFocusNode.hasFocus || _firstNameController.text.isNotEmpty)
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Red color for the asterisk
                              ),
                            ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allow letters and spaces
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText);
                    }),
                  ],
                ),
              ),

                // SizedBox(width: widget.spacing),
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _middleNameController,
                    focusNode: _middleNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Middle Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_middleNameFocusNode.hasFocus || _middleNameController.text.isNotEmpty)
                          TextSpan(
                            text: '(optional)',
                            style: TextStyle(
                              color: Color.fromARGB(255, 101, 100, 100), // Red color for the asterisk
                            ),
                            ),
                        ],
                      ),
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]')),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText);
                    }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _extensionNameController,
                    focusNode: _extensionNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Extension Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_extensionNameFocusNode.hasFocus || _extensionNameController.text.isNotEmpty)
                          TextSpan(
                            text: '(optional)',
                            style: TextStyle(
                              color: Color.fromARGB(255, 101, 100, 100),
                            ),
                            ),
                        ],
                      ),
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
                // SizedBox(width: widget.spacing),
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _ageController,
                    focusNode: _ageFocusNode,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Age',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_ageFocusNode.hasFocus || _ageController.text.isNotEmpty)
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,                             ),
                            ),
                        ],
                      ),
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                // SizedBox(width: widget.spacing),
                Container(
                  width: fieldWidth,
                  child: DropdownButtonFormField<String>(
                    value: _gender.isEmpty ? null : _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                        _notifyParent();
                      });
                    },
                    items: ['Male', 'Female', 'Other'].map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 101, 100, 100)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                  ),
                ),
                Container(
  width: fieldWidth,
  child: TextFormField(
    controller: _placeOfBirthController,
    focusNode: _placeOfBirthFocusNode,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: null,
      label: RichText(
        text: TextSpan(
          text: 'Place of Birth',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 100, 100),
            fontSize: 16,
          ),
          children: [
            if (_placeOfBirthFocusNode.hasFocus || _placeOfBirthController.text.isNotEmpty)
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your place of birth';
      }
      return null;
    },
    onChanged: (text) {
      setState(() {});
    },
    keyboardType: TextInputType.text,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.split(' ').map((word) {
          if (word.isNotEmpty) {
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          }
          return '';
        }).join(' ');
        return newValue.copyWith(text: newText);
      }),
    ],
  ),
),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
                spacing: spacing,
                runSpacing: spacing,
              children: [
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _birthdateController,
                    focusNode: _birthdateFocusNode,
                    decoration: InputDecoration(
                      hintText: 'MM/DD/YYYY', // Hint text
                      label: RichText(
                        text: TextSpan(
                          text: 'Birthdate',
                          style: TextStyle(
                            color: Color.fromARGB(255, 101, 100, 100),
                            fontSize: 16,
                          ),
                          children: [
                            if (_birthdateFocusNode.hasFocus || _birthdateController.text.isNotEmpty)
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red, // Red color for the asterisk
                                ),
                              ),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Iconsax.calendar_1_copy),
                        onPressed: () async {
                          // Trigger the date picker when the calendar icon is pressed
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (selectedDate != null) {
                            String formattedDate = DateFormat('MM/dd/yyyy').format(selectedDate);
                            _birthdateController.text = formattedDate; // Set the selected date in the text field
                          }
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your birthdate';
                      }
                      return null;
                    },
                    readOnly: true, // Makes the TextFormField non-editable
                    onTap: () async {
                      // Optionally trigger the date picker on tap as well
                      FocusScope.of(context).requestFocus(FocusNode()); // Prevents keyboard from showing up
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (selectedDate != null) {
                        String formattedDate = DateFormat('MM/dd/yyyy').format(selectedDate);
                        _birthdateController.text = formattedDate; // Set the selected date in the text field
                      }
                    },
                  ),
                ),

                // SizedBox(width: widget.spacing),
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _emailAddressController,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Email Address',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_emailFocusNode.hasFocus || _emailAddressController.text.isNotEmpty)
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,                             ),
                            ),
                        ],
                      ),
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email Address';
                    }

                    // If _emailError has an error, return that
                    if (_emailError != null) {
                      return _emailError;
                    }

                    return null;
                  },

                  onChanged: (value) async {
                    if (value.isEmpty) {
                      setState(() {
                        _emailError = 'Please enter your Email Address';
                      });
                      return;
                    }

                    // Perform async check
                    bool emailExists = await checkIfEmailExists();

                    setState(() {
                      if (emailExists) {
                        _emailError = 'This email is already registered.';
                      } else {
                        _emailError = null; // Clear error
                      }
                    });
                  },
                  )
                ),
                Container(
  width: fieldWidth,
  child: TextFormField(
    controller: _religionController,
    focusNode: _religionFocusNode,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: null,
      label: RichText(
        text: TextSpan(
          text: 'Religion',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 100, 100),
            fontSize: 16,
          ),
          children: [
            if (_religionFocusNode.hasFocus || _religionController.text.isNotEmpty)
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your religion';
      }
      return null;
    },
    onChanged: (text) {
      setState(() {});
    },
    keyboardType: TextInputType.text,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
    ],
  ),
),

                // SizedBox(width: widget.spacing),
                Container(
                  width: fieldWidth,
                  child: DropdownButtonFormField<String>(
                    value: _indigenousGroup.isEmpty ? null : _indigenousGroup,
                    onChanged: (value) {
                      setState(() {
                        _indigenousGroup = value!;
                        _notifyParent();
                      });
                    },
                    items: ['Yes', 'No'].map((group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text(group),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Belonging to any Indigenous People (IP) Group?',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 101, 100, 100)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _phoneNumberController,
                    focusNode: _phoneNumberFocusNode,
                    decoration: InputDecoration(
                      hintText: '09********',
                      labelText: null,
                      label: RichText(
                        text: TextSpan(
                          text: 'Phone Number',
                          style: TextStyle(
                            color: Color.fromARGB(255, 101, 100, 100),
                            fontSize: 16,
                          ),
                          children: [
                            if (_phoneNumberFocusNode.hasFocus || _phoneNumberController.text.isNotEmpty)
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // Ensure the number starts with '09' and has exactly 11 digits
                      if (!RegExp(r'^(09\d{9})$').hasMatch(value)) {
                        return 'Enter a valid phone number starting with 09 (e.g., 09xxxxxxxxx)';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, 
                    LengthLimitingTextInputFormatter(11), ],
                  ),
                ),
                // SizedBox(width: widget.spacing),
                Container(
  width: fieldWidth,
  child: TextFormField(
    controller: _motherTongueController,
    focusNode: _motherTongueFocusNode,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: null,
      label: RichText(
        text: TextSpan(
          text: 'Mother Tongue',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 100, 100),
            fontSize: 16,
          ),
          children: [
            if (_motherTongueFocusNode.hasFocus || _motherTongueController.text.isNotEmpty)
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your mother tongue';
      }
      return null;
    },
    onChanged: (text) {
      setState(() {});
    },
    keyboardType: TextInputType.text,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
    ],
  ),
),
// 4Ps Beneficiary Dropdown
Container(
  width: fieldWidth,
  child: DropdownButtonFormField<String>(
    value: _is4PsBeneficiary.isEmpty ? null : _is4PsBeneficiary,
    decoration: InputDecoration(
      labelText: null,
      label: RichText(
        text: TextSpan(
          text: 'Is your family a beneficiary of 4Ps?',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 100, 100),
            fontSize: 16,
          ),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
      ),
    ),
    items: ['Yes', 'No'].map((value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        _is4PsBeneficiary = value!;
        if (_is4PsBeneficiary == 'No') {
          _householdIdController.clear();
        }
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select Yes or No';
      }
      return null;
    },
  ),
),

// Conditional Household ID field if Yes is selected
if (_is4PsBeneficiary == 'Yes')
  Container(
    width: fieldWidth,
    child: TextFormField(
      controller: _householdIdController,
      focusNode: _householdIdFocusNode,
      decoration: InputDecoration(
        labelText: null,
        label: RichText(
          text: TextSpan(
            text: 'If Yes, please write the 4Ps Household ID Number',
            style: TextStyle(
              color: Color.fromARGB(255, 101, 100, 100),
              fontSize: 16,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color(0xFF03b97c), width: 1.0),
        ),
      ),
      validator: (value) {
        if (_is4PsBeneficiary == 'Yes' && (value == null || value.isEmpty)) {
          return 'Please enter the 4Ps Household ID Number';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    ),
  ),

              ],
            ),
          ),
        ]
      );
    }
  }