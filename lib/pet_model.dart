class Pet {
  final String id;
  final String name;
  final String type;
  final String species;
  final String breed;
  final String age;
  final String gender;
  final String color;
  final String birthday;
  final String weight;
  final String vetName;
  final String vetClinic;
  final String vaccinations;
  final String medicalNotes;
  final String favToy;
  final String favTreat;
  final String notes;
  final String ownerName;
  final String contact;
  final String address;
  final String imagePath;
  final bool isVaccinated;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.species,
    required this.breed,
    required this.age,
    required this.gender,
    required this.color,
    required this.birthday,
    required this.weight,
    required this.vetName,
    required this.vetClinic,
    required this.vaccinations,
    required this.medicalNotes,
    required this.favToy,
    required this.favTreat,
    required this.notes,
    required this.ownerName,
    required this.contact,
    required this.address,
    required this.imagePath,
    required this.isVaccinated,
  });

  // Convert Pet to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'species': species,
      'breed': breed,
      'age': age,
      'gender': gender,
      'color': color,
      'birthday': birthday,
      'weight': weight,
      'vetName': vetName,
      'vetClinic': vetClinic,
      'vaccinations': vaccinations,
      'medicalNotes': medicalNotes,
      'favToy': favToy,
      'favTreat': favTreat,
      'notes': notes,
      'ownerName': ownerName,
      'contact': contact,
      'address': address,
      'imagePath': imagePath,
      'isVaccinated': isVaccinated,
    };
  }

  // Convert Firestore map to Pet
  factory Pet.fromMap(String id, Map<String, dynamic> map) {
    return Pet(
      id: id,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      species: map['species'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      color: map['color'] ?? '',
      birthday: map['birthday'] ?? '',
      weight: map['weight'] ?? '',
      vetName: map['vetName'] ?? '',
      vetClinic: map['vetClinic'] ?? '',
      vaccinations: map['vaccinations'] ?? '',
      medicalNotes: map['medicalNotes'] ?? '',
      favToy: map['favToy'] ?? '',
      favTreat: map['favTreat'] ?? '',
      notes: map['notes'] ?? '',
      ownerName: map['ownerName'] ?? '',
      contact: map['contact'] ?? '',
      address: map['address'] ?? '',
      imagePath: map['imagePath'] ?? '',
      isVaccinated: map['isVaccinated'] ?? false,
    );
  }
}