import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dio/api_constants.dart';
import '../../dio/dio_client.dart';
import '../model/quote.dart';

class QuoteRepo {
  final Ref ref;
  QuoteRepo(this.ref);
  
  Future<List<Quote>> fetchQuotes() async {

    final response = await ref.read(dioProvider).get(ApiConstants.BaseUrl);

    if (response.statusCode == 200) {
      List<Quote> quoteList = response.data['quotes']
          .map<Quote>((quote) => Quote.fromJson(quote))
          .toList();
      return quoteList.take(2).toList();
    } else {
      return Future.error("Failed to load quotes");
    }
  }
}

final quoteRepoProvider = Provider((ref)=>QuoteRepo(ref));

