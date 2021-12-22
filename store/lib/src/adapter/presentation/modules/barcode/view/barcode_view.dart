import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../application/barcode/service/Barcode_formatter.dart';
import '../../../../../common/message/messages.dart';
import '../../../services/barcode_service.dart';
import '../widget/mobile_carrier_tab_item.dart';

class BarcodeView extends GetView<BarcodeService> {
  const BarcodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              Messages.membershipTitle,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Obx(
            () {
              var barcode =
                  controller.carrierBarcodeMap[controller.selectedCarrierName]!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.mobileCarriers
                          .map(
                            (carrier) => MobileCarrierTabItem(
                              carrier: carrier,
                              width: Get.width * 0.25,
                              color: controller.selectedCarrierIndex ==
                                      carrier.index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).disabledColor,
                              textStyle: controller.selectedCarrierIndex ==
                                      carrier.index
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold)
                                  : Theme.of(context).textTheme.bodyText1!,
                              onTap: (index) {
                                controller.selectedCarrierIndex(index);
                                controller.initTextField();
                              },
                            ),
                          )
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: BarcodeWidget(
                        height: Get.height * 0.13,
                        data: barcode.val,
                        barcode: Barcode.code128(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '''${controller.selectedCarrierName} ${Messages.membership}''',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: TextField(
                            controller: controller.textEditingController,
                            onChanged: (value) {
                              var input = value.isEmpty
                                  ? BarcodeService.defaultBarcode
                                  : value;

                              barcode.val = input;
                              controller.carrierBarcodeMap.refresh();
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              BarcodeInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                              labelText: Messages.inputMembershipCode,
                              fillColor: Colors.transparent,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
