import 'package:hindustane_ecommerce/controller/order_controller.dart';
import 'package:hindustane_ecommerce/model/NewModel/Order/Package.dart';
import 'package:hindustane_ecommerce/utils/styles.dart';
import 'package:hindustane_ecommerce/view/account/orders/OrderList/widgets/NoOrderPlacedWidget.dart';
import 'package:hindustane_ecommerce/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/OrderToShipReceiveWidget.dart';

class OrderToReceiveListScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    orderController.getToReceiveOrders();

    return Obx(
      () {
        if (orderController.isToReceiveOrderLoading.value) {
          return Center(
            child: CustomLoadingWidget(),
          );
        } else {
          if (orderController.toReceiveOrderListModel.value.packages == null ||
              orderController.toReceiveOrderListModel.value.packages.length ==
                  0) {
            return NoOrderPlacedWidget();
          }
          return Container(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppStyles.appBackgroundColor,
                  height: 5,
                  thickness: 5,
                );
              },
              itemCount:
                  orderController.toReceiveOrderListModel.value.packages.length,
              itemBuilder: (context, index) {
                Package package = orderController
                    .toReceiveOrderListModel.value.packages[index];
                return OrderToShipReceiveWidget(
                  package: package,
                );
              },
            ),
          );
        }
      },
    );
  }
}
