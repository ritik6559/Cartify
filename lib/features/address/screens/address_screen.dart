import 'package:e_commerce_application/common/widgets/custom_text_field.dart';
import 'package:e_commerce_application/constants/global_variables.dart';
import 'package:e_commerce_application/constants/utils.dart';
import 'package:e_commerce_application/features/address/services/address_services.dart';
import 'package:e_commerce_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  String addressToBeUsed = "";

  List<PaymentItem> paymentItems = [];

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context,listen: false).user.address.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    //checking which address to use default or the new one
    //if all the textfield are empty means we are using the default address.

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town, City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        onPressed: () => payPressed(address),
                        paymentConfiguration: snapshot.data!,
                        width: double.infinity,
                        paymentItems: paymentItems,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        theme: GooglePayButtonTheme.dark,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox(
                        child: Text("hello"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
