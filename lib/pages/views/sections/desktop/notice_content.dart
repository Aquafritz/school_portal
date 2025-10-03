import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomague_nhs/pages/views/sections/desktop/desktop_view.dart';
import 'package:salomague_nhs/widgets/hover_extensions.dart';

class NoticeContent extends StatefulWidget {
  final bool scrollToFooter; // or final VoidCallback if it's a function

  const NoticeContent({super.key, this.scrollToFooter = false});

  @override
  State<NoticeContent> createState() => _NoticeContentState();
}

class _NoticeContentState extends State<NoticeContent> {
  @override
  Widget build(BuildContext context) {
    Color _divider = Color(0xFF03b97c);

    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(88, 173, 173, 173),
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width / 9,
          left: MediaQuery.of(context).size.width / 17,
          right: MediaQuery.of(context).size.width / 17,
          bottom: MediaQuery.of(context).size.width / 20,
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
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
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
                      image: DecorationImage(
                        image: AssetImage("assets/aboutuspic.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Color(0x6565f058)
                          .withOpacity(0.3), // Blend color with opacity
                    ),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xFFA1f9D0)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
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
                      height: 30,
                    ),
                    Divider(
                      thickness: 2,
                      color: _divider,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dear Student,",
                          style: TextStyle(fontFamily: "R", fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 600,
                          child: Text(
                            "      Thank you for submitting your information. We are currently processing your enrollment details. Please allow some time for verification.",
                            style: TextStyle(fontFamily: "R", fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: 900,
                        height: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 350,
                              height: 350,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 350,
                              height: 350,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        "Please check your email for your student account credentials (email and password). Once your account is activated, you may log in and select your preferred section. You can also view your enrollment status. You will receive another email once your enrollment application has been approved.",
                                        style: TextStyle(
                                          fontFamily: "R",
                                          fontSize: 13,
                                          color: Color(0xFF002f24),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Color(0xFF002f24),
                            ),
                            Text(
                              "Go back",
                              style: TextStyle(
                                fontFamily: "R",
                                fontSize: 20,
                                color: Color(0xFF002f24),
                              ),
                            )
                          ],
                        ),
                      ).showCursorOnHover.moveUpOnHover,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
