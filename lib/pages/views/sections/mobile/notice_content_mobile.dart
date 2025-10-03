import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomague_nhs/pages/Auth_View/SignInMobileView.dart';
import 'package:salomague_nhs/TermsAndConditions/TAC_Mobile_View.dart';
import 'package:salomague_nhs/pages/views/sections/mobile/about_us_content_mobile.dart';
import 'package:salomague_nhs/pages/views/sections/mobile/footer_mobile.dart';
import 'package:salomague_nhs/launcher.dart';
import 'package:salomague_nhs/pages/views/sections/mobile/mobile_view.dart';
import 'package:salomague_nhs/widgets/hover_extensions.dart';

class NoticeContentMobile extends StatefulWidget {
  const NoticeContentMobile({super.key});

  @override
  State<NoticeContentMobile> createState() => _NoticeContentMobileState();
}

class _NoticeContentMobileState extends State<NoticeContentMobile>
    with TickerProviderStateMixin {
  Color _divider = Color(0xFF03b97c);

  final GlobalKey _footerKey = GlobalKey();
  late ScrollController _scrollController;
  Color _appBarColor = Color(0xFF03b97c);
  Color _textColor1 = Color(0xFF002f24);
  Color _textColor2 = Color(0xFF002f24);
  Color _textColor3 = Color(0xFF002f24);
  bool _showSignInCard = false;
  bool _TAC = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > 0) {
      setState(() {
        _appBarColor = const Color(0xFF03b97c);
      });
    } else {
      setState(() {
        _appBarColor = Color(0xFF03b97c);
      });
    }
  }

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void toggleTAC() {
    setState(() {
      _TAC = !_TAC;
    });
  }

  void closeTAC() {
    setState(() {
      _TAC = false;
    });
  }

  void toggleSignInCard() {
    setState(() {
      _showSignInCard = !_showSignInCard;
    });
  }

  void closeSignInCard() {
    setState(() {
      _showSignInCard = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: screenWidth / 10,
        elevation: 8,
        backgroundColor: _appBarColor,
        title: Container(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Launcher(scrollToFooter: false),
                    ),
                  );
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/LOGOFORSALOMAGUE.png",
                          height: screenWidth / 15,
                          width: screenWidth / 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "SNHS",
                      style: TextStyle(
                        color: Color(0xFF002f24),
                        fontFamily: "B",
                        fontSize: screenWidth / 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).showCursorOnHover,
              Spacer(),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Color(0xFF002f24)),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF002f24),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF03b97c),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/LOGOFORSALOMAGUE.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Launcher(scrollToFooter: false),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text(
                'About us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUsContentMobile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.white),
              title: Text(
                'Contact us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                scrollToSection(_footerKey);
              },
            ),
            ListTile(
              leading: Icon(Icons.login, color: Colors.white),
              title: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                toggleSignInCard();
              },
            ),
            ListTile(
              leading: Icon(Icons.school, color: Colors.white),
              title: Text(
                'Enroll Now',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                toggleTAC();
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  color: const Color.fromARGB(88, 173, 173, 173),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: screenWidth / 9,
                      left: screenWidth / 17,
                      right: screenWidth / 17,
                      bottom: screenWidth / 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 235, 235, 235),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage("assets/aboutuspic.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color(0x6565f058).withOpacity(
                                      0.5), // Blend color with opacity
                                ),
                              ),
                            ],
                          ),
                          width: screenWidth,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Color(0xFFA1f9D0)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Salomague National High School",
                                    style: TextStyle(
                                      fontFamily: "B",
                                      fontSize: 25,
                                      color: Color(0xFF002f24),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 2,
                                  color: _divider,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dear Student,",
                                      style: TextStyle(
                                          fontFamily: "R", fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 600, // max width
                                      child: Text(
                                        "Thank you for submitting your information. "
                                        "We are currently processing your enrollment details. "
                                        "Please allow some time for verification.",
                                        style: TextStyle(
                                            fontFamily: "R", fontSize: 16),
                                        softWrap: true, // ✅ enables wrapping
                                        overflow: TextOverflow
                                            .visible, // ✅ prevents cutting
                                        textAlign: TextAlign
                                            .justify, // ✅ looks like a paragraph
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 350,
                                  height: 400,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Important Notice",
                                          style: TextStyle(
                                            fontFamily: "B",
                                            fontSize: 25,
                                            color: Color(0xFF002f24),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Important Notice"
                                        "To validate your enrollment, please submit the following documents to the school within 15 days:\n\n"
                                        "- Birth Certificate\n"
                                        "- 2x2 Picture\n"
                                        "- Form 137 from previous school\n\n"
                                        "Failure to submit these documents within the specified timeframe will result in the rejection of your enrollment request.",
                                        style: TextStyle(
                                          fontFamily: "R",
                                          fontSize: 13,
                                          color: Color(0xFF002f24),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 350,
                                  height: 350,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Important Reminder",
                                          style: TextStyle(
                                            fontFamily: "B",
                                            fontSize: 25,
                                            color: Color(0xFF002f24),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Please check your email for your student account credentials (email and password). Once your account is activated, you may log in and select your preferred section. You can also view your enrollment status. You will receive another email once your enrollment application has been approved.",
                                        style: TextStyle(
                                          fontFamily: "R",
                                          fontSize: 13,
                                          color: Color(0xFF002f24),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MobileView()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios,
                                          size: 20, color: Color(0xFF002f24)),
                                      Text(
                                        'Go back to landpage',
                                        style: TextStyle(
                                          fontFamily: "R",
                                          fontSize: 13,
                                          color: Color(0xFF002f24),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                FooterMobile(
                  key: _footerKey,
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 550),
            child: _showSignInCard
                ? Stack(children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: closeSignInCard,
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: screenWidth / 1.2,
                                  height: screenHeight / 1.2,
                                  curve: Curves.easeInOut,
                                  child: SignInMobile(
                                    key: ValueKey('signInCard'),
                                    closeSignInCardCallback: closeSignInCard,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])
                : SizedBox.shrink(),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 550),
            child: _TAC
                ? Stack(children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: closeTAC,
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: screenWidth / 1.2,
                                  height: screenHeight / 1.2,
                                  curve: Curves.easeInOut,
                                  child: TacMobileView(
                                    key: ValueKey('closeTAC'),
                                    closeTAC: closeTAC,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
