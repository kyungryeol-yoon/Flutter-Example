
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sociallogin/common/model/cursor_pagination_model.dart';
import 'package:sociallogin/common/provider/pagination_provider.dart';
import 'package:sociallogin/product/model/product_model.dart';
import 'package:sociallogin/product/repository/product_repository.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(productRepositoryProvider);

  return ProductStateNotifier(repository: repo);
});

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}
