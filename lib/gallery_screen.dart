import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'pet_model.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  Stream<List<Pet>> _petsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('pets')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Pet.fromMap(doc.id, doc.data()))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Gallery',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Grid
              Expanded(
                child: StreamBuilder<List<Pet>>(
                  stream: _petsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final pets = snapshot.data ?? [];
                    final petsWithImages = pets
                        .where((pet) => pet.imagePath.isNotEmpty)
                        .toList();

                    if (petsWithImages.isEmpty) {
                      return const Center(
                        child: Text(
                          'No photos yet!\nAdd a pet photo to see it here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: petsWithImages.length,
                      itemBuilder: (context, index) {
                        final pet = petsWithImages[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(pet.imagePath),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}