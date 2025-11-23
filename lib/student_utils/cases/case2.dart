import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnrollmentStatusWidget extends StatefulWidget {
  final String? enrollmentStatus;
  final String? lrn; // renamed from studentId
  final String? fullName;
  final String? strand;
  final String? track;
  final String? sectionAdviser;
  final String? gradeLevel;
  final String? semester;
  final String? quarter;
  final List<String> sections;
  final List<Map<String, dynamic>> subjects;
  final bool isFinalized;
  final String? selectedSection;
  final VoidCallback? FinalizedData;
  final Function(String?)? onSectionChanged;
  final VoidCallback? onLoadSubjects;
  final VoidCallback? onFinalize;
  final VoidCallback? checkEnrollmentStatus;
  final String? educLevel;

  const EnrollmentStatusWidget({
    Key? key,
    required this.enrollmentStatus,
    required this.lrn, // required instead of studentId
    required this.fullName,
    required this.strand,
    required this.track,
    required this.gradeLevel,
    required this.sectionAdviser,
    required this.semester,
    required this.quarter,
    required this.sections,
    required this.subjects,
    required this.isFinalized,
    required this.selectedSection,
    this.onSectionChanged,
    this.onLoadSubjects,
    this.onFinalize,
    this.checkEnrollmentStatus,
    this.FinalizedData,
    required this.educLevel,
  }) : super(key: key);

  @override
  _EnrollmentStatusWidgetState createState() => _EnrollmentStatusWidgetState();
}

class _EnrollmentStatusWidgetState extends State<EnrollmentStatusWidget> {
  // Cached list of instructors from Firestore
  List<Map<String, dynamic>> _instructors = [];

  // Subjects with appended teacher_name (populated after matching)
  List<Map<String, dynamic>> _subjectsWithTeachers = [];

  // Loading state for fetching instructors/matching
  bool _loadingInstructors = false;

  @override
  void initState() {
    super.initState();
    _fetchInstructorsAndAttachTeachers();
  }

  Future<void> _fetchInstructorsAndAttachTeachers() async {
    setState(() {
      _loadingInstructors = true;
    });

    try {
      // Fetch instructors once and cache them
      QuerySnapshot instructorSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('accountType', isEqualTo: 'instructor')
          .get();

      _instructors = instructorSnapshot.docs.map((d) {
        final data = d.data() as Map<String, dynamic>;
        return {
          ...data,
          'docId': d.id,
        };
      }).toList();

      // Attach teacher names to the subjects provided in widget.subjects
      _attachTeacherNamesToSubjects();
    } catch (e) {
      _instructors = [];
      _subjectsWithTeachers =
          widget.subjects.map((s) => {...s, 'teacher_name': ''}).toList();
    } finally {
      if (mounted) {
        setState(() {
          _loadingInstructors = false;
        });
      }
    }
  }

  void _attachTeacherNamesToSubjects() {
    final List<Map<String, dynamic>> updated = [];

    for (final subject in widget.subjects) {
      final String subjNameRaw =
          (subject['subject_name'] ?? subject['subject_Name'] ?? '').toString();
      final String subjCodeRaw =
          (subject['subject_code'] ?? subject['subject_Code'] ?? '').toString();

      final String subjName = subjNameRaw.trim().toLowerCase();
      final String subjCode = subjCodeRaw.trim().toLowerCase();

      Map<String, dynamic>? matchedInstructor;

      if ((widget.educLevel ?? '').toLowerCase() == 'senior high school') {
        // Match both subject name and code for SHS
        matchedInstructor = _instructors.firstWhere(
          (ins) {
            final String insName =
                ((ins['subject_Name'] ?? ins['subject_name'] ?? '') as String)
                    .trim()
                    .toLowerCase();

            // Try several keys for code:
            String insCode1 =
                ((ins['subject_Code'] ?? '') as String).trim().toLowerCase();
            String insCode2 =
                ((ins['subject_code'] ?? '') as String).trim().toLowerCase();
            String insCode3 =
                ((ins['subjectCode'] ?? '') as String).trim().toLowerCase();

            final bool nameMatches = insName == subjName;
            final bool codeMatches = insCode1 == subjCode ||
                insCode2 == subjCode ||
                insCode3 == subjCode;

            return nameMatches && codeMatches;
          },
          orElse: () => <String, dynamic>{},
        );
        if ((matchedInstructor ?? {}).isEmpty) matchedInstructor = null;
      } else {
        // Junior High School: match by subject name only
        matchedInstructor = _instructors.firstWhere(
          (ins) {
            final String insName =
                ((ins['subject_Name'] ?? ins['subject_name'] ?? '') as String)
                    .trim()
                    .toLowerCase();
            return insName == subjName;
          },
          orElse: () => <String, dynamic>{},
        );
        if ((matchedInstructor ?? {}).isEmpty) matchedInstructor = null;
      }

      String teacherFullName = '';

      if (matchedInstructor != null) {
        final String first = (matchedInstructor['first_name'] ??
                matchedInstructor['firstName'] ??
                '')
            .toString()
            .trim();
        final String middle = (matchedInstructor['middle_name'] ??
                matchedInstructor['middleName'] ??
                '')
            .toString()
            .trim();
        final String last = (matchedInstructor['last_name'] ??
                matchedInstructor['lastName'] ??
                '')
            .toString()
            .trim();

        if (middle.isNotEmpty) {
          teacherFullName = '$first $middle $last'.trim();
        } else {
          teacherFullName = '$first $last'.trim();
        }
      }

      updated.add({
        ...subject,
        'teacher_name': teacherFullName,
      });
    }

    setState(() {
      _subjectsWithTeachers = updated;
    });
  }

