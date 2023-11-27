import 'package:eshop/presentation/views/main/form/suggestion.dart';
import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/input_form_button.dart';
import '../../../widgets/product_card.dart';
import 'form_data.dart';

enum ProductGender { Male, Female }

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  _FormView() {
    _selectedVal1 = _SkinTone[0];
    _selectedVal2 = _WaistSize[0];
    _selectedVal3 = _BodyShape[0];
  }

  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  ProductGender? _productGender;

  final _SkinTone = ["dark", "brown", "fair", "white", "milky"];
  String? _selectedVal1;

  final _WaistSize = ["32cm", "34cm", "36cm", "38cm", "40cm"];
  String? _selectedVal2;

  final _BodyShape = ["skinny", "chubby", "slimtfit", "muscular", "Obesed"];
  String? _selectedVal3;

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  void navigateToNextPage() {
    // Create an instance of FormData with the collected data
    FormData formData = FormData(
      occasion: _productController.text,
      bodyHeight: _productDesController.text,
      gender: _productGender,
      skinTone: _selectedVal1,
      waistSize: _selectedVal2,
      bodyShape: _selectedVal3,
    );

    // Navigate to the next page and pass the formData
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => suggestPage(formData: formData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 133, 57, 210),
            title: Text(
              "Details Form",
              style: TextStyle(
                color: Colors.white, // Set the desired text color
              ),
            ),
            centerTitle: true),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              MyTextField(
                  myController: _productController,
                  fieldName: "Ocassion",
                  myIcon: Icons.account_balance,
                  prefixIconColor: Color(0xFF3a086b)),
              const SizedBox(height: 10.0),
              MyTextField(
                  myController: _productDesController,
                  fieldName: "Body height (in cm)",
                  prefixIconColor: Color(0xFF3a086b)),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  MyRadioButton(
                      title: ProductGender.Male.name,
                      value: ProductGender.Male,
                      selectedproductGender: _productGender,
                      onChanged: (val) {
                        setState(() {
                          _productGender = val;
                        });
                      }),
                  SizedBox(
                    width: 5.0,
                  ),
                  MyRadioButton(
                      title: ProductGender.Female.name,
                      value: ProductGender.Female,
                      selectedproductGender: _productGender,
                      onChanged: (val) {
                        setState(() {
                          _productGender = val;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                value: _selectedVal1,
                items: _SkinTone.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal1 = val as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.deepPurple,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                    labelText: "Skin Tone",
                    prefixIcon: Icon(
                      Icons.accessibility_new_rounded,
                      color: Colors.deepPurple,
                    ),
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                value: _selectedVal3,
                items: _BodyShape.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal3 = val as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.deepPurple,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                    labelText: "Body Shape",
                    prefixIcon: Icon(
                      Icons.accessibility_new_rounded,
                      color: Colors.deepPurple,
                    ),
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                value: _selectedVal2,
                items: _WaistSize.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal2 = val as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.deepPurple,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                    labelText: "Waist Size",
                    prefixIcon: Icon(
                      Icons.accessibility_new_rounded,
                      color: Colors.deepPurple,
                    ),
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 20.0,
              ),
              myBtn(context),
            ],
          ),
        ));
  }

  //Function that returns OutlinedButton Widget also it pass data to Details Screen
  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: navigateToNextPage,
      child: Text(
        "Submit Form".toUpperCase(),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  });
  final TextEditingController myController;
  String fieldName;
  final IconData myIcon;
  Color prefixIconColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(myIcon, color: prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Color(0xFF3a086b))),
    );
  }
}

class MyRadioButton extends StatelessWidget {
  MyRadioButton({
    Key? key,
    required this.title,
    required this.value,
    required this.selectedproductGender,
    required this.onChanged,
  }) : super(key: key);

  String title;
  ProductGender value;
  ProductGender? selectedproductGender;
  Function(ProductGender?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<ProductGender>(
        title: Text(title),
        contentPadding: const EdgeInsets.all(0.0),
        value: value,
        groupValue: selectedproductGender,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        tileColor: Colors.deepPurple.shade50,
        onChanged: onChanged,
      ),
    );
  }
}
