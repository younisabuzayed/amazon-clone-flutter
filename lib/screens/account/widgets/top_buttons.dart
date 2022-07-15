import 'package:amazon_clone/data/apis/account_api.dart';
import 'package:amazon_clone/screens/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              title: 'Your Orders',
              onPressed: () {},
            ),
            AccountButton(
              title: 'Turn Seller',
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox( height: 10,),
        Row(
          children: [
            AccountButton(
              title: 'Log Out',
              onPressed: () {
                AccountAPI().logOut(context);
              },
            ),
            AccountButton(
              title: 'Your Wish List',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
