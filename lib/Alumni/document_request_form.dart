import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentRequestForm extends StatefulWidget {
  const DocumentRequestForm({super.key});

  @override
  State<DocumentRequestForm> createState() => _DocumentRequestFormState();
}

class _DocumentRequestFormState extends State<DocumentRequestForm> {
  final _formKey = GlobalKey<FormState>();

  // ===== Name Fields =====
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _middleNameFocusNode = FocusNode();
  final FocusNode _extensionNameFocusNode = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _extensionNameController = TextEditingController();

  // ===== Basic Info =====
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _contactFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // ===== Academic Info =====
  final FocusNode _studentIdFocusNode = FocusNode();
  final FocusNode _yearGradFocusNode = FocusNode();
  final FocusNode _courseFocusNode = FocusNode();
  final FocusNode _sectionFocusNode = FocusNode();

  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _yearGraduatedController = TextEditingController();
  final TextEditingController _courseProgramController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();

  // ===== Request Info =====
  final FocusNode _purposeFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _selectedDocument;

  // ===== Address Fields =====
  final FocusNode _houseNumberFocusNode = FocusNode();
  final FocusNode _streetNameFocusNode = FocusNode();
  final FocusNode _subdivisionFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _provinceFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _zipCodeFocusNode = FocusNode();

  final TextEditingController _houseNumber = TextEditingController();
  final TextEditingController _streetName = TextEditingController();
  final TextEditingController _subdivisionBarangay = TextEditingController();
  final TextEditingController _cityMunicipality = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  // ===== Submit Function =====
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('document_requesting').add({
        'last_name': _lastNameController.text.trim(),
        'first_name': _firstNameController.text.trim(),
        'middle_name': _middleNameController.text.trim(),
        'extension_name': _extensionNameController.text.trim(),
        'age': _ageController.text.trim(),
        'email': _emailController.text.trim(),
        'contact_number': _contactController.text.trim(),
        'date_of_birth': _dobController.text.trim(),
        'house_number': _houseNumber.text.trim(),
        'street_name': _streetName.text.trim(),
        'subdivision_barangay': _subdivisionBarangay.text.trim(),
        'city_municipality': _cityMunicipality.text.trim(),
        'province': _province.text.trim(),
        'country': _country.text.trim(),
        'zip_code': _zipCodeController.text.trim(),
        'lrn_number': _studentIdController.text.trim(),
        'year_graduated': _yearGraduatedController.text.trim(),
        'course_program': _courseProgramController.text.trim(),
        'section': _sectionController.text.trim(),
        'requested_document': _selectedDocument ?? '',
        'purpose': _purposeController.text.trim(),
        'notes': _notesController.text.trim(),
        'submitted_at': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your request has been submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting request: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    for (var controller in [
      _firstNameController,
      _middleNameController,
      _lastNameController,
      _extensionNameController,
      _ageController,
      _emailController,
      _contactController,
      _dobController,
      _studentIdController,
      _yearGraduatedController,
      _courseProgramController,
      _sectionController,
      _purposeController,
      _notesController,
      _houseNumber,
      _streetName,
      _subdivisionBarangay,
      _cityMunicipality,
      _province,
      _country,
      _zipCodeController,
    ]) {
      controller.clear();
    }
    setState(() => _selectedDocument = null);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth =
        screenWidth >= 1200 ? 300 : screenWidth >= 800 ? 250 : screenWidth * 0.8;
    double spacing = screenWidth >= 800 ? 16.0 : 8.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 60,
              horizontal: MediaQuery.of(context).size.width / 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Alumni Document Request',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildNameFields(fieldWidth, spacing),
                const SizedBox(height: 20),
                _buildContactFields(fieldWidth, spacing),
                const SizedBox(height: 20),
                _buildAddressFields(fieldWidth, spacing),
                const SizedBox(height: 20),
                _buildAcademicFields(fieldWidth, spacing),
                const SizedBox(height: 20),
                _buildRequestFields(fieldWidth, spacing),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.send),
                    label: const Text("Submit Request"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF03b97c),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============== BUILD SECTIONS (same as yours) ==============
  Widget _buildNameFields(double width, double spacing) => Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _buildField(_lastNameController, _lastNameFocusNode, "Last Name", width, true),
          _buildField(_firstNameController, _firstNameFocusNode, "First Name", width, true),
          _buildField(_middleNameController, _middleNameFocusNode, "Middle Name", width, false, optional: true),
          _buildField(_extensionNameController, _extensionNameFocusNode, "Extension Name", width, false, optional: true),
        ],
      );

  Widget _buildContactFields(double width, double spacing) => Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _buildField(_ageController, _ageFocusNode, "Age", width, true, inputType: TextInputType.number),
          _buildField(_emailController, _emailFocusNode, "Email Address", width, true, inputType: TextInputType.emailAddress),
          _buildField(_contactController, _contactFocusNode, "Contact Number", width, true, inputType: TextInputType.phone),
          _buildField(_dobController, _dobFocusNode, "Date of Birth (YYYY-MM-DD)", width, false, optional: true),
        ],
      );

  Widget _buildAcademicFields(double width, double spacing) => Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _buildField(_studentIdController, _studentIdFocusNode, "LRN Number (if known)", width, false, optional: true),
          _buildField(_yearGraduatedController, _yearGradFocusNode, "Year Graduated / Last Attended", width, true),
          _buildField(_courseProgramController, _courseFocusNode, "Course / Program / Track", width, true),
          _buildField(_sectionController, _sectionFocusNode, "Section / Adviser (if known)", width, false, optional: true),
        ],
      );

  Widget _buildRequestFields(double width, double spacing) => Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          Container(
            width: width,
            child: DropdownButtonFormField<String>(
              value: _selectedDocument,
              decoration: _dropdownDecoration("Requested Document(s)"),
              validator: (value) =>
                  value == null ? 'Please select a document.' : null,
              items: const [
                DropdownMenuItem(value: "Diploma", child: Text("Diploma")),
                DropdownMenuItem(
                    value: "SF10 / Academic Record",
                    child: Text("SF10 / Academic Record")),
                DropdownMenuItem(
                    value: "Certificate of Good Moral",
                    child: Text("Certificate of Good Moral")),
              ],
              onChanged: (value) => setState(() => _selectedDocument = value),
            ),
          ),
          _buildField(_purposeController, _purposeFocusNode, "Purpose of Request", width, true),
          _buildField(_notesController, _notesFocusNode, "Additional Notes / Remarks", width * 2, false, optional: true, maxLines: 3),
        ],
      );

  Widget _buildAddressFields(double width, double spacing) => Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _buildField(_houseNumber, _houseNumberFocusNode, "House / No", width, false, optional: true),
          _buildField(_streetName, _streetNameFocusNode, "Street Name", width, true),
          _buildField(_subdivisionBarangay, _subdivisionFocusNode, "Subdivision / Barangay", width, true),
          _buildField(_cityMunicipality, _cityFocusNode, "City / Municipality", width, true),
          _buildField(_province, _provinceFocusNode, "Province", width, true),
          _buildField(_country, _countryFocusNode, "Country", width, true),
          _buildField(_zipCodeController, _zipCodeFocusNode, "Zip Code", width, true, inputType: TextInputType.number),
        ],
      );

  // ============== TEXT FIELD BUILDER ==============
  Widget _buildField(TextEditingController controller, FocusNode focusNode,
      String label, double width, bool required,
      {bool optional = false,
      TextInputType inputType = TextInputType.text,
      int maxLines = 1}) {
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: inputType,
        maxLines: maxLines,
        validator: (value) {
          if (required && (value == null || value.trim().isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              children: [
                if (required)
                  const TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                if (optional)
                  const TextSpan(text: ' (optional)', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Color(0xFF03b97c))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Color(0xFF03b97c))),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      label: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
          children: const [
            TextSpan(text: '*', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color(0xFF03b97c))),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color(0xFF03b97c))),
    );
  }
}
