import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils/shown_snack_bar.dart';
import 'package:amazon_clone/data/apis/address_api.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class Address extends StatefulWidget {
  static const String routeName = '/address';
  // final String totalAmount;
  final User user;
  const Address({
    Key? key,
    required this.user,
    // required this.totalAmount,
  }) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _addressKeyForm = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];

  final AddressAPI _addressAPI = AddressAPI();
  String addressToBeUsed = '';

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.user.total.toString(),
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      _addressAPI.saveUserAddress(context: context, address: addressToBeUsed);
    }
    _addressAPI.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalPrice: widget.user.total,
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      _addressAPI.saveUserAddress(context: context, address: addressToBeUsed);
    }
    _addressAPI.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalPrice: widget.user.total,
    );
  }

  void payPressed(String address) {
    addressToBeUsed = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;
    if (isForm) {
      if (_addressKeyForm.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (widget.user.address.isNotEmpty) {
      addressToBeUsed = widget.user.address;
    } else {
      ShownSnackBar(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = widget.user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text('Address'),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(widget.user.name),
              // Text(widget.user.email),
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              Form(
                  key: _addressKeyForm,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: flatBuildingController,
                        label: 'Flat, House no, Building',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: areaController,
                        label: 'Area, Street',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: pincodeController,
                        label: 'Pin code',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: cityController,
                        label: 'Town/City',
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              ApplePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfigurationAsset: 'applepay.json',
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                style: GooglePayButtonStyle.black,
                type: GooglePayButtonType.buy,
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
              )
            ],
          ),
        ),
      ),
    );
  }
}
