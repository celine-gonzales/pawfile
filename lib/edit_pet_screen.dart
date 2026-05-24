import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'pet_model.dart';

class EditPetScreen extends StatefulWidget {
  final Pet pet;

  const EditPetScreen({super.key, required this.pet});

  @override
  State<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late TextEditingController _colorController;
  late TextEditingController _birthdayController;
  late TextEditingController _weightController;
  late TextEditingController _vetNameController;
  late TextEditingController _vetClinicController;
  late TextEditingController _vaccinationsController;
  late TextEditingController _medicalNotesController;
  late TextEditingController _favToyController;
  late TextEditingController _favTreatController;
  late TextEditingController _notesController;
  late TextEditingController _ownerNameController;
  late TextEditingController _contactController;
  late TextEditingController _addressController;

  String? _selectedGender;
  String? _selectedType;
  File? _petImage;

  final List<String> _petTypes = ['Dog', 'Cat', 'Fish', 'Bird', 'Other'];
  final List<String> _genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    // Pre-fill with existing pet data
    _nameController = TextEditingController(text: widget.pet.name);
    _breedController = TextEditingController(text: widget.pet.breed);
    _ageController = TextEditingController(text: widget.pet.age);
    _colorController = TextEditingController(text: widget.pet.color);
    _birthdayController = TextEditingController(text: widget.pet.birthday);
    _weightController = TextEditingController(text: widget.pet.weight);
    _vetNameController = TextEditingController(text: widget.pet.vetName);
    _vetClinicController = TextEditingController(text: widget.pet.vetClinic);
    _vaccinationsController = TextEditingController(text: widget.pet.vaccinations);
    _medicalNotesController = TextEditingController(text: widget.pet.medicalNotes);
    _favToyController = TextEditingController(text: widget.pet.favToy);
    _favTreatController = TextEditingController(text: widget.pet.favTreat);
    _notesController = TextEditingController(text: widget.pet.notes);
    _ownerNameController = TextEditingController(text: widget.pet.ownerName);
    _contactController = TextEditingController(text: widget.pet.contact);
    _addressController = TextEditingController(text: widget.pet.address);
    _selectedGender = widget.pet.gender.isNotEmpty ? widget.pet.gender : null;
    _selectedType = widget.pet.type.isNotEmpty ? widget.pet.type : null;
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _petImage = File(picked.path));
  }

  Future<void> _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('pets')
        .doc(widget.pet.id)
        .update({
      'name': _nameController.text,
      'type': _selectedType ?? '',
      'breed': _breedController.text,
      'age': _ageController.text,
      'gender': _selectedGender ?? '',
      'color': _colorController.text,
      'birthday': _birthdayController.text,
      'weight': _weightController.text,
      'vetName': _vetNameController.text,
      'vetClinic': _vetClinicController.text,
      'vaccinations': _vaccinationsController.text,
      'medicalNotes': _medicalNotesController.text,
      'favToy': _favToyController.text,
      'favTreat': _favTreatController.text,
      'notes': _notesController.text,
      'ownerName': _ownerNameController.text,
      'contact': _contactController.text,
      'address': _addressController.text,
      'imagePath': _petImage?.path ?? widget.pet.imagePath,
      'isVaccinated': _vaccinationsController.text.isNotEmpty,
    });

    if (mounted) Navigator.pop(context);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFC2185B),
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Information',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'SAVE CHANGES',
              style: TextStyle(color: Color(0xFFC2185B)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _petImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_petImage!, fit: BoxFit.cover),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        color: Color(0xFFC2185B), size: 32),
                    SizedBox(height: 8),
                    Text('Change photo',
                        style: TextStyle(color: Color(0xFFC2185B))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Basic Info
            _buildSectionTitle('BASIC INFO'),
            _buildTextField("Pet's Name", _nameController),
            Row(
              children: [
                Expanded(child: _buildTextField('Breed/Type', _breedController)),
                const SizedBox(width: 12),
                Expanded(child: _buildTextField('Age', _ageController)),
              ],
            ),
            Row(
              children: [
                Expanded(child: _buildTextField('Color', _colorController)),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      hint: const Text('Gender'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: _genders
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedGender = val),
                    ),
                  ),
                ),
              ],
            ),
            _buildTextField('Birthday', _birthdayController),
            _buildTextField('Weight', _weightController),

            // Health Info
            _buildSectionTitle('HEALTH INFO'),
            _buildTextField('Vet Name', _vetNameController),
            _buildTextField('Vet Clinic', _vetClinicController),
            _buildTextField('Vaccinations', _vaccinationsController),
            _buildTextField('Medical Notes', _medicalNotesController),

            // Personality
            _buildSectionTitle('PERSONALITY'),
            _buildTextField('Favorite Toy', _favToyController),
            _buildTextField('Favorite Treat', _favTreatController),
            _buildTextField('Notes/Others', _notesController),

            // Owner Info
            _buildSectionTitle('OWNER INFO'),
            _buildTextField('Owner Name', _ownerNameController),
            _buildTextField('Contact Info', _contactController),
            _buildTextField('Address', _addressController),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}