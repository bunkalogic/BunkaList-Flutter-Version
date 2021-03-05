
class FilterParams {

  String type;
  String title;
  bool design;
  String sortBy;
  int year;
  int voteCountGte;
  String genre;
  String withKeywords;
  String withNetwork;
  String withOriginalLanguage;

  FilterParams({
    this.title,
    this.type,
    this.design,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withNetwork,
    this.withOriginalLanguage
  });

  FilterParams.fromJson(Map<String, dynamic> json) :
    title                = json['title'],
    type                 = json['type'],
    design               = json['design'],
    sortBy               = json['sortBy'],
    year                 = json['year'],
    voteCountGte         = json['voteCountGte'],
    genre                = json['genre'],
    withKeywords         = json['withKeywords'],
    withNetwork          = json['withNetwork'],
    withOriginalLanguage = json['withOriginalLanguage'];


  Map<String, dynamic> toJson() => {
   'title'                : title,
   'type'                 : type,
   'design'               : design,
   'sortBy'               : sortBy,
   'year'                 : year,
   'voteCountGte'         : voteCountGte,
   'genre'                : genre,
   'withKeywords'         : withKeywords,
   'withNetwork'          : withNetwork,
   'withOriginalLanguage' : withOriginalLanguage

  };


}