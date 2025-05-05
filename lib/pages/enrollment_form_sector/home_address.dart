import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAddress extends StatefulWidget {

  
  final double spacing;
  final Function(Map<String, dynamic>) onDataChanged;


  HomeAddress({required this.spacing, required this.onDataChanged, Key? key}) : super(key: key);

  @override
  State<HomeAddress> createState() => HomeAddressState();
}

class HomeAddressState extends State<HomeAddress> with AutomaticKeepAliveClientMixin {
  final FocusNode _houseNumberFocusNode = FocusNode();
  final FocusNode _streetNameFocusNode = FocusNode();
  final FocusNode _subdivisionFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _provinceFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _zipCodeFocusNode = FocusNode();

  final FocusNode _currentHouseNumberFocusNode = FocusNode();
  final FocusNode _currentStreetNameFocusNode = FocusNode();
  final FocusNode _currentSubdivisionFocusNode = FocusNode();
  final FocusNode _currentCityFocusNode = FocusNode();
  final FocusNode _currentProvinceFocusNode = FocusNode();
  final FocusNode _currentCountryFocusNode = FocusNode();
  final FocusNode _currentZipCodeFocusNode = FocusNode();

  final TextEditingController _houseNumber = TextEditingController();
  final TextEditingController _streetName = TextEditingController();
  final TextEditingController _subdivisionBarangay = TextEditingController();
  final TextEditingController _cityMunicipality = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  final TextEditingController _currentHouseNumber = TextEditingController();
  final TextEditingController _currentStreetName = TextEditingController();
  final TextEditingController _currentSubdivisionBarangay = TextEditingController();
  final TextEditingController _currentCityMunicipality = TextEditingController();
  final TextEditingController _currentProvince = TextEditingController();
  final TextEditingController _currentCountry = TextEditingController();
  final TextEditingController _currentZipCodeController = TextEditingController();

  void resetForm() {
    _houseNumber.clear();
    _streetName.clear();
    _subdivisionBarangay.clear();
    _cityMunicipality.clear();
    _province.clear();
    _country.clear();
    _zipCodeController.clear();

    _currentHouseNumber.clear();
    _currentStreetName.clear();
    _currentSubdivisionBarangay.clear();
    _currentCityMunicipality.clear();
    _currentProvince.clear();
    _currentCountry.clear();
    _currentZipCodeController.clear();
  }

  @override
  void initState() {
    super.initState();
    _houseNumber.addListener(_notifyParent);
    _streetName.addListener(_notifyParent);
    _subdivisionBarangay.addListener(_notifyParent);
    _cityMunicipality.addListener(_notifyParent);
    _province.addListener(_notifyParent);
    _country.addListener(_notifyParent);
    _zipCodeController.addListener(_notifyParent);

    _currentHouseNumber.addListener(_notifyParent);
    _currentStreetName.addListener(_notifyParent);
    _currentSubdivisionBarangay.addListener(_notifyParent);
    _currentCityMunicipality.addListener(_notifyParent);
    _currentProvince.addListener(_notifyParent);
    _currentCountry.addListener(_notifyParent);
    _currentZipCodeController.addListener(_notifyParent);

    _houseNumberFocusNode.addListener(_onFocusChange);
    _streetNameFocusNode.addListener(_onFocusChange);
    _subdivisionFocusNode.addListener(_onFocusChange);
    _cityFocusNode.addListener(_onFocusChange);
    _provinceFocusNode.addListener(_onFocusChange);
    _provinceFocusNode.addListener(_onFocusChange);
    _zipCodeFocusNode.addListener(_onFocusChange);

    _currentCityFocusNode.addListener(_onFocusChange);
    _currentHouseNumberFocusNode.addListener(_onFocusChange);
    _currentStreetNameFocusNode.addListener(_onFocusChange);
    _currentSubdivisionFocusNode.addListener(_onFocusChange);
    _currentProvinceFocusNode.addListener(_onFocusChange);
    _currentCountryFocusNode.addListener(_onFocusChange);
    _currentZipCodeFocusNode.addListener(_onFocusChange);
  }