  // Call this to refresh instructors + re-attach teachers (e.g., when Load Section pressed)
  Future<void> _refreshInstructorsAndSubjects() async {
    await _fetchInstructorsAndAttachTeachers();
  }

  // Helper small cell widget
  Widget _cellWidget(String text, {double? fontSize}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant EnrollmentStatusWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If subjects input changed from parent, re-attach teacher names
    if (oldWidget.subjects != widget.subjects) {
      _attachTeacherNamesToSubjects();
    }
    // If education level changed, re-attach
    if (oldWidget.educLevel != widget.educLevel) {
      _attachTeacherNamesToSubjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1200;

    final double padding = isMobile ? 10 : (isTablet ? 20 : 30);
    final double imageSize = isMobile
        ? screenWidth / 3
        : (isTablet ? screenWidth / 4 : screenWidth / 5);
    final double textFontSize = isMobile ? 14 : (isTablet ? 18 : 22);
    final double titleFontSize = isMobile ? 20 : (isTablet ? 20 : 24);

    return Container(
      width: double.infinity,
      color: const Color(0xFF002f24),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check Enrollment",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.enrollmentStatus == null)
                  Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('LOADING...'),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                  )
                else if (widget.enrollmentStatus == 'reEnrollSubmitted')
                  _buildReEnrollSubmittedContent(imageSize, textFontSize)
                else if (widget.enrollmentStatus == 'approved')
                  if (widget.isFinalized)
                    _buildFinalizedContent(context, textFontSize)
                  else
                    _buildApprovedContent(context, textFontSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReEnrollSubmittedContent(double imageSize, double textFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/LOGOFORSALOMAGUE.png',
            width: imageSize,
            height: imageSize,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: textFontSize, color: Colors.white),
            children: const [
              TextSpan(text: 'Your enrollment is '),
              TextSpan(
                  text: 'currently under review',
                  style: TextStyle(color: Colors.yellow)),
              TextSpan(
                text:
                    '. Please be patient as the admin processes your application.\n If you have any questions or need further assistance, feel free to reach out to the admin office.\n Thank you for your understanding!',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinalizedContent(BuildContext context, double textFontSize) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          // Fetch user doc where lrn equals widget.lrn
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('lrn', isEqualTo: widget.lrn)
              .limit(1)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              final userDoc = snapshot.data!.docs.first;
              final String docId = userDoc.id;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(docId)
                    .collection('sections')
                    .doc(docId)
                    .get(),
                builder: (context, snap2) {
                  if (snap2.hasData && snap2.data != null) {
                    final data = snap2.data!.data() as Map<String, dynamic>?;
                    if (data != null && data['finalizationTimestamp'] != null) {
                      final Timestamp timestamp =
                          data['finalizationTimestamp'] as Timestamp;
                      final DateTime dateTime = timestamp.toDate();
                      final String formattedDate =
                          DateFormat('MMMM dd, yyyy hh:mm a').format(dateTime);

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Finalized on: $formattedDate',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  }
                  return const SizedBox();
                },
              );
            }

            return const SizedBox();
          },
        ),
        _buildStudentDataRow('LRN no:', widget.lrn, textFontSize),
        _buildStudentDataRow(
            'Student Full Name:', widget.fullName, textFontSize),
        if ((widget.educLevel ?? '') == 'Senior High School') ...[
          _buildStudentDataRow('Strand:', widget.strand, textFontSize),
          _buildStudentDataRow('Track:', widget.track, textFontSize),
          _buildStudentDataRow('Semester:', widget.semester, textFontSize),
        ] else if ((widget.educLevel ?? '') == 'Junior High School') ...[
          _buildStudentDataRow('Quarter:', widget.quarter, textFontSize),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Section: ${widget.selectedSection}',
              style: TextStyle(
                color: Colors.black,
                fontSize: textFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Text(
                'Section Adviser: ${widget.sectionAdviser}',
                style: TextStyle(
                    fontSize: textFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        if ((widget.educLevel ?? '') == 'Senior High School')
          _buildSubjectsTable(_subjectsWithTeachers, textFontSize),
        if ((widget.educLevel ?? '') == 'Junior High School')
          _buildJHSSubjectsTable(_subjectsWithTeachers, textFontSize),
      ],
    );
  }

  Widget _buildApprovedContent(BuildContext context, double textFontSize) {
    return Column(
      children: [
        _buildStudentDataRow('LRN no:', widget.lrn, textFontSize),
        _buildStudentDataRow(
            'Student Full Name:', widget.fullName, textFontSize),
        if ((widget.educLevel ?? '') == 'Senior High School') ...[
          _buildStudentDataRow('Strand:', widget.strand, textFontSize),
          _buildStudentDataRow('Track:', widget.track, textFontSize),
          _buildStudentDataRow('Semester:', widget.semester, textFontSize),
        ],
        _buildStudentDataRow('Grade Level:', widget.gradeLevel, textFontSize),
        _buildSectionDropdown(),
        if (!widget.isFinalized)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () async {
                if (widget.onLoadSubjects != null) widget.onLoadSubjects!();
                await _refreshInstructorsAndSubjects();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF002f24),
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: const Size(80, 20),
              ),
              child: const Text('Load Section'),
            ),
          ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Text(
                'Section Adviser: ${widget.sectionAdviser}',
                style: TextStyle(
                    fontSize: textFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        if ((widget.educLevel ?? '') == 'Junior High School')
          _buildJHSSubjectsTable(_subjectsWithTeachers, textFontSize),
        if ((widget.educLevel ?? '') == 'Senior High School')
          _buildSubjectsTable(_subjectsWithTeachers, textFontSize),
        const SizedBox(height: 12),
        _buildFinalizeButton(),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStudentDataRow(
      String label, String? value, double textFontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: textFontSize),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? '',
              style: TextStyle(color: Colors.white, fontSize: textFontSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionDropdown() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: DropdownButton<String>(
          value: widget.selectedSection,
          hint: const Text('Select a section'),
          items: widget.sections.map((String section) {
            return DropdownMenuItem<String>(
              value: section,
              child: Text(section),
            );
          }).toList(),
          onChanged: widget.isFinalized ? null : widget.onSectionChanged,
        ),
      ),
    );
  }

  Widget _buildJHSSubjectsTable(
      List<Map<String, dynamic>> subjects, double textFontSize) {
    final List<Map<String, dynamic>> rows =
        subjects.isNotEmpty ? subjects : widget.subjects;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
        },
        children: [
          _buildJHSTableHeaderRow(),
          if (rows.isNotEmpty)
            ...rows.map((subject) {
              final String subjName =
                  (subject['subject_name'] ?? subject['subject_Name'] ?? '')
                      .toString();
              final String teacherName =
                  (subject['teacher_name'] ?? '').toString();
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(subjName,
                        style: const TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      teacherName.isNotEmpty ? teacherName : 'N/A',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            }).toList()
          else
            _buildJHSPlaceholderRow(),
        ],
      ),
    );
  }

  TableRow _buildJHSTableHeaderRow() {
    return const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Subject', style: TextStyle(color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Subject Teacher', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  TableRow _buildJHSPlaceholderRow() {
    return const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No subjects available',
              style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(),
        ),
      ],
    );
  }

  Widget _buildSubjectsTable(
      List<Map<String, dynamic>> subjects, double textFontSize) {
    final List<Map<String, dynamic>> rows =
        subjects.isNotEmpty ? subjects : widget.subjects;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
        },
        children: [
          _buildTableHeaderRow(),
          if (rows.isNotEmpty)
            ...rows.map((subject) {
              final String code =
                  (subject['subject_code'] ?? subject['subject_Code'] ?? '')
                      .toString();
              final String name =
                  (subject['subject_name'] ?? subject['subject_Name'] ?? '')
                      .toString();
              final String category = (subject['category'] ?? '').toString();
              final String teacherName =
                  (subject['teacher_name'] ?? '').toString();

              return TableRow(
                children: [
                  _cellWidget(code),
                  _cellWidget(name),
                  _cellWidget(category),
                  _cellWidget(teacherName.isNotEmpty ? teacherName : 'N/A'),
                ],
              );
            }).toList()
          else
            _buildPlaceholderRow(),
        ],
      ),
    );
  }

  TableRow _buildTableHeaderRow() {
    return const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Course Code', style: TextStyle(color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Subject', style: TextStyle(color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Category', style: TextStyle(color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Subject Teacher', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  TableRow _buildPlaceholderRow() {
    return const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'No subjects available',
            style: TextStyle(
              color: Colors.red,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(),
        SizedBox(),
        SizedBox(),
      ],
    );
  }

  Widget _buildFinalizeButton() {
    return ElevatedButton(
      onPressed: widget.isFinalized ? null : widget.onFinalize,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 1, 93, 168),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: const Size(80, 20),
      ),
      child: const Text('Finalize'),
    );
  }
}
