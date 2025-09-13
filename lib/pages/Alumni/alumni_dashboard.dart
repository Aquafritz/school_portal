import 'dart:io';
import 'dart:typed_data';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:balungao_nhs/pages/Alumni/cases/case1.dart';
import 'package:balungao_nhs/student_utils/cases/case0.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:balungao_nhs/launcher.dart';
import 'package:balungao_nhs/widgets/hover_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

class AlumniDashboard extends StatefulWidget {
  const AlumniDashboard({super.key});

  @override
  State<AlumniDashboard> createState() => _AlumniDashboardState();
}

class _AlumniDashboardState extends State<AlumniDashboard> {
   final SidebarXController _sidebarController =
      SidebarXController(selectedIndex: 0);
  final ValueNotifier<String?> _imageNotifier = ValueNotifier<String?>(null);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadInitialProfileImage();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('sidebar_index') ?? 0;
    setState(() {
      _sidebarController.selectIndex(savedIndex);
    });

    // Add listener to save index when it changes
    _sidebarController.addListener(() {
      prefs.setInt('sidebar_index', _sidebarController.selectedIndex);
    });
  }

  Future<void> _loadInitialProfileImage() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      final docSnapshot = await userDoc.get();
      final imageUrl = docSnapshot.data()?['image_url'];
      _imageNotifier.value = imageUrl; // Set initial profile picture URL
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              backgroundColor: canvasColor,
              title: Text(
                "Alumni Dashboard",
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () {
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      drawer: isSmallScreen
          ? ExampleSidebarX(
              controller: _sidebarController,
              imageNotifier: _imageNotifier, // Pass imageNotifier here
            )
          : null,
      body: Row(
        children: [
          if (!isSmallScreen)
            ExampleSidebarX(
              controller: _sidebarController,
              imageNotifier: _imageNotifier, // Pass imageNotifier here as well
            ),
          Expanded(
            child: Center(
              child: _ScreensExample(
                controller: _sidebarController,
               
                imageNotifier:
                    _imageNotifier, // Pass imageNotifier to _ScreensExample
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleSidebarX extends StatefulWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
    required this.imageNotifier,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;
  final ValueNotifier<String?> imageNotifier;

  @override
  State<ExampleSidebarX> createState() => _ExampleSidebarXState();
}

class _ExampleSidebarXState extends State<ExampleSidebarX> {
  @override
  void initState() {
    super.initState();
    _loadAlumniData();

    // Listen to changes in imageNotifier
    widget.imageNotifier.addListener(() {
      setState(() {}); // Rebuild when imageNotifier updates
    });
  }

  String? _alumniName;

  Future<void> _loadAlumniData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = userSnapshot.docs.first;

          setState(() {
            _alumniName = userDoc['first_name'] +
                ' ' +
                userDoc['middle_name'] +
                ' ' +
                userDoc['last_name'];
            widget.imageNotifier.value = userDoc['image_url'];
          });
        } else {
          print('No matching student document found.');
        }
      } catch (e) {
        print('Failed to load student data: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF002f24),
      child: SidebarX(
        controller: widget._controller,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: scaffoldBackgroundColor,
          textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          selectedTextStyle: const TextStyle(color: Colors.white),
          hoverTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [accentCanvasColor, canvasColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
        ),
        footerDivider: divider,
        headerBuilder: (context, extended) {
          return SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: widget.imageNotifier.value != null
                        ? NetworkImage(widget.imageNotifier.value!)
                        : NetworkImage(
                            'https://cdn4.iconfinder.com/data/icons/linecon/512/photo-512.png'),
                  ),
                ),
                if (extended)
                  Text(
                    _alumniName ?? "No Name", // Display student ID if available
                    style: TextStyle(color: Colors.white),
                  ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
          ),
          const SidebarXItem(
            icon: Icons.request_page,
            label: 'Document Requests',
          ),
          const SidebarXItem(
            icon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _ScreensExample extends StatefulWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
    required this.imageNotifier,
  }) : super(key: key);

  final SidebarXController controller;
  final ValueNotifier<String?> imageNotifier;

  @override
  State<_ScreensExample> createState() => _ScreensExampleState();
}

class _ScreensExampleState extends State<_ScreensExample> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation

  TextEditingController houseNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController subdivisionBarangayController = TextEditingController();
  TextEditingController cityMunicipalityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cellphoneNumController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;
  bool _passwordMismatch = false;

  Map<String, dynamic> userData = {};
  bool _isLoading = true;


  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    phoneController.dispose();
    houseNumberController.dispose();
    streetNameController.dispose();
    subdivisionBarangayController.dispose();
    cityMunicipalityController.dispose();
    provinceController.dispose();
    countryController.dispose();
    cellphoneNumController.dispose();
    super.dispose();
  }

  // Modify _fetchUserData to return a Future
  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docSnapshot = querySnapshot.docs.first;
          if (mounted) {
            setState(() {
              userData = docSnapshot.data();
              // Initialize controllers with fetched data
              houseNumberController.text = userData['house_number'] ?? '';
              streetNameController.text = userData['street_name'] ?? '';
              subdivisionBarangayController.text =
                  userData['subdivision_barangay'] ?? '';
              cityMunicipalityController.text =
                  userData['city_municipality'] ?? '';
              provinceController.text = userData['province'] ?? '';
              countryController.text = userData['country'] ?? '';
              phoneController.text = userData['phone_number'] ?? '';
              cellphoneNumController.text = userData['cellphone_number'] ?? '';
            });
          }
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_newPasswordController.text.isNotEmpty ||
            _confirmPasswordController.text.isNotEmpty) {
          if (_newPasswordController.text != _confirmPasswordController.text) {
            setState(() {
              _passwordMismatch = true;
            });
            // Add a ScaffoldMessenger to show the error more prominently
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Image.asset('assets/LOGOFORSALOMAGUE.png', scale: 40),
                    SizedBox(width: 10),
                    Text('Passwords do not match'),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
            return; // Return early if passwords don't match
          }
          setState(() {
            _passwordMismatch = false;
          });
        }

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: user.uid)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            final docSnapshot = querySnapshot.docs.first;

            // Check if any user data fields have been modified
            bool hasUserDataChanges = houseNumberController.text.isNotEmpty ||
                streetNameController.text.isNotEmpty ||
                subdivisionBarangayController.text.isNotEmpty ||
                cityMunicipalityController.text.isNotEmpty ||
                provinceController.text.isNotEmpty ||
                countryController.text.isNotEmpty ||
                phoneController.text.isNotEmpty ||
                cellphoneNumController.text.isNotEmpty;

            // Check if password fields have been filled
            bool hasPasswordChanges = _newPasswordController.text.isNotEmpty &&
                _confirmPasswordController.text.isNotEmpty;

            // Update user data if changes exist
            if (hasUserDataChanges) {
              await docSnapshot.reference.update({
                'house_number': houseNumberController.text,
                'street_name': streetNameController.text,
                'subdivision_barangay': subdivisionBarangayController.text,
                'city_municipality': cityMunicipalityController.text,
                'province': provinceController.text,
                'country': countryController.text,
                'phone_number': phoneController.text,
                'cellphone_number': cellphoneNumController.text
              });
            }

            // Update password if changes exist
            if (hasPasswordChanges) {
              if (_newPasswordController.text !=
                  _confirmPasswordController.text) {
                setState(() {
                  _passwordMismatch = true;
                });
                return;
              }

              // Password validation
              RegExp passwordRegex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,}$',
              );

              if (!passwordRegex.hasMatch(_newPasswordController.text)) {
                _showDialog('Weak Password',
                    'Password must contain at least 8 characters, including uppercase letters, lowercase letters, numbers, and symbols.');
                return;
              }

              await user.updatePassword(_newPasswordController.text);

              // Clear password fields after successful update
              _newPasswordController.clear();
              _confirmPasswordController.clear();
              setState(() {
                _passwordMismatch = false;
              });
            }

            // Show success message
            if (hasUserDataChanges || hasPasswordChanges) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Image.asset('bassets/LOGOFORSALOMAGUE.png', scale: 40),
                      SizedBox(width: 10),
                      Text(hasUserDataChanges && hasPasswordChanges
                          ? "Information and password updated successfully"
                          : hasUserDataChanges
                              ? "Information updated successfully"
                              : "Password updated successfully"),
                    ],
                  ),
                ),
              );
            }

            // Refresh user data
            if (hasUserDataChanges) {
              _fetchUserData();
            }
          }
        }
      } catch (e) {
        print("Error updating: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
            children: [
              Image.asset('assets/LOGOFORSALOMAGUE.png', scale: 40),
              SizedBox(width: 10),
              Text("Error updating: $e"),
            ],
          )),
        );
      }
    }
  }

  void _showDialog(String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  File? _imageFile; // For mobile (Android/iOS)
  Uint8List? _imageBytes; // For web

  String? _imageUrl;

  Future<void> _imageGetterFromExampleState() async {
    User? user =
        FirebaseAuth.instance.currentUser; // Get the current logged-in user

    if (user != null) {
      try {
        // Query the 'users' collection where the 'uid' field matches the current user's UID
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          // Assuming only one document will be returned, get the first document
          DocumentSnapshot userDoc = userSnapshot.docs.first;

          setState(() {
            _imageUrl = userDoc['image_url'];
          });
        } else {
          print('No matching student document found.');
        }
      } catch (e) {
        print('Failed to load student data: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

  final ImagePicker picker = ImagePicker();

  bool _isHovered = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        // For web, store the image as Uint8List
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _imageFile = null; // Clear mobile file if on web
        });
      } else {
        // For mobile, store the image as File
        setState(() {
          _imageFile = File(pickedFile.path);
          _imageBytes = null; // Clear web bytes if on mobile
        });
      }
    }
  }

  Future<void> replaceProfilePicture() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print("No user is currently signed in.");
        return;
      }

      final userQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("User document not found for UID: ${currentUser.uid}");
        return;
      }

      final userDoc = userQuerySnapshot.docs.first;
      final userDocRef = userDoc.reference;

      String? oldImageUrl = userDoc.data()['image_url'];
      print("Old Image URL: $oldImageUrl");

      if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
        try {
          final oldImageRef = FirebaseStorage.instance.refFromURL(oldImageUrl);
          await oldImageRef.delete();
          print("Old profile picture deleted successfully.");
        } catch (e) {
          print("Failed to delete old profile picture: $e");
        }
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('student_pictures')
          .child('${DateTime.now().toIso8601String()}.png');

      if (_imageBytes != null) {
        await storageRef.putData(_imageBytes!);
      } else if (_imageFile != null) {
        await storageRef.putFile(_imageFile!);
      } else {
        print("No image selected.");
        return;
      }

      final newImageUrl = await storageRef.getDownloadURL();
      print("New Image URL: $newImageUrl");

      await userDocRef.update({'image_url': newImageUrl});
      print("Profile picture updated successfully.");

      // Update the imageNotifier with the new URL to trigger a rebuild in ExampleSidebarX
      if (mounted) {
        widget.imageNotifier.value = newImageUrl;
      }
    } catch (e) {
      print("Failed to replace profile picture: $e");
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) => Launcher(
                    scrollToFooter: false,
                  )));
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(widget.controller.selectedIndex);
        switch (widget.controller.selectedIndex) {
          case 0:
          return Case0();

          case 1: 
          return Case1();

          case 2:
            double screenWidth = MediaQuery.of(context).size.width;
            final bool isMobile = screenWidth < 600;
            final bool isTablet = screenWidth >= 600 && screenWidth < 1200;
            final bool isWeb = screenWidth >= 1200;

            // Define width for text fields based on screen size
            double fieldWidth;
            if (screenWidth >= 1200) {
              // Large screens (Web/Desktop)
              fieldWidth = 270;
            } else if (screenWidth >= 800) {
              // Medium screens (Tablet)
              fieldWidth = 240;
            } else {
              // Small screens (Mobile)
              fieldWidth =
                  screenWidth * 0.8; // Adjust to take most of the screen width
            }

            // Define spacing between fields
            double spacing = screenWidth >= 800 ? 16.0 : 8.0;

            // long term words
            final double textFontSize1 = isMobile ? 10 : (isTablet ? 8 : 9);
            final double textFontSize2 = isMobile ? 8 : (isTablet ? 6 : 7);
            final double textFontSize3 = isMobile ? 12 : (isTablet ? 10 : 11);
            final double textFontSize4 = isMobile ? 10 : (isTablet ? 8 : 9);

            if (_isLoading) {
              return Container(
                color: const Color(0xFF002f24),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('LOADING...'),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ),
              );
            }
            return LayoutBuilder(builder: (context, constraints) {
              // Get screen width
              double butWidth = constraints.maxWidth;
              final bool isMobiles = butWidth < 600;
              final bool isTablets = butWidth >= 600 && butWidth < 1200;
              final bool isWebs = butWidth >= 1200;

              return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      color: Color(0xFF002f24),
                      width: screenWidth,
                      child: Container(
                        margin: EdgeInsets.all(isMobiles ? 15 : 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await _pickImage(); // Open image picker to select a new image

                                          if (_imageBytes != null ||
                                              _imageFile != null) {
                                            await replaceProfilePicture(); // Upload and replace the profile picture

                                            // Reload the new image URL from Firestore after uploading
                                            await _imageGetterFromExampleState();

                                            setState(
                                                () {}); // Refresh the UI after updating the image URL
                                          }
                                        },
                                        child: MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              _isHovered = true;
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              _isHovered = false;
                                            });
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: isMobiles ? 50 : 85,
                                                backgroundImage: _imageBytes !=
                                                        null
                                                    ? MemoryImage(_imageBytes!)
                                                        as ImageProvider
                                                    : _imageFile != null
                                                        ? FileImage(_imageFile!)
                                                            as ImageProvider
                                                        : _imageUrl != null
                                                            ? NetworkImage(
                                                                    _imageUrl!)
                                                                as ImageProvider
                                                            : const NetworkImage(
                                                                'https://cdn4.iconfinder.com/data/icons/linecon/512/photo-512.png',
                                                              ),
                                              ),
                                              if (_isHovered)
                                                Container(
                                                  width: isMobiles ? 100 : 170,
                                                  height: isMobiles ? 100 : 170,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.image,
                                                    color: Colors.white,
                                                    size: 60,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ).showCursorOnHover,
                                      SizedBox(width: isMobiles ? 10 : 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            children: [
                                              Text(
                                                "${userData['first_name'] ?? 'N/A'}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "B",
                                                    fontSize:
                                                        isMobiles ? 14 : 25),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                "${userData['middle_name'] ?? 'N/A'}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "B",
                                                    fontSize:
                                                        isMobiles ? 14 : 25),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                "${userData['last_name'] ?? 'N/A'}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "B",
                                                    fontSize:
                                                        isMobiles ? 14 : 25),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Wrap(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await _pickImage(); // Open image picker to select a new image

                                                  if (_imageBytes != null ||
                                                      _imageFile != null) {
                                                    await replaceProfilePicture(); // Upload and replace the profile picture

                                                    // Reload the new image URL from Firestore after uploading
                                                    await _imageGetterFromExampleState();

                                                    setState(
                                                        () {}); // Refresh the UI after updating the image URL
                                                  }
                                                },
                                                child: Container(
                                                  height: isMobiles ? 30 : 40,
                                                  width: isMobiles ? 100 : 150,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF03b97c),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Edit Profile",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "B",
                                                          fontSize: isMobiles
                                                              ? 12
                                                              : 15,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.edit,
                                                        size:
                                                            isMobiles ? 12 : 15,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ).showCursorOnHover.moveUpOnHover,
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  logout();
                                                },
                                                child: Container(
                                                  height: isMobiles ? 30 : 40,
                                                  width: isMobiles ? 100 : 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Logout",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002f24),
                                                            fontFamily: "B",
                                                            fontSize: isMobiles
                                                                ? 12
                                                                : 15),
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Icon(
                                                        Icons.logout_rounded,
                                                        size:
                                                            isMobiles ? 15 : 20,
                                                        color:
                                                            Color(0xFF002f24),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ).showCursorOnHover.moveUpOnHover,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Alumni Information",
                                style: TextStyle(
                                    color: Color(0xFF03b97c),
                                    fontSize: 25,
                                    fontFamily: "SB"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "First Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['first_name'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Middle Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['middle_name'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Last Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['last_name'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Extension Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['extension_name'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Age",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['age'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['gender'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Birthdate",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['birthdate'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Email Address",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['email_Address'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: (userData['email_Address']
                                                            ?.length ??
                                                        0) >
                                                    45
                                                ? textFontSize4
                                                : textFontSize3,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (phoneController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "Phone Number",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),

                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller: phoneController,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '09********',
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            // Ensure the number starts with '09' and has exactly 11 digits
                                            if (!RegExp(r'^(09\d{9})$')
                                                .hasMatch(value)) {
                                              return 'Enter a valid phone number starting with 09 (e.g., 09xxxxxxxxx)';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                11),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Indigenous People (IP)",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['indigenous_group'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Student Number",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['student_id'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "LRN",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['lrn'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Home Address",
                                style: TextStyle(
                                    color: Color(0xFF03b97c),
                                    fontSize: 25,
                                    fontFamily: "SB"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: [
                                  Column(
                                    children: [
                                      // if (houseNumberController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "House Number",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller: houseNumberController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          inputFormatters: [
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              // Capitalize the first letter of every word after a space
                                              String newText = newValue.text
                                                  .split(' ')
                                                  .map((word) {
                                                if (word.isNotEmpty) {
                                                  return word[0].toUpperCase() +
                                                      word
                                                          .substring(1)
                                                          .toLowerCase();
                                                }
                                                return ''; // Handle empty words
                                              }).join(' '); // Join back the words with spaces
                                              return newValue.copyWith(
                                                  text: newText,
                                                  selection:
                                                      newValue.selection);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (streetNameController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "Street Name",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller: streetNameController,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your street name';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          inputFormatters: [
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              // Capitalize the first letter of every word after a space
                                              String newText = newValue.text
                                                  .split(' ')
                                                  .map((word) {
                                                if (word.isNotEmpty) {
                                                  return word[0].toUpperCase() +
                                                      word
                                                          .substring(1)
                                                          .toLowerCase();
                                                }
                                                return ''; // Handle empty words
                                              }).join(' '); // Join back the words with spaces
                                              return newValue.copyWith(
                                                  text: newText,
                                                  selection:
                                                      newValue.selection);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (subdivisionBarangayController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "Subdivision/Barangay",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller:
                                              subdivisionBarangayController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your barangay';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          inputFormatters: [
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              // Capitalize the first letter of every word after a space
                                              String newText = newValue.text
                                                  .split(' ')
                                                  .map((word) {
                                                if (word.isNotEmpty) {
                                                  return word[0].toUpperCase() +
                                                      word
                                                          .substring(1)
                                                          .toLowerCase();
                                                }
                                                return ''; // Handle empty words
                                              }).join(' '); // Join back the words with spaces
                                              return newValue.copyWith(
                                                  text: newText,
                                                  selection:
                                                      newValue.selection);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (cityMunicipalityController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "City/Municipality",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller:
                                              cityMunicipalityController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your municipality';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-z\s]')),
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              // Capitalize the first letter of every word after a space
                                              String newText = newValue.text
                                                  .split(' ')
                                                  .map((word) {
                                                if (word.isNotEmpty) {
                                                  return word[0].toUpperCase() +
                                                      word
                                                          .substring(1)
                                                          .toLowerCase();
                                                }
                                                return ''; // Handle empty words
                                              }).join(' '); // Join back the words with spaces
                                              return newValue.copyWith(
                                                  text: newText);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (provinceController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "Province",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          controller: provinceController,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your province';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-z\s]')),
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              // Capitalize the first letter of every word after a space
                                              String newText = newValue.text
                                                  .split(' ')
                                                  .map((word) {
                                                if (word.isNotEmpty) {
                                                  return word[0].toUpperCase() +
                                                      word
                                                          .substring(1)
                                                          .toLowerCase();
                                                }
                                                return ''; // Handle empty words
                                              }).join(' '); // Join back the words with spaces
                                              return newValue.copyWith(
                                                  text: newText);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (countryController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "Country",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller: countryController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your country';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-z\s]')),
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              // Capitalize the first letter of every word after a space
                                              String newText = newValue.text
                                                  .split(' ')
                                                  .map((word) {
                                                if (word.isNotEmpty) {
                                                  return word[0].toUpperCase() +
                                                      word
                                                          .substring(1)
                                                          .toLowerCase();
                                                }
                                                return ''; // Handle empty words
                                              }).join(' '); // Join back the words with spaces
                                              return newValue.copyWith(
                                                  text: newText);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Parent Guardian Information",
                                style: TextStyle(
                                    color: Color(0xFF03b97c),
                                    fontSize: 25,
                                    fontFamily: "SB"),
                              ),
                              Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Father's Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['fathersName'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Mother's Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['mothersName'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Guardian's Name",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['guardianName'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Relationship",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          initialValue:
                                              "${userData['relationshipGuardian'] ?? 'N/A'}",
                                          enabled: false,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // if (cellphoneNumController.text.isNotEmpty)
                                      RichText(
                                          text: TextSpan(
                                              text: "Phone Number",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ])),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller: cellphoneNumController,
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '09********',
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            // Ensure the number starts with '09' and has exactly 11 digits
                                            if (!RegExp(r'^(09\d{9})$')
                                                .hasMatch(value)) {
                                              return 'Enter a valid phone number starting with 09 (e.g., 09xxxxxxxxx)';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                11),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                           
                              Text(
                                "Change Password",
                                style: TextStyle(
                                    color: Color(0xFF03b97c),
                                    fontSize: 25,
                                    fontFamily: "SB"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "New Password",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller: _newPasswordController,
                                          obscureText: _obscureTextNew,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty &&
                                                value !=
                                                    _confirmPasswordController
                                                        .text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter new password',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                Icon(Icons.lock_outline),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureTextNew
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureTextNew =
                                                      !_obscureTextNew;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Confirm Password",
                                        style: TextStyle(
                                          fontFamily: "M",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: fieldWidth,
                                        child: TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          obscureText: _obscureTextConfirm,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty &&
                                                value !=
                                                    _newPasswordController
                                                        .text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                          enabled: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "R",
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Confirm New Password',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                Icon(Icons.lock_outline),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureTextConfirm
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureTextConfirm =
                                                      !_obscureTextConfirm;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if (_passwordMismatch)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Passwords do not match',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              Center(
                                child: Container(
                                    height: isMobiles ? 30 : 40,
                                    width: isMobiles ? 100 : 150,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Color(0xFF03b97c)),
                                          elevation:
                                              WidgetStateProperty.all<double>(
                                                  5),
                                          shape: WidgetStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        onPressed: _updateUserData,
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: isMobiles ? 14 : 18,
                                              fontFamily: 'B'),
                                        ))),
                              )
                            ]),
                      ),
                    ),
                  ));
            });

          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }

  String _getTitleByIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Document Requests';
      case 2:
        return 'Settings';
      default:
        return 'Not found page';
    }
  }
}

// Your colors here, replace with actual color values if needed
const canvasColor = Color(0xFF03b97c);
const scaffoldBackgroundColor = Color(0xFF457B9D);
const accentCanvasColor = Color(0xFFA8DADC);
const actionColor = Color(0xFFF4A261);
const divider = Divider(color: Colors.white54, thickness: 1);
