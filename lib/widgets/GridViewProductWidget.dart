import 'package:hindustane_ecommerce/AppConfig/app_config.dart';
import 'package:hindustane_ecommerce/controller/settings_controller.dart';
import 'package:hindustane_ecommerce/model/NewModel/Product/ProductModel.dart';
import 'package:hindustane_ecommerce/model/NewModel/Product/ProductType.dart';
import 'package:hindustane_ecommerce/utils/styles.dart';
import 'package:hindustane_ecommerce/view/products/product/ProductDetails.dart';
import 'package:hindustane_ecommerce/widgets/StarCounterWidget.dart';
import 'package:hindustane_ecommerce/widgets/add_cart_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridViewProductWidget extends StatefulWidget {
  final ProductModel productModel;

  GridViewProductWidget({this.productModel});

  @override
  _GridViewProductWidgetState createState() => _GridViewProductWidgetState();
}

class _GridViewProductWidgetState extends State<GridViewProductWidget> {
  final GeneralSettingsController _generalSettingsController =
      Get.put(GeneralSettingsController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.productModel.productType == ProductType.PRODUCT) {
          Get.to(() => ProductDetails(productID: widget.productModel.id),
              preventDuplicates: false);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      widget.productModel.productType != ProductType.GIFT_CARD
                          ? FancyShimmerImage(
                              imageUrl:
                                  "${AppConfig.assetPath}/${widget.productModel.product.thumbnailImageSource}",
                              boxFit: BoxFit.contain,
                              errorWidget: FancyShimmerImage(
                                imageUrl:
                                    "${AppConfig.assetPath}/backend/img/default.png",
                                boxFit: BoxFit.contain,
                              ),
                            )
                          : FancyShimmerImage(
                              imageUrl:
                                  "${AppConfig.assetPath}/${widget.productModel.giftCardThumbnailImage}",
                              boxFit: BoxFit.contain,
                              errorWidget: FancyShimmerImage(
                                imageUrl:
                                    "${AppConfig.assetPath}/backend/img/default.png",
                                boxFit: BoxFit.contain,
                              ),
                            ),
                      widget.productModel.productType == ProductType.GIFT_CARD
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: widget.productModel.giftCardEndDate
                                            .compareTo(DateTime.now()) >
                                        0
                                    ? Container(
                                        padding: EdgeInsets.all(4),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppStyles.pinkColor,
                                        ),
                                        child: Text(
                                          widget.productModel.discountType ==
                                                      "0" ||
                                                  widget.productModel
                                                          .discountType ==
                                                      0
                                              ? '-${widget.productModel.discount.toString()}% '
                                              : '${(widget.productModel.discount * _generalSettingsController.conversionRate.value).toStringAsFixed(2)}${_generalSettingsController.appCurrency.value} ',
                                          textAlign: TextAlign.center,
                                          style: AppStyles.appFont.copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            )
                          : Positioned(
                              top: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: widget.productModel.hasDeal != null
                                    ? widget.productModel.hasDeal.discount > 0
                                        ? Container(
                                            padding: EdgeInsets.all(4),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppStyles.pinkColor,
                                            ),
                                            child: Text(
                                              widget.productModel.hasDeal
                                                          .discountType ==
                                                      0
                                                  ? '${widget.productModel.hasDeal.discount.toString()}% '
                                                  : '${(widget.productModel.hasDeal.discount * _generalSettingsController.conversionRate.value).toStringAsFixed(2)}${_generalSettingsController.appCurrency.value} ',
                                              textAlign: TextAlign.center,
                                              style: AppStyles.appFont.copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : widget.productModel.discountStartDate !=
                                                null &&
                                            _generalSettingsController.endDate
                                                    .millisecondsSinceEpoch <
                                                DateTime.now()
                                                    .millisecondsSinceEpoch
                                        ? Container()
                                        : widget.productModel.discount > 0
                                            ? Container(
                                                padding: EdgeInsets.all(4),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppStyles.pinkColor,
                                                ),
                                                child: Text(
                                                  widget.productModel
                                                              .discountType ==
                                                          "0"
                                                      ? '-${widget.productModel.discount.toString()}% '
                                                      : '${(widget.productModel.discount * _generalSettingsController.conversionRate.value).toStringAsFixed(2)}${_generalSettingsController.appCurrency.value} ',
                                                  textAlign: TextAlign.center,
                                                  style: AppStyles.appFont
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                              ),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.productModel.productType == ProductType.PRODUCT
                            ? widget.productModel.productName.toString()
                            : widget.productModel.giftCardName.toString(),
                        style: AppStyles.appFont.copyWith(
                          color: AppStyles.blackColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.productModel.hasDeal != null
                          ? widget.productModel.hasDeal.discount > 0
                              ? Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.start,
                                  runSpacing: 2,
                                  spacing: 2,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    Text(
                                      '${_generalSettingsController.calculatePrice(widget.productModel)}${_generalSettingsController.appCurrency.value}',
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.appFont.copyWith(
                                        fontSize: 12,
                                        color: AppStyles.pinkColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '${_generalSettingsController.calculateMainPrice(widget.productModel)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.appFont.copyWith(
                                        fontSize: 12,
                                        color: AppStyles.greyColorDark,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                )
                              : Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.start,
                                  runSpacing: 2,
                                  spacing: 2,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    Text(
                                      '${_generalSettingsController.calculatePrice(widget.productModel)}${_generalSettingsController.appCurrency.value}',
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.appFont.copyWith(
                                        fontSize: 12,
                                        color: AppStyles.pinkColor,
                                      ),
                                    ),
                                  ],
                                )
                          : Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.start,
                              runSpacing: 2,
                              spacing: 2,
                              runAlignment: WrapAlignment.start,
                              children: [
                                Text(
                                  '${_generalSettingsController.calculatePrice(widget.productModel)}${_generalSettingsController.appCurrency.value}',
                                  style: AppStyles.appFont.copyWith(
                                    fontSize: 12,
                                    color: AppStyles.pinkColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '${_generalSettingsController.calculateMainPrice(widget.productModel)}',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.appFont.copyWith(
                                    fontSize: 12,
                                    color: AppStyles.greyColorDark,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              widget.productModel.avgRating > 0
                                  ? StarCounterWidget(
                                      value: widget.productModel.avgRating
                                          .toDouble(),
                                      color: Colors.amber,
                                      size: 12,
                                    )
                                  : StarCounterWidget(
                                      value: 0,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                              SizedBox(
                                width: 2,
                              ),
                              widget.productModel.avgRating > 0
                                  ? Text(
                                      '(${widget.productModel.avgRating.toString()})',
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.appFont.copyWith(
                                        color: AppStyles.greyColorDark,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      '(0)',
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.appFont.copyWith(
                                        color: AppStyles.greyColorDark,
                                        fontSize: 12,
                                      ),
                                    ),
                            ],
                          ),
                          Expanded(child: Container()),
                          AddCartWidget(
                            productModel: widget.productModel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


