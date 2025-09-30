import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissionAndVisionMobile extends StatelessWidget {
  const MissionAndVisionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF002f24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "SALOMAGUE NATIONAL HIGH SCHOOL",
                      style: TextStyle(
                        fontFamily: "R",
                        fontSize: screenWidth / 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: screenWidth / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage("assets/snhsprincipal.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bernardo A. Frialde, EdD",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 30, 54),
                                        fontFamily: "B",
                                        fontSize: screenWidth / 60,
                                        backgroundColor: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      "Principal IV",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 30, 54),
                                        fontFamily: "R",
                                        fontSize: screenWidth / 65,
                                        fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: screenWidth / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage("assets/pholder.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Aurora L. Bravo",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 30, 54),
                                        fontFamily: "B",
                                        fontSize: screenWidth / 60,
                                        backgroundColor: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      "Master Teacher 1",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 30, 54),
                                        fontFamily: "R",
                                        fontSize: screenWidth / 65,
                                        fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: screenWidth / 2.5,
                  child: Column(
                    children: [
                      Center(
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color.fromARGB(255, 216, 194, 0),
                          size: screenWidth / 10,
                        ),
                      ),
                      Text(
                        "SNHS VISION",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "B",
                          fontSize: screenWidth / 25,
                        ),
                      ),
                      SizedBox(height: screenWidth / 30),
                      Text(
                        """We dream of Filipinos
who passionately love their country
and whose values and competencies
enable them to realize their full potential
and contribute meaningfully to building the nation.

As a learner-centered public institution,
the Department of Education
continuously improves itself
to better serve its stakeholders.
""",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "M",
                          fontSize: screenWidth / 40,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,)
          ,                  Container(
                  width: screenWidth / 2.5,
                  child: Column(
                    children: [
                      Center(
                        child: Icon(
                          Icons.school,
                          color: Color.fromARGB(255, 216, 194, 0),
                          size: screenWidth / 10,
                        ),
                      ),
                      Text(
                        "SNHS MISSION",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "B",
                          fontSize: screenWidth / 25,
                        ),
                      ),
                      SizedBox(height: screenWidth / 30),
                      Text(
                        """To protect and promote the right of every Filipino to quality, equitable, culture-based, and complete basic education where: 

Students learn in a child-friendly, gender-sensitive, safe, and motivating environment.
Teachers facilitate learning and constantly nurture every learner.
Administrators and staff, as stewards of the institution, ensure an enabling and supportive environment for effective learning to happen.
Family, community and other stakeholders are actively engaged
and share responsibility for developing life-long learners.""",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "M",
                          fontSize: screenWidth / 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
