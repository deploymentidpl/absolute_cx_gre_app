class BlockUnitPropertyModel {
  late String imageUrl, thumbNail, address;
  late bool isBlocked;
  late DateTime? blockedFrom, blockedTo;

  BlockUnitPropertyModel(
      {required this.imageUrl,
      required this.thumbNail,
      required this.address,
      this.isBlocked = true});
}
