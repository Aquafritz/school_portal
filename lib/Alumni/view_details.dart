import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewDetailsDocumentRequest extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> requestData;

  const ViewDetailsDocumentRequest({
    super.key,
    required this.documentId,
    required this.requestData,
  });

  @override
  State<ViewDetailsDocumentRequest> createState() => _ViewDetailsDocumentRequestState();
}

class _ViewDetailsDocumentRequestState extends State<ViewDetailsDocumentRequest> {
  bool _hovering = false;
  bool _sending = false;

  // Your EmailJS credentials
  final String serviceID = 'service_kfizh1v';
  final String templateID = 'template_soodcuo'; // Only one free template used
  final String publicKey = '2HiRU5IwmZo2v29UE';

  Future<void> sendPickupEmail() async {
    final recipientEmail = widget.requestData['email'];

    if (recipientEmail == null || recipientEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This request has no email address.")),
      );
      return;
    }

    setState(() => _sending = true);

    try {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceID,
          'template_id': templateID,
          'user_id': publicKey,
          'template_params': {
            'to_email': recipientEmail,
            'first_name': widget.requestData['first_name'],
            'last_name': widget.requestData['last_name'],
            'requested_document': widget.requestData['requested_document'],
            'purpose': widget.requestData['purpose'],
            'status': 'Ready for Pick-Up',
          }
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pick-up email sent successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send email: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending email: $e")),
      );
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0, right: 30),
            child: Row(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('ADMIN',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("Salomague_Admin@gmail.com",
                            style: TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // ======= Breadcrumb =======
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Document Request Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => _hovering = true),
                      onExit: (_) => setState(() => _hovering = false),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Document Requests',
                          style: TextStyle(
                            color: _hovering ? Colors.blue : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const Text(' / ',
                        style: TextStyle(color: Colors.black54, fontSize: 16)),
                    const Text('View Details',
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),

          // ======= Main Content =======
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // ===== Left Card: Request Details =====
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:ListView(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  children: [
    Text("Alumni Information",
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold)),
    const SizedBox(height: 20),

    // ====== Personal Info ======
    _buildDetail("First Name", widget.requestData['first_name']),
    _buildDetail("Middle Name", widget.requestData['middle_name']),
    _buildDetail("Last Name", widget.requestData['last_name']),
    _buildDetail("Extension Name", widget.requestData['extension_name']),
    _buildDetail("Age", widget.requestData['age']),
    _buildDetail("Date of Birth", widget.requestData['date_of_birth']),
    _buildDetail("Email", widget.requestData['email']),
    _buildDetail("Contact Number", widget.requestData['contact_number']),
    const Divider(height: 30, color: Colors.grey),

    // ====== Address Info ======
    _buildDetail("House Number", widget.requestData['house_number']),
    _buildDetail("Street Name", widget.requestData['street_name']),
    _buildDetail("Subdivision / Barangay", widget.requestData['subdivision_barangay']),
    _buildDetail("City / Municipality", widget.requestData['city_municipality']),
    _buildDetail("Province", widget.requestData['province']),
    _buildDetail("Country", widget.requestData['country']),
    _buildDetail("Zip Code", widget.requestData['zip_code']),
    const Divider(height: 30, color: Colors.grey),

    // ====== Academic Info ======
    _buildDetail("LRN Number", widget.requestData['lrn_number']),
    _buildDetail("Course / Program", widget.requestData['course_program']),
    _buildDetail("Section / Adviser", widget.requestData['section']),
    _buildDetail("Year Graduated", widget.requestData['year_graduated']),
    const Divider(height: 30, color: Colors.grey),

    // ====== Request Info ======
    _buildDetail("Requested Document", widget.requestData['requested_document']),
    _buildDetail("Purpose", widget.requestData['purpose']),
    _buildDetail("Notes", widget.requestData['notes']),
    const Divider(height: 30, color: Colors.grey),

    // ====== Submission ======
    _buildDetail(
      "Submitted At",
      widget.requestData['submitted_at'] != null
          ? widget.requestData['submitted_at'].toDate().toString()
          : "—",
    ),
  ],
)

                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // ===== Right Card: Send Email =====
                  // ===== Right Card: Send Email =====
Expanded(
  child: Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: const [
              Icon(Icons.mark_email_read_outlined,
                  color: Color(0xFF03b97c), size: 28),
              SizedBox(width: 10),
              Text(
                "Send Pick-Up Notification",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Recipient Info Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFe6f8f1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF03b97c), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recipient:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16)),
                Text(widget.requestData['email'] ?? "No Email",
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 10),
                Text("Alumni Name:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16)),
                Text(
                    "${widget.requestData['first_name']} ${widget.requestData['last_name']}",
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 10),
                Text("Document:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16)),
                Text(widget.requestData['requested_document'] ?? "",
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black87)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Message Preview Text
          Text(
            "You are about to send a pick-up notice to this alumni. "
            "They will receive an email stating that their requested document "
            "is ready for collection at the Registrar’s Office.",
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),

          const Spacer(),

          // Send Button
          if (_sending)
            const Center(
                child: CircularProgressIndicator(color: Color(0xFF03b97c)))
          else
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send_rounded),
                label: const Text("Send Pick-Up Notice"),
                onPressed: sendPickupEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03b97c),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 30),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
        ],
      ),
    ),
  ),
),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

 Widget _buildDetail(String label, dynamic value) {
  final displayValue =
      value != null && value.toString().isNotEmpty ? value.toString() : "—";

  // For long text fields like Purpose & Notes
  if (label == "Purpose" || label == "Notes") {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              displayValue,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  // Default layout for all other fields
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 160,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        Expanded(
            child: Text(
          displayValue,
          style: const TextStyle(fontSize: 15),
        )),
      ],
    ),
  );
}
}