  @override
      void dispose() {
        _houseNumber.dispose();
        _houseNumberFocusNode.dispose();
        _streetName.dispose();
        _streetNameFocusNode.dispose();
        _subdivisionBarangay.dispose();
        _subdivisionFocusNode.dispose();
        _cityMunicipality.dispose();
        _cityFocusNode.dispose();
        _province.dispose();
        _provinceFocusNode.dispose();
        _country.dispose();
        _countryFocusNode.dispose();
        _zipCodeController.dispose();
        _zipCodeFocusNode.dispose();

        _currentHouseNumber.dispose();
        _currentHouseNumberFocusNode.dispose();
        _currentStreetName.dispose();
        _currentStreetNameFocusNode.dispose();
        _currentSubdivisionBarangay.dispose();
        _currentSubdivisionFocusNode.dispose();
        _currentCityMunicipality.dispose();
        _currentCityFocusNode.dispose();
        _currentProvince.dispose();
        _currentProvinceFocusNode.dispose();
        _currentCountry.dispose();
        _currentCountryFocusNode.dispose();
        _currentZipCodeController.dispose();
        _currentZipCodeFocusNode.dispose();
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
      'house_number': _houseNumber.text,
      'street_name': _streetName.text,
      'subdivision_barangay': _subdivisionBarangay.text,
      'city_municipality': _cityMunicipality.text,
      'province': _province.text,
      'country': _country.text,
      'zip_code': _zipCodeController.text,

      'current_house_number': _currentHouseNumber.text,
      'current_street_name': _currentStreetName.text,
      'current_subdivision_barangay': _currentSubdivisionBarangay.text,
      'current_city_municipality': _currentCityMunicipality.text,
      'current_province': _currentProvince.text,
      'current_country': _currentCountry.text,
      'current_zip_code': _currentZipCodeController.text,
    };
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Current Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  controller: _currentHouseNumber,
                  focusNode: _currentHouseNumberFocusNode,
                  textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'House / No',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_houseNumberFocusNode.hasFocus || _houseNumber.text.isNotEmpty)
                          TextSpan(
                            text: '(optional)',
                            style: TextStyle(
                              color: Color.fromARGB(255, 101, 100, 100),                            ),
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
                    inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText, selection: newValue.selection);
                    }),
                  ],
                ),
              ),
              // SizedBox(width: widget.spacing),
              Container(
                width: fieldWidth,
                child: TextFormField(
                  controller: _currentStreetName,
                  focusNode: _currentStreetNameFocusNode,
                  textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Street Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_streetNameFocusNode.hasFocus || _streetName.text.isNotEmpty)
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
                      return 'Please enter your street name';
                    }
                    return null;
                  },
                  onChanged: (text) {
                      setState(() {});
                    },
                    inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText, selection: newValue.selection);
                    }),
                  ],
                ),
              ),
              // SizedBox(width: widget.spacing),
              Container(
                width: fieldWidth,
                child: TextFormField(
                  controller: _currentSubdivisionBarangay,
                  focusNode: _currentSubdivisionFocusNode,
                  textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Subdivision / Barangay',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_subdivisionFocusNode.hasFocus || _subdivisionBarangay.text.isNotEmpty)
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
                      return 'Please enter your barangay';
                    }
                    return null;
                  },
                  onChanged: (text) {
                      setState(() {});
                    },
                    inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText, selection: newValue.selection);
                    }),
                  ],
                ),
              ),
              
              Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _currentCityMunicipality,
                    focusNode: _currentCityFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'City / Municipality',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_cityFocusNode.hasFocus || _cityMunicipality.text.isNotEmpty)
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
                        return 'Please enter your municipality';
                      }
                      return null;
                    },
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
                    controller: _currentProvince,
                    focusNode: _currentProvinceFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Province',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_provinceFocusNode.hasFocus || _province.text.isNotEmpty)
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
                        return 'Please enter your province';
                      }
                      return null;
                    },
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
              
              // SizedBox(width: widget.spacing),
              Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _currentCountry,
                    focusNode: _currentCountryFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Country',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_countryFocusNode.hasFocus || _country.text.isNotEmpty)
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
                        return 'Please enter your country';
                      }
                      return null;
                    },
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
                Container(
        width: fieldWidth,
        child: TextFormField(
          controller: _currentZipCodeController,
          focusNode: _currentZipCodeFocusNode,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: null,
            label: RichText(
              text: TextSpan(
                text: 'Zip Code',
                style: TextStyle(
                  color: Color.fromARGB(255, 101, 100, 100),
                  fontSize: 16,
                ),
                children: [
                  if (_zipCodeFocusNode.hasFocus || _zipCodeController.text.isNotEmpty)
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
              return 'Please enter your zip code';
            }
            return null;
          },
          onChanged: (text) {
            setState(() {});
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
        ),
      ),
              
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Permanent Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  controller: _houseNumber,
                  focusNode: _houseNumberFocusNode,
                  textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'House / No',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_houseNumberFocusNode.hasFocus || _houseNumber.text.isNotEmpty)
                          TextSpan(
                            text: '(optional)',
                            style: TextStyle(
                              color: Color.fromARGB(255, 101, 100, 100),                            ),
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
                    inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText, selection: newValue.selection);
                    }),
                  ],
                ),
              ),
              // SizedBox(width: widget.spacing),
              Container(
                width: fieldWidth,
                child: TextFormField(
                  controller: _streetName,
                  focusNode: _streetNameFocusNode,
                  textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Street Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_streetNameFocusNode.hasFocus || _streetName.text.isNotEmpty)
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
                      return 'Please enter your street name';
                    }
                    return null;
                  },
                  onChanged: (text) {
                      setState(() {});
                    },
                    inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText, selection: newValue.selection);
                    }),
                  ],
                ),
              ),
              // SizedBox(width: widget.spacing),
              Container(
                width: fieldWidth,
                child: TextFormField(
                  controller: _subdivisionBarangay,
                  focusNode: _subdivisionFocusNode,
                  textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Subdivision / Barangay',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_subdivisionFocusNode.hasFocus || _subdivisionBarangay.text.isNotEmpty)
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
                      return 'Please enter your barangay';
                    }
                    return null;
                  },
                  onChanged: (text) {
                      setState(() {});
                    },
                    inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalize the first letter of every word after a space
                      String newText = newValue.text.split(' ').map((word) {
                        if (word.isNotEmpty) {
                          return word[0].toUpperCase() + word.substring(1).toLowerCase();
                        }
                        return ''; // Handle empty words
                      }).join(' '); // Join back the words with spaces
                      return newValue.copyWith(text: newText, selection: newValue.selection);
                    }),
                  ],
                ),
              ),
              
              Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _cityMunicipality,
                    focusNode: _cityFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'City / Municipality',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_cityFocusNode.hasFocus || _cityMunicipality.text.isNotEmpty)
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
                        return 'Please enter your municipality';
                      }
                      return null;
                    },
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
                    controller: _province,
                    focusNode: _provinceFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Province',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_provinceFocusNode.hasFocus || _province.text.isNotEmpty)
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
                        return 'Please enter your province';
                      }
                      return null;
                    },
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
              
              // SizedBox(width: widget.spacing),
              Container(
                  width: fieldWidth,
                  child: TextFormField(
                    controller: _country,
                    focusNode: _countryFocusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: null,
                      label: RichText(text: TextSpan(
                        text: 'Country',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 100, 100),
                          fontSize: 16,
                        ),
                        children: [
                          if (_countryFocusNode.hasFocus || _country.text.isNotEmpty)
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
                        return 'Please enter your country';
                      }
                      return null;
                    },
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
                Container(
        width: fieldWidth,
        child: TextFormField(
          controller: _zipCodeController,
          focusNode: _zipCodeFocusNode,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: null,
            label: RichText(
              text: TextSpan(
                text: 'Zip Code',
                style: TextStyle(
                  color: Color.fromARGB(255, 101, 100, 100),
                  fontSize: 16,
                ),
                children: [
                  if (_zipCodeFocusNode.hasFocus || _zipCodeController.text.isNotEmpty)
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
              return 'Please enter your zip code';
            }
            return null;
          },
          onChanged: (text) {
            setState(() {});
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
        ),
      ),
              
            ],
          ),
        ),
      ],
    );
  }
}
