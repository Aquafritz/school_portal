import 'package:flutter/material.dart';

class MissionAndVisionMobile extends StatelessWidget {
  const MissionAndVisionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget buildProfileItem() {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/snhsprincipal.jpg",
              height: screenWidth / 2.8,
              width: screenWidth / 2.8,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Bernardo A. Frialde, EdD",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 30, 54),
              fontFamily: "B",
              fontSize: screenWidth / 26,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Principal IV",
            style: TextStyle(
              color: const Color.fromARGB(255, 50, 50, 50),
              fontFamily: "R",
              fontSize: screenWidth / 34,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Top Section ---
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF002f24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Text(
                  "SALOMAGUE NATIONAL HIGH SCHOOL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "B",
                    fontSize: screenWidth / 18,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 18),

                // Top main image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/snhsprincipal.jpg",
                    height: screenWidth / 2.3,
                    width: screenWidth / 2.3,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Bernardo A. Frialde, EdD",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "B",
                    fontSize: screenWidth / 26,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Principal IV",
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: "R",
                    fontSize: screenWidth / 32,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 20),

                // Four smaller images
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(4, (_) => buildProfileItem()),
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // --- Vision and Mission Section ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vision Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: const Color.fromARGB(255, 216, 194, 0),
                        size: screenWidth / 9,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "SNHS VISION",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "B",
                          fontSize: screenWidth / 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        """We dream of Filipinos who passionately love their country and whose values and competencies enable them to realize their full potential and contribute meaningfully to building the nation.

As a learner-centered public institution, the Department of Education continuously improves itself to better serve its stakeholders.""",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "M",
                          fontSize: screenWidth / 28,
                          height: 1.6,
                          wordSpacing: 0.6,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Mission Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.school,
                        color: const Color.fromARGB(255, 216, 194, 0),
                        size: screenWidth / 9,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "SNHS MISSION",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "B",
                          fontSize: screenWidth / 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        """To protect and promote the right of every Filipino to quality, equitable, culture-based, and complete basic education where:

Students learn in a child-friendly, gender-sensitive, safe, and motivating environment.
Teachers facilitate learning and constantly nurture every learner.
Administrators and staff ensure an enabling and supportive environment for effective learning.
Family, community and stakeholders are actively engaged and share responsibility for developing lifelong learners.""",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 30, 54),
                          fontFamily: "M",
                          fontSize: screenWidth / 28,
                          height: 1.6,
                          wordSpacing: 0.6,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
