import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/data/apis/admin_api.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/home/widget/header.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;
  const OrderDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;
  final AdminAPI _adminAPI = AdminAPI();

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  // NOTE: Only for Admin !!
  void changeOrderStatus(int status) {
    _adminAPI.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final orderList = widget.order;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Header(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View orders details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Date:   ${DateFormat().format(
                    DateTime.fromMillisecondsSinceEpoch(
                      orderList.orderedAt,
                    ),
                  )}"),
                  const SizedBox(height: 5),
                  Text(
                    "Order ID:       ${orderList.id}",
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Order total:   \$${orderList.totalPrice}",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Purchase details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.products[i].images[0],
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderList.products[i].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Qty: ${orderList.quantity[i]}",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tracking',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  if (user.type == 'admin') {
                    return CustomButton(
                      title: 'Done',
                      onPressed: () => changeOrderStatus(details.currentStep),
                    );
                  }
                  return const SizedBox(
                    width: double.infinity,
                  );
                },
                steps: [
                  Step(
                    title: const Text('Pending'),
                    content: const Text('Your order is yet to be delivered'),
                    isActive: currentStep > 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Completed'),
                    content: currentStep > 1
                      ? const Text(
                        'Your order has been delivered, you are yet to sign')
                      : const SizedBox(),
                    isActive: currentStep > 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Received'),
                    content: currentStep > 2 
                      ? const Text(
                        'Your order has been delivered and signed by you')
                      : const SizedBox(),
                    isActive: currentStep > 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Delivered'),
                    content: const Text('You has been delivered'),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
