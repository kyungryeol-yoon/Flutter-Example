import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sociallogin/common/component/pagination_list_view.dart';
import 'package:sociallogin/restaurant/component/restaurant_card.dart';
import 'package:sociallogin/restaurant/provider/restaurant_provider.dart';
import 'package:sociallogin/restaurant/screen/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {
                'rid': model.id,
              },
            );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
