class TileOption{
  bool? isSelected;
  String? option;
  TileOption({this.isSelected,this.option});
  @override
  String toString(){
    return """"{
        isSelected: $isSelected,
        option: $option,
        }""";
  }
}