import 'package:flutter/material.dart';
import 'package:revew_ui_app/screen/model/category.dart';

class SettingUiScrren extends StatefulWidget {
  const SettingUiScrren({Key? key}) : super(key: key);

  @override
  State<SettingUiScrren> createState() => _SettingUiScreenState();
}

class _SettingUiScreenState extends State<SettingUiScrren> {
  bool _value = false;
  String? _gender;
  int? _index;
  final List<String> _list = <String>[];
  late TextEditingController _textEditingController;

  final List<Category> _category = <Category>[
    Category("Sport"),
    Category("Casual"),
    Category("Formal"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Shpw notfiction"),
          subtitle: const Text("Enable/false"),
          value: _value,
          onChanged: (bool value) {
            setState(
              () {
                _value = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: Colors.red,
                value: "m",
                title: const Text("Meal"),
                groupValue: _gender,
                onChanged: (String? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: Colors.red,
                value: "f",
                title: const Text("Female"),
                groupValue: _gender,
                onChanged: (String? value) {
                  setState(
                    () {
                      _gender = value;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Categories",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        for (Category c in _category)
          CheckboxListTile(
            title: Text(c.name),
            value: c.cheked,
            onChanged: (value) {
              // if(value != null) {
              setState(
                () {
                  c.cheked = value!;
                },
              );
            },
          ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Country",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Container(
          // ignore: prefer_const_constructors
          margin: EdgeInsets.all(10),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(10),
            hint: const Text("selecte country"),
            disabledHint: const Text("no action"),
            isExpanded: true,
            iconEnabledColor: Colors.red,
            value: _index,
            onChanged: _value
                ? (int? value) {
                    setState(() {
                      _index = value;
                    });
                  }
                : null,
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text("Gaza"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Rafah"),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Experience",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _textEditingController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            label: const Text("inter experience"),
            suffixIcon: IconButton(
              onPressed: () => _performe(),
              icon: const Icon(
                Icons.save,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 10,

          children: _list
              .map(
                (e) => Chip(
                  label: Text(e),
                  avatar:const Icon(Icons.work,size: 18,color: Colors.red,),
                  deleteIcon: const Icon(Icons.delete,color: Colors.red,),
                  onDeleted: (){
                    setState(() {
                      _list.remove(e);
                      // _list.removeWhere((element) => element == e);
                    });
                  },

                ),
              )
              .toList(),
        )
      ],
    );
  }

  void _performe() {
    if (_checkData()) {
      save();
    }
  }

  bool _checkData() {
    if (_textEditingController.text.isNotEmpty) {
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "inter text pleace",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    return false;
  }

  void save() {
    setState(() {
      _list.add(_textEditingController.text);
    });
    _textEditingController.clear();
  }
}
