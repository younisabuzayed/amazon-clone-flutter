import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/screens/address/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  void navigateToAddress(
    BuildContext context,
    User user
    ) {
    Navigator.pushNamed(
      context, 
      Address.routeName,
      arguments: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
      onTap: () => navigateToAddress(context, user),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 114, 236, 233),
          ], stops: [
            0.5,
            1.0,
          ]),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.fade,
              ),
            )),
            const Padding(
              padding: EdgeInsets.only(
                left: 5,
                top: 2,
              ),
              child: Icon(
                Icons.arrow_drop_down_outlined,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
