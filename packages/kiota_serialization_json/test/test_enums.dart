enum NamingEnum {
  item1.withValue(null),
  item2SubItem1.withValue('Item2:SubItem1'),
  item3SubItem1.withValue('Item3:SubItem1');

  const NamingEnum.withValue(this.value);

  final String? value;
}
