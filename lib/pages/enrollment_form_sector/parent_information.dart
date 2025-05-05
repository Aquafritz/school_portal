import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParentInformation extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final double spacing;

  ParentInformation({required this.spacing, required this.onDataChanged, Key? key}) : super(key: key);

  @override
  State<ParentInformation> createState() => ParentInformationState();
}

class ParentInformationState extends State<ParentInformation> with AutomaticKeepAliveClientMixin{
  
  final FocusNode _fathersFirstNameFocusNode = FocusNode();
  final FocusNode _fathersLastNameFocusNode = FocusNode();
  final FocusNode _fathersMiddleNameFocusNode = FocusNode();
  final FocusNode _fathersContactNumberFocusNode = FocusNode(); 
  final FocusNode _mothersFirstNameFocusNode = FocusNode();
  final FocusNode _mothersLastNameFocusNode = FocusNode();
  final FocusNode _mothersMiddleNameFocusNode = FocusNode();
  final FocusNode _mothersContactNumberFocusNode = FocusNode();
  final FocusNode _guardianLastNameFocusNode = FocusNode();
  final FocusNode _guardianFirstNameFocusNode = FocusNode();
  final FocusNode _guardianMiddleNameFocusNode = FocusNode();
  final FocusNode _guardianContactNumberFocusNode = FocusNode();

  final TextEditingController _fathersLastName = TextEditingController();
  final TextEditingController _fathersFirstName = TextEditingController();
  final TextEditingController _fathersMiddleName = TextEditingController();
  final TextEditingController _fathersContactNumber = TextEditingController();
  final TextEditingController _mothersLastName = TextEditingController();
  final TextEditingController _mothersFirstName = TextEditingController();
  final TextEditingController _mothersMiddleName = TextEditingController();
  final TextEditingController _mothersContactNumber = TextEditingController();
  final TextEditingController _guardianLastName = TextEditingController();
  final TextEditingController _guardianFirstName = TextEditingController();
  final TextEditingController _guardianMiddleName = TextEditingController();
  final TextEditingController _guardianContactNumber = TextEditingController();

  String _pwd = '';
  
  void resetForm() {
    _fathersLastName.clear();
    _fathersFirstName.clear();
    _fathersMiddleName.clear();
    _fathersContactNumber.clear();
    _mothersLastName.clear();
    _mothersFirstName.clear();
    _mothersMiddleName.clear();
    _mothersContactNumber.clear();
    _guardianLastName.clear();
    _guardianFirstName.clear();
    _guardianMiddleName.clear();
    _guardianContactNumber.clear();
    _pwd = '';
  }

  @override
  void initState() {
    super.initState();
    _fathersLastName.addListener(_notifyParent);
    _fathersFirstName.addListener(_notifyParent);
    _fathersMiddleName.addListener(_notifyParent);
    _fathersContactNumber.addListener(_notifyParent);
    _mothersLastName.addListener(_notifyParent);
    _mothersFirstName.addListener(_notifyParent);
    _mothersMiddleName.addListener(_notifyParent);
    _mothersContactNumber.addListener(_notifyParent);
    _guardianLastName.addListener(_notifyParent);
    _guardianFirstName.addListener(_notifyParent);
    _guardianMiddleName.addListener(_notifyParent);
    _guardianContactNumber.addListener(_notifyParent);
    

    _fathersLastNameFocusNode.addListener(_onFocusChange);
    _fathersFirstNameFocusNode.addListener(_onFocusChange);
    _fathersMiddleNameFocusNode.addListener(_onFocusChange);
    _fathersContactNumberFocusNode.addListener(_onFocusChange);
    _mothersLastNameFocusNode.addListener(_onFocusChange);
    _mothersFirstNameFocusNode.addListener(_onFocusChange);
    _mothersMiddleNameFocusNode.addListener(_onFocusChange);
    _mothersContactNumberFocusNode.addListener(_onFocusChange);
    _guardianLastNameFocusNode.addListener(_onFocusChange);
    _guardianFirstNameFocusNode.addListener(_onFocusChange);
    _guardianMiddleNameFocusNode.addListener(_onFocusChange);
    _guardianContactNumberFocusNode.addListener(_onFocusChange);
  }

  @override
      void dispose() {
        _fathersLastName.dispose();
        _fathersLastNameFocusNode.dispose();
        _fathersFirstName.dispose();
        _fathersFirstNameFocusNode.dispose();
        _fathersMiddleName.dispose();
        _fathersMiddleNameFocusNode.dispose();
        _fathersContactNumber.dispose();
        _fathersContactNumberFocusNode.dispose();
        _mothersContactNumber.dispose();
        _mothersContactNumberFocusNode.dispose();
        _mothersLastName.dispose();
        _mothersLastNameFocusNode.dispose();
        _mothersFirstName.dispose();
        _mothersFirstNameFocusNode.dispose();
        _mothersMiddleName.dispose();
        _mothersMiddleNameFocusNode.dispose();
        _guardianLastName.dispose();
        _guardianLastNameFocusNode.dispose();
        _guardianFirstName.dispose();
        _guardianFirstNameFocusNode.dispose();
        _guardianMiddleName.dispose();
        _guardianMiddleNameFocusNode.dispose();
        _guardianContactNumber.dispose();
        _guardianContactNumberFocusNode.dispose();
       
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

  // Add this variable to your state:
String? _isUnderSPED;
Map<String, bool> a1Selections = {
  'Attention Deficit Hyperactivity Disorder': false,
  'Autism Spectrum Disorder': false,
  'Cerebral Palsy': false,
  'Emotional-Behavior Disorder': false,
  'Hearing Impairment': false,
  'Intellectual Disability': false,
  'Learning Disability': false,
  'Multiple Disabilities': false,
  'Orthopedic/Physical Handicap': false,
  'Speech/Language Disorder': false,
  'Special Health Problem/Chronic Disease': false,
  'Cancer': false,
  'Non-Cancer': false,
  'Visual Impairment': false,
  'Blind': false,
  'Low Vision': false,
};

Map<String, bool> a2Selections = {
  'Difficulty in Applying Knowledge': false,
  'Difficulty in Communicating': false,
  'Difficulty in Displaying Interpersonal Behavior (Emotional and Behavioral)': false,
  'Difficulty in Hearing': false,
  'Difficulty in Mobility (Walking, Climbing and Grasping)': false,
  'Difficulty in Performing Adaptive Skills (Self-Care)': false,
  'Difficulty in Remembering, Concentrating, Paying Attention and Understanding': false,
  'Difficulty in Seeing': false,
};


Map<String, dynamic> getFormData() {
  return {
    'fathersLastName': _fathersLastName.text,
    'fathersFirstName': _fathersFirstName.text,
    'fathersMiddleName': _fathersMiddleName.text,
    'fathersContactNumber': _fathersContactNumber.text,
    'mothersLastName': _mothersLastName.text,
    'mothersFirstName': _mothersFirstName.text,
    'mothersMiddleName': _mothersMiddleName.text,
    'mothersContactNumber': _mothersContactNumber.text,
    'guardianLastName': _guardianLastName.text,
    'guardianFirstName': _guardianFirstName.text,
    'guardianMiddleName': _guardianMiddleName.text,
    'guardianContactNumber': _guardianContactNumber.text,
    'pwd': _pwd,

    'isUnderSPED': _isUnderSPED,
    'a1Selections': a1Selections.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList(),
    'a2Selections': a2Selections.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList(),
  };
}


  @override
  Widget build(BuildContext context) {
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
            'Parent\'s Guardian Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(
    'Father\'s Information',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        controller: _fathersLastName,
        focusNode: _fathersLastNameFocusNode,
        decoration: InputDecoration(
          labelText: null,
          label: RichText(
            text: TextSpan(
              text: 'Last Name',
              style: TextStyle(
                color: Color.fromARGB(255, 101, 100, 100),
                fontSize: 16,
              ),
              children: [
                if (_fathersLastNameFocusNode.hasFocus || _fathersLastName.text.isNotEmpty)
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 12,
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
            return 'Please enter your father\'s last name';
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
                    controller: _fathersFirstName,
                    focusNode: _fathersFirstNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'First Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_fathersFirstNameFocusNode.hasFocus || _fathersFirstName.text.isNotEmpty)
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
                        return 'Please enter your father\'s first name';
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
                  controller: _fathersMiddleName,
                  focusNode: _fathersMiddleNameFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: null,
                    label: RichText(
                      text: TextSpan(
                        text: 'Middle Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_fathersMiddleNameFocusNode.hasFocus || _fathersMiddleName.text.isNotEmpty)
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
                    controller: _fathersContactNumber,
                    focusNode: _fathersContactNumberFocusNode,
                    keyboardType: TextInputType.number, 
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Contact Number',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_fathersContactNumberFocusNode.hasFocus || _fathersContactNumber.text.isNotEmpty)
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red// Red color for the asterisk
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
                      return 'Please enter your father\'s contact number';
                    }
                    return null;
                  },
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

        Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(
    'Mother\'s Information',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        controller: _mothersLastName,
        focusNode: _mothersLastNameFocusNode,
        decoration: InputDecoration(
          labelText: null,
          label: RichText(
            text: TextSpan(
              text: 'Last Name',
              style: TextStyle(
                color: Color.fromARGB(255, 101, 100, 100),
                fontSize: 16,
              ),
              children: [
                if (_mothersLastNameFocusNode.hasFocus || _mothersLastName.text.isNotEmpty)
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 12,
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
            return 'Please enter your mother\'s last name';
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
                    controller: _mothersFirstName,
                    focusNode: _mothersFirstNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'First Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_mothersFirstNameFocusNode.hasFocus || _mothersFirstName.text.isNotEmpty)
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
                        return 'Please enter your mother\'s first name';
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
                  controller: _mothersMiddleName,
                  focusNode: _mothersMiddleNameFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: null,
                    label: RichText(
                      text: TextSpan(
                        text: 'Middle Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_mothersMiddleNameFocusNode.hasFocus || _mothersMiddleName.text.isNotEmpty)
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
                    controller: _mothersContactNumber,
                    focusNode: _mothersContactNumberFocusNode,
                    keyboardType: TextInputType.number, 
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Contact Number',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_mothersContactNumberFocusNode.hasFocus || _mothersContactNumber.text.isNotEmpty)
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red// Red color for the asterisk
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
                      return 'Please enter your mother\'s contact number';
                    }
                    return null;
                  },
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
       Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(
    'Legal Guardian\'s Information',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        controller: _guardianLastName,
        focusNode: _guardianLastNameFocusNode,
        decoration: InputDecoration(
          labelText: null,
          label: RichText(
            text: TextSpan(
              text: 'Last Name',
              style: TextStyle(
                color: Color.fromARGB(255, 101, 100, 100),
                fontSize: 16,
              ),
              children: [
                if (_guardianLastNameFocusNode.hasFocus || _guardianLastName.text.isNotEmpty)
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 12,
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
            return 'Please enter your guardian\'s last name';
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
                    controller: _guardianFirstName,
                    focusNode: _guardianFirstNameFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'First Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_guardianFirstNameFocusNode.hasFocus || _guardianFirstName.text.isNotEmpty)
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
                        return 'Please enter your guardian\'s first name';
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
                  controller: _guardianMiddleName,
                  focusNode: _guardianMiddleNameFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: null,
                    label: RichText(
                      text: TextSpan(
                        text: 'Middle Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_guardianMiddleNameFocusNode.hasFocus || _guardianMiddleName.text.isNotEmpty)
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
                    controller: _guardianContactNumber,
                    focusNode: _guardianContactNumberFocusNode,
                    keyboardType: TextInputType.number, 
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Contact Number',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_guardianContactNumberFocusNode.hasFocus || _guardianContactNumber.text.isNotEmpty)
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red// Red color for the asterisk
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
                      return 'Please enter your guardian\'s contact number';
                    }
                    return null;
                  },
                    onChanged: (text) {
                      setState(() {});
                    }
                    
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
                 // SPED Program Dropdown + a1 & a2 Checkboxes
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      width: fieldWidth,
      child: DropdownButtonFormField<String>(
        value: _isUnderSPED,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: 'Is the Learner under the Special Needs Education Program?',
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
            _isUnderSPED = value!;
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
    SizedBox(height: 20),

    if (_isUnderSPED == 'Yes') ...[
      // Instruction Text
  Text(
    'If Yes, check only 1, either from a1 or a2',
    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: Colors.black87),
  ),
  SizedBox(height: 10),
      // a1 Title
      Text('a1. With Diagnosis from Licensed Medical Specialist:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: a1Selections.keys.map((key) {
          return CheckboxListTile(
            value: a1Selections[key],
            onChanged: (bool? newValue) {
              setState(() {
                a1Selections[key] = newValue!;
              });
            },
            title: Text(key, style: TextStyle(fontSize: 14)),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
      SizedBox(height: 20),

      // a2 Title
      Text('a2. With Manifestations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: a2Selections.keys.map((key) {
          return CheckboxListTile(
            value: a2Selections[key],
            onChanged: (bool? newValue) {
              setState(() {
                a2Selections[key] = newValue!;
              });
            },
            title: Text(key, style: TextStyle(fontSize: 14)),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    ],
  ],
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
                  child: DropdownButtonFormField<String>(
                    value: _pwd.isEmpty ? null : _pwd,
                    onChanged: (value) {
                      setState(() {
                        _pwd = value!;
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
                      labelText: 'Does the Learner have a PWD ID?',
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
      ]
    );
  }
}
