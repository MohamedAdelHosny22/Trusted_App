/// Category model for marketplace categories
class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final bool isSelected;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    bool? isSelected,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
