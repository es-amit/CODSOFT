
class FavoriteQuote{
  late String id;
  late String content;
  late String author;
  late bool isFavorite;

  FavoriteQuote({
    required this.id,
    required this.content,
    required this.author,
    required this.isFavorite,
  });

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'content':content,
      'author':author,
      'isFavorite': isFavorite ? 1 : 0
    };
  }

  FavoriteQuote.fromMap(Map<String,dynamic> map){
    id = map['id'];
    content = map['content'];
    author = map['author'];
    isFavorite = map['isFavorite'] == 1;
  }
}
