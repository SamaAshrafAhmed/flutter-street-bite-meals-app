class MealEntity {
  final String id;
  final String name;
  final String category;
  final String area;
  final String thumbnailUrl;
  final String instructions;

  const MealEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnailUrl,
    this.instructions = '',
  });
}
