enum NumbersEnum { one, two, four, eight, sixteen }

enum NumbersWithValueEnum {
  one(0x00000001),
  two(0x00000002),
  four(0x00000004),
  eight(0x00000008),
  sixteen(0x00000010);

  const NumbersWithValueEnum(this.idx);

  final int idx;

  int get idxValue => idx;
}

enum NamingEnum {
  item1,
  item2SubItem1.withText('Item2:SubItem1'),
  item3SubItem1.withText('Item3:SubItem1');

  const NamingEnum() : text = '';
  const NamingEnum.withText(this.text);

  final String text;
}
