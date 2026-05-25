import 'package:flutter/material.dart';

class PetDetailScreen extends StatelessWidget {
  final String name;
  final String type;
  final String breed;
  final String age;
  final String gender;
  final String color;
  final String birthday;
  final String weight;
  final String vetName;
  final String vaccinations;
  final String medicalNotes;
  final String ownerName;
  final String contact;
  final bool isVaccinated;

  const PetDetailScreen({
    super.key,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.gender,
    required this.color,
    required this.birthday,
    required this.weight,
    required this.vetName,
    required this.vaccinations,
    required this.medicalNotes,
    required this.ownerName,
    required this.contact,
    required this.isVaccinated,
  });

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 1,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text(breed,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Age, Weight, Color summary
            Row(
              children: [
                _buildStatCard(age, 'years old', Colors.grey[200]!),
                const SizedBox(width: 8),
                _buildStatCard(weight, 'Kg', Colors.grey[200]!),
                const SizedBox(width: 8),
                _buildStatCard(color, 'Color', const Color(0xFFFCE4EC)),
              ],
            ),
            const SizedBox(height: 16),

            // Basic Info
            _buildSectionTitle('BASIC INFO'),
            _buildInfoRow('Breed', breed),
            _buildInfoRow('Birthday', birthday),
            _buildInfoRow('Gender', gender),
            _buildInfoRow('Color', color),

            // Health
            _buildSectionTitle('HEALTH'),
            _buildInfoRow('Vet', vetName),
            _buildInfoRow('Vaccinations', isVaccinated ? 'Vaccinated' : 'Not vaccinated'),
            _buildInfoRow('Medical notes', medicalNotes),

            // Owner Contact
            _buildSectionTitle('OWNER CONTACT'),
            _buildInfoRow('Owner', ownerName),
            _buildInfoRow('Phone', contact),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF3A7CA5))),
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}