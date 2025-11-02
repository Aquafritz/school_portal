import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUsContent extends StatefulWidget {
  const AboutUsContent({super.key});

  @override
  State<AboutUsContent> createState() => _AboutUsContentState();
}

class _AboutUsContentState extends State<AboutUsContent> {
  @override
  Widget build(BuildContext context) {
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
              height: 400,
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
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Salomague National High School",
                      style: TextStyle(
                          fontFamily: "B",
                          fontSize: 30,
                          color: Color(0xFF03b97c)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    """In consonance with the policy of the government to make possible equal opportunities for high school education for all the children of the people of the Philippines regardless of the place of birth or of economic condition of the parents provided by Republic Act 6054, the Salomague Village High School was opened in the School Year 1967–1968.

It was through the initiative of Ms. Natalia Valencerrina, assistant principal of Salomague Village High School and in coordination with the Barangay Officials and the father of Barangay high School, Dr. Pedro Orata, that the school was organized following the requirements as per Memorandum No. 14 s. 1969 of Memo No. 866, 1968 of the Bureau of Public Schools dated April, 1968.

Mrs. Rolinda Edrain, Principal of the Mother High School, the Pangasinan National High School with the able leadership of Mayor Corleto R. Castro of Bugallon, Pangasinan and Mr. Eduardo Edrain, incumbent Schools Division Superintendent then favorably endorsed and recommended the establishment of the Salomague Barangay High School.

In the year 1968, the first enrollment for the first year was only 65. Mrs. Linda Yuson was the first full time teacher and adviser of the class. The starting rate of tuition was only ₱85.00 per student, which was also the main source of income of the school. Part-time teachers, who were qualified, came from the Elementary teaching Force and were hired on honorarium basis.

From the year 1971–1972, Mrs. Maria P. Orduña, the assistant principal of Salomague Barangay High School requested for full-time teachers because there was an increase number of students. The teachers were Ms. Emerita Abalos, Ms. Delia S. Raga, Mrs. Clarita D. Cruz and Mr. Ernesto V. Lopez.

For almost 25 years since the birth of the school, the school held its classes in the Elementary School site and classroom buildings were also used. Makeshifts were made and utilized as classrooms by the students.

Tangible accomplishments were manifested in the form of construction of concrete plant boxes: beautification of the school grounds, renovation of the school nursery, YCAP projects, health and sanitation projects were implemented in the school and community. Office supplies were also provided. These were done from 1976–1979.

Under the staff development, from 1977–1978, significant accomplishments were the continuing program and training of school personnel to enhance teaching competencies and promote effectiveness and adaptability. Through the administration and supervision of Mrs. Maria P. Orduña, these accomplishments were successfully achieved.

In the year 1975, a meeting was called presided by the principal, Mrs. Maria P. Orduña, with the presence of Barangay Officials headed by Barangay Captain Alfredo Maza and the PTA officials. Their agenda were to propose for the increase salaries of teachers to cope up with high standard of living and to implement the Presidential Decree and Letter of Instruction issued by former President Ferdinand Marcos.

With the aforementioned agenda, the proposal was approved and that Salomague High School became a Salomague National High School.

Under the administration of Mrs. Emerita A. Lomibao, the school was fortunate for owning a portion of a lot because through her initiative, the lot (3,017 sq.m.) was purchased from Mr. and Mrs. Alfredo Maza and the money being used to purchase the lot came from the CD Fund of the former Mayor of Lingayen, Atty. Chris Mendoza. During her term more buildings were built particularly the construction of the JICA (Japan Instructional Cooperating Agency), a 2-storey building worth ₱6,126,622.58 and all buildings were also repaired. Aside from these, the school received more items for teachers from 1992–1999 and some of them were Brunei grantees.

However, despite her notable accomplishments, she wasn’t able to reach her age of retirement because she left the school due to her terminal ailment. From here, Mrs. Dedication V. Manaois, her best friend happened to be the principal for less than a year. Having stayed in school for a short period of time, she never wasted her time instead she made an effort to re-class some teachers from Teacher I to Teacher III.

From 2004–2014, Mrs. Elsie A. Cunanan ruled the school for being the school head. She made a lot of accomplishments such as the construction of the classroom building, PTA building used as a library, Congressman PDAF building, repair and renovation of the ceiling destroyed by Typhoon Cosme and other physical facilities of the school. In 2012, water/sanitation and comfort rooms were built and construction of the multi-purpose gym (phase 1–3) and both were completed in 2013. To augment the professional status of the teachers, she was able to re-class and promote some teachers for T-III positions.

Indeed, the Salomague National High School is truly blessed with principals whose characters and deeds are worth emulating. The present administration is led by Mrs. Myrna D. Orate whose principle in life is to make the school a better place for students to stay. She has been the school principal for 4 years having a lot of remarkable accomplishments such as renovation of the school’s gate, construction of pre-fabricated 2-storey building, construction of the perimeter fence, making of the school’s drainage, plastering and painting of the entire fence, building of the school canteen, purchased of the school facilities/supplies and others needed by the students particularly Grade II.

Under her supervision and administration, the SNHS is making its name for having disciplined students and model teachers. Being the leader, the school received various awards like Champion in the First Street Dancing Competition, Bugallon Fiesta (2015), 1st Runner-Up in the Cheer Dance, Bugallon Day (2017) and a recipient of ₱500,000.00 (worth of project) as a prize for completing the requirements in the Urban Art Gardening Project of the LGU spearheaded by Hon. Jumel Anthony I. Espino, Municipal Mayor of Bugallon.

Pondering the economic and professional status of the teachers, she then promoted and re-classed almost all of the teachers from T-I to T-III, Master Teacher and Head Teacher positions.

Truly, the principal is a leader with passion and dedication to her service because she never wasted her time serving and making a difference which every member of SNHS Family can be proud of.

Aside from augmenting the salary and position of the teachers to cope up with the current standard of living, the principal also considers the welfare of the students. That’s why she never ceases to improve the school campus in order to provide the students a home for peace and security—an institution conducive for learning.

To name a few, the renovation that includes the tiling and signage of the main gate, building faculty room for Junior High School Teachers and providing TV sets and industrial fans in almost all the classrooms. It’s really fun and satisfying to stay in the school due to the ambiance brought about by the landscape of office façade towards the main gate, landscape East side of the Gym and the murals of the walls painted and created by one of her artistic teachers. Likewise, students will never be bored during their vacant time because they are provided with study shed and garden seats where they can bond/mingle with one another and also beneficial for them to do their assignments and activities. In this way, doing the latter will enable the students to develop camaraderie and selfless attitude.

Thus, the aforementioned achievements and accomplishments of the past and present administrations are genuine marks of serving the students and community with integrity and commitment.
""",
                    style: TextStyle(fontFamily: "R", fontSize: 18),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "With full support from the government and the community, BETTER DAYS ARE YET TO COME, MORE ACCOMPLISHMENTS ARE YET TO BE ADDED TO SNHS GLORIES!!!",
                    style: TextStyle(fontFamily: "M", fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.school,
                                color: Color(0xFF002f24),
                                size: 70,
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Our Graduates",
                                      style: TextStyle(
                                        fontFamily: "B",
                                        fontSize: 17,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                    Text(
                                      "Join our community of successful graduates and unlock your potential.",
                                      style: TextStyle(
                                        fontFamily: "R",
                                        fontSize: 14,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_sharp,
                                color: Color(0xFF002f24),
                                size: 70,
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Flexible Schedules",
                                      style: TextStyle(
                                        fontFamily: "B",
                                        fontSize: 17,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                    Text(
                                      "Choose the schedule that fits your lifestyle and achieve your academic.",
                                      style: TextStyle(
                                        fontFamily: "R",
                                        fontSize: 14,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.groups_2,
                                color: Color(0xFF002f24),
                                size: 70,
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dedicated Staff",
                                      style: TextStyle(
                                        fontFamily: "B",
                                        fontSize: 17,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                    Text(
                                      "Join our community of successful graduates and unlock your potential.",
                                      style: TextStyle(
                                        fontFamily: "R",
                                        fontSize: 14,
                                        color: Color(0xFF002f24),
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
                    SizedBox(
                      height: 50,
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Reviews and Testimonials",
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Card 1
                          Container(
                            width: 350,
                            height: 350,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.format_quote_rounded,
                                  color: Color(0xFF002f24),
                                  size: 50,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      """I am deeply honored to be an alumni of Salomague National High School, (Batch 2004). The 4 years I spent in SNHS from year 2000-2004 were truly transformative and diversified. SNHS with all the purpose-driven teachers and staff provided me with strong foundation and solid ground on the development of my principles and values that have shaped me the person I am now. More than the best education that SNHS provided me, my heart is filled with gratitude for the lessons learned, the kindness shared, the friendship and great opportunities entrusted to me. I am beyond words to express my gratitude to everyone who contributed in my success. Come what may, always, I am a proud product of Salomague National High School.""",
                                      style: TextStyle(
                                        fontFamily: "R",
                                        fontSize: 13,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "— Jasmin Gabriel-Galban (Batch 2000-2004)",
                                  style: TextStyle(
                                    fontFamily: "B",
                                    fontSize: 15,
                                    color: Color(0xFF002f24),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Card 2
                          Container(
                            width: 350,
                            height: 350,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.format_quote_rounded,
                                  color: Color(0xFF002f24),
                                  size: 50,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      """I chose Salomague National High School because of its strong academic reputation. Teachers were highly competent and approachable,  and so students seemed genuinely happy. The supportive environment made a big difference during my high school years. It was also close to our home and offered quality education, so it was the  perfect balance of convenience and excellence. Being able to focus more on my studies rather than long travel. I appreciated the Salomague National High School, emphasized discipline, respect and integrity. Those values shaped me into a more responsible and focused person, not just academically but in life as well.""",
                                      style: TextStyle(
                                        fontFamily: "R",
                                        fontSize: 13,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "— Annariza Rafon Guerri (1992-1996)",
                                  style: TextStyle(
                                    fontFamily: "B",
                                    fontSize: 15,
                                    color: Color(0xFF002f24),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Card 3
                          Container(
                            width: 350,
                            height: 350,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.format_quote_rounded,
                                  color: Color(0xFF002f24),
                                  size: 50,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      """SNHS molded me to become a better, bolder, fiercer and stronger as an individual always ready to conquer the world. Teachers in SNHS are truly capable and made a difference in my life they inpires me a lot and tought me how to face challenges in life in order to be successful in the corporate world not just to be book smart but also street smart and have perseverance in reaching my goals in life. Furthermore, I consider SNHS as my second home and family until now that i always look back to them because without them i am nothing, i owe them a lot. My success is also their's also to claim. And wherever i go i will bring every aspects of learnings and with optimsm and pride to see silver linings in every situation i may be in. As a SNHSer i am and will always be thankful and proud be one...one who will always make a difference that will always make my SNHS family proud of.
Marvin Antigua dela Cruz Batch 2001 na muling magsasabing...
"Kung ipinangak kang mahirap hindi mo kasalanan yan, pero kung mamatay ka na naghihirap at hikahos padin ay kasalanan mo na yan dahil God gave you all the chances and give yourself a shot to become who you chooses yourself to be one.”
""",
                                      style: TextStyle(
                                        fontFamily: "R",
                                        fontSize: 13,
                                        color: Color(0xFF002f24),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "— Marvin Antgua Dela Cruz (Batch 1997-2001)",
                                  style: TextStyle(
                                    fontFamily: "B",
                                    fontSize: 15,
                                    color: Color(0xFF002f24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
