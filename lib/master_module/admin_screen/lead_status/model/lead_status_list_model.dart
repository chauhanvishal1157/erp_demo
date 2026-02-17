class LeadStatusListModel{
  final int id;
  final String name;
  final String status;
  final String textColor;
  final String textBgColor;
  final String orderBy;

  LeadStatusListModel( {
    required this.id,
    required this.name,
    required this.status,
    required this.textColor,
    required this.textBgColor,
    required this.orderBy,
  });
}