import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pet_model.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _colorController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _weightController = TextEditingController();
  final _vetNameController = TextEditingController();
  final _vetClinicController = TextEditingController();
  final _vaccinationsController = TextEditingController();
  final _medicalNotesController = TextEditingController();
  final _favToyController = TextEditingController();
  final _favTreatController = TextEditingController();
  final _notesController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedGender;
  String? _selectedType;
  File? _petImage;

  final List<String> _petTypes = ['Dog', 'Cat', 'Fish', 'Bird', 'Other'];
  final List<String> _genders = ['Male', 'Female'];

  Future<void> _savePet() async {
    // Validation
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your pet's name!")),
      );
      return;
    }
    if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a pet type!')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final pet = Pet(
      id: '',
      name: _nameController.text,
      type: _selectedType ?? '',
      breed: _breedController.text,
      age: _ageController.text,
      gender: _selectedGender ?? '',
      color: _colorController.text,
      birthday: _birthdayController.text,
      weight: _weightController.text,
      vetName: _vetNameController.text,
      vetClinic: _vetClinicController.text,
      vaccinations: _vaccinationsController.text,
      medicalNotes: _medicalNotesController.text,
      favToy: _favToyController.text,
      favTreat: _favTreatController.text,
      notes: _notesController.text,
      ownerName: _ownerNameController.text,
      contact: _contactController.text,
      address: _addressController.text,
      imagePath: _petImage?.path ?? '',
      isVaccinated: _vaccinationsController.text.isNotEmpty,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('pets')
        .add(pet.toMap());

    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _petImage = File(picked.path));
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
          'Add a Pet',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo upload
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
                    Text('Upload your pet photo',
                        style: TextStyle(color: Color(0xFFC2185B))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // What kind of pet
            _buildSectionTitle('WHAT KIND OF PET?'),
            DropdownButtonFormField<String>(
              value: _selectedType,
              hint: const Text('Select type'),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              items: _petTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedType = val),
            ),

            // Basic Info
            _buildSectionTitle('BASIC INFO'),
            _buildTextField("Pet's Name", _nameController),
            Row(
              children: [
                Expanded(child: _buildTextField('Breed', _breedController)),
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
                          .map((g) =>
                          DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedGender = val),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: _buildTextField('Birthday', _birthdayController)),
                const SizedBox(width: 12),
                Expanded(child: _buildTextField('Weight', _weightController)),
              ],
            ),

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

            const SizedBox(height: 24),
            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _savePet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC2185B),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SAVE PET PROFILE'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}