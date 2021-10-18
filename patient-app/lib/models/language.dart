class Language{
  final int id;
  final String name;
  final String languageCode;
  Language(this.id,this.name,this.languageCode);
static List<Language> languagelist(){
  return <Language>[
    Language(1,'English','en'),
  Language(2,'हिंदी','hi'),
    Language(3,'ਪੰਜਾਬੀ','pa')
  ];
}
}