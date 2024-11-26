import 'package:json_annotation/json_annotation.dart';
part 'quote.g.dart';

@JsonSerializable()
class Quote {
    int id;
    String quote;
    String author;

    Quote({
        required this.id,
        required this.quote,
        required this.author,
    });
    factory Quote.fromJson(Map<String,dynamic>json) =>
  _$QuoteFromJson(json);
 
 Map<String,dynamic> toJson()=>_$QuoteToJson(this);
 

}