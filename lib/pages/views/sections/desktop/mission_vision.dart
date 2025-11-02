import 'package:flutter/material.dart';

class MissionAndVision extends StatefulWidget {
  const MissionAndVision({super.key});

  @override
  State<MissionAndVision> createState() => _MissionAndVisionState();
}

class _MissionAndVisionState extends State<MissionAndVision>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimation;
  late Animation<double> _fadeIn;
  late Animation<double> _slideUp;

  @override
  void initState() {
    super.initState();
    _mainAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _mainAnimation, curve: Curves.easeIn),
    );
    _slideUp = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _mainAnimation, curve: Curves.easeOut),
    );

    _mainAnimation.forward();
  }

  @override
  void dispose() {
    _mainAnimation.dispose();
    super.dispose();
  }

  Widget buildProfileItem(double screenWidth) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/snhsprincipal.jpg",
            height: screenWidth / 8,
            width: screenWidth / 8,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Bernardo A. Frialde, EdD",
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 30, 54),
            fontFamily: "B",
            fontSize: screenWidth / 68,
          ),
        ),
        Text(
          "Principal IV",
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 30, 54),
            fontFamily: "R",
            fontSize: screenWidth / 95,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FadeTransition(
      opacity: _fadeIn,
      child: Transform.translate(
        offset: Offset(0, _slideUp.value),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- Top section: 5 images with labels ---
                Column(
                  children: [
                    // 1 image on top
                    Center(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/snhsprincipal.jpg",
                              height: screenWidth / 6,
                              width: screenWidth / 6,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Bernardo A. Frialde, EdD",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 30, 54),
                              fontFamily: "B",
                              fontSize: screenWidth / 68,
                            ),
                          ),
                          Text(
                            "Principal IV",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 30, 54),
                              fontFamily: "R",
                              fontSize: screenWidth / 95,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 4 images below with same labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: buildProfileItem(screenWidth),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // --- DepEd Vision ---
                Column(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0xFFD8C200),
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "DepEd VISION",
                      style: TextStyle(
                        color: const Color(0xFF002F24),
                        fontFamily: "B",
                        fontSize: screenWidth / 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      """We dream of Filipinos who passionately love their country
and whose values and competencies enable them to realize their full potential
and contribute meaningfully to building the nation.

As a learner-centered public institution,
the Department of Education continuously improves itself
to better serve its stakeholders.""",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF002F24),
                        fontFamily: "M",
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // --- DepEd Mission ---
                Column(
                  children: [
                    const Icon(
                      Icons.school,
                      color: Color(0xFFD8C200),
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "DepEd MISSION",
                      style: TextStyle(
                        color: const Color(0xFF002F24),
                        fontFamily: "B",
                        fontSize: screenWidth / 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      """To protect and promote the right of every Filipino to quality, equitable, culture-based, and complete basic education where: 

Students learn in a child-friendly, gender-sensitive, safe, and motivating environment.
Teachers facilitate learning and constantly nurture every learner.
Administrators and staff ensure an enabling and supportive environment for effective learning.
Families, communities, and stakeholders are actively engaged and share responsibility for developing lifelong learners.""",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color(0xFF002F24),
                        fontFamily: "M",
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
