import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/datasheet_cost.dart';
import 'repository_providers.dart';

part 'datasheet_cost_provider.g.dart';

@riverpod
class DatasheetCostNotifier extends _$DatasheetCostNotifier {
  @override
  Future<List<DatasheetCost>> build() async {
    final repository = ref.watch(datasheetCostRepositoryProvider);
    return repository.loadDatasheetCosts();
  }

  List<DatasheetCost> getCostsForDatasheet(String datasheetId) {
    final costs = state.valueOrNull;
    if (costs == null) return [];
    return costs.where((cost) => cost.datasheetId == datasheetId).toList();
  }
}
