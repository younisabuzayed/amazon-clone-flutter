// ignore_for_file: sized_box_for_whitespace

import 'package:amazon_clone/screens/search/search_screen.dart';
import 'package:amazon_clone/screens/home/widget/custom_ModalBottom.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  String? searchValue;
  Header({
    Key? key,
    this.searchValue,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.searchValue ?? '';
  }

  void onPressOpenMic() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final mediaQuery = MediaQuery.of(context).size;
          return CustomModalBottom();
        });
    setState(() {});
  }

  void _navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      Search.routeName,
      arguments: query,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 15),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 1,
              child: TextFormField(
                controller: _textEditingController,
                onFieldSubmitted: _navigateToSearchScreen,
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () => _navigateToSearchScreen,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 23,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 46,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CustomModalBottom(
                        // startListening: _startListening,
                        // stopListening: _stopListening,
                        // isListening: isListening,
                        // speechEnabled: _speechEnabled,
                        // result: _lastWords,
                        // speechToText: _speechToText,
                        );
                  });
            },
            child: const Icon(
              Icons.mic,
              color: Colors.black,
              size: 25,
            ),
          ),
        )
      ],
    );
  }
}
