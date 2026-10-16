class MealEntity {
  final String id;
  final String name;
  final String category;
  final String area;
  final String country;
  final String thumbnailUrl;
  final String instructions;

  const MealEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    this.country = '',
    required this.thumbnailUrl,
    this.instructions = '',
  });
}
