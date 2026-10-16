import '../../domain/entities/meal_entity.dart';

class MealModel {
  final String id;
  final String name;
  final String category;
  final String area;
  final String country;
  final String thumbnailUrl;
  final String instructions;

  const MealModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    this.country = '',
    required this.thumbnailUrl,
    this.instructions = '',
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    id: (json['idMeal'] as String?) ?? '',
    name: (json['strMeal'] as String?) ?? '',
    category: (json['strCategory'] as String?) ?? '',
    area: (json['strArea'] as String?) ?? '',
    country: (json['strCountry'] as String?) ?? '',
    thumbnailUrl: (json['strMealThumb'] as String?) ?? '',
    instructions: (json['strInstructions'] as String?) ?? '',
  );

  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strCategory': category,
    'strArea': area,
    'strCountry': country,
    'strMealThumb': thumbnailUrl,
    'strInstructions': instructions,
  };

  MealEntity toEntity() => MealEntity(
    id: id,
    name: name,
    category: category,
    area: area,
    country: country,
    thumbnailUrl: thumbnailUrl,
    instructions: instructions,
  );
}
