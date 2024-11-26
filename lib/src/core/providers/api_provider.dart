import 'package:flutter_assessment_project/src/core/data/model/quote.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repo/api_repo.dart';

final quoteProvider = FutureProvider<List<Quote>>((ref)async{
 return await ref.watch(quoteRepoProvider).fetchQuotes();
});
