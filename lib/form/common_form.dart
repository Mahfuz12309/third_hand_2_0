import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';
import 'package:third_hand_2_0/components/bottom_nav_widget.dart';
import 'package:third_hand_2_0/constants/colors.dart';
import 'package:third_hand_2_0/constants/widgets.dart';
import 'package:third_hand_2_0/form/user_form_review.dart';
import 'package:third_hand_2_0/provider/category_provider.dart';
import 'package:third_hand_2_0/services/user.dart';

import '../components/image_picker_widget.dart';
import '../constants/validators.dart';

class CommonForm extends StatefulWidget {
  static const screenId = 'common_form';

  const CommonForm({Key? key}) : super(key: key);

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  UserService firebaseUser = UserService();
  late TextEditingController _priceController;
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late FocusNode _priceNode;
  late FocusNode _titleNode;
  late FocusNode _descNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    _descController = TextEditingController();
    _priceNode = FocusNode();
    _titleNode = FocusNode();
    _descNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _descController.dispose();
    _priceNode.dispose();
    _titleNode.dispose();
    _descNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // it is used to get context
    var categoryProvider = Provider.of<CategoryProvider>(context);
    setState(() {
      _priceController.text = categoryProvider.formData.isEmpty
          ? ""
          : categoryProvider.formData['price'] ?? '';
      _titleController.text = categoryProvider.formData.isEmpty
          ? ""
          : categoryProvider.formData['title'] ?? '';
      _descController.text = categoryProvider.formData.isEmpty
          ? ""
          : categoryProvider.formData['description'] ?? '';
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          iconTheme: IconThemeData(color: blackColor),
          title: Text(
            'Add Service Details',
            style: TextStyle(color: blackColor),
          )),
      body: sellCarFormWidget(categoryProvider),
      bottomNavigationBar: BottomNavigationWidget(
        buttonText: 'Next',
        validator: true,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            categoryProvider.formData.addAll({
              'user_uid': firebaseUser.user!.uid,
              'category': categoryProvider.selectedCategory,
              'subcategory': categoryProvider.selectedSubCategory,
              'urgency_level': _priceController.text,
              'title': _titleController.text,
              'description': _descController.text,
              'images': categoryProvider.imageUploadedUrls.isEmpty
                  ? ''
                  : categoryProvider.imageUploadedUrls,
              'posted_at': DateTime.now().microsecondsSinceEpoch,
              'favourites': [],
            });
            if (categoryProvider.imageUploadedUrls.isNotEmpty) {
              Navigator.pushNamed(context, UserFormReview.screenId);
            } else {
              customSnackBar(
                  context: context,
                  content: 'Please upload images to the database');
            }
            print(categoryProvider.formData);
          }
        },
      ),
    );
  }

  sellCarFormWidget(categoryProvider) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${categoryProvider.selectedSubCategory}',
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ImagePickerWidget();
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[300],
                    ),
                    child: Text(
                      categoryProvider.imageUploadedUrls.isNotEmpty
                          ? 'Upload More Images'
                          : 'Upload Image',
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                categoryProvider.imageUploadedUrls.isNotEmpty
                    ? GalleryImage(
                        titleGallery: 'Uploaded Images',
                        numOfShowImages:
                            categoryProvider.imageUploadedUrls.length,
                        imageUrls: categoryProvider.imageUploadedUrls)
                    : SizedBox(),
                Text(
                  "upload an image of your so that people can recongnize you when you meet*",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red.shade900),
                ),SizedBox(height: 10,),
                TextFormField(
                    controller: _priceController,
                    focusNode: _priceNode,
                    validator: (value) {
                      return validatePrice(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: const Text(' '),
                      labelText: 'Add the urgency level of 1-10*',
                      labelStyle: TextStyle(
                        color: greyColor,
                        fontSize: 14,
                      ),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 10),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: disabledColor)),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _titleController,
                    focusNode: _titleNode,
                    maxLength: 50,
                    validator: (value) {
                      return checkNullEmptyValidation(value, 'title');
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      counterText: 'Mention the key Notes',
                      labelStyle: TextStyle(
                        color: greyColor,
                        fontSize: 14,
                      ),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 10),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: disabledColor)),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _descController,
                    focusNode: _descNode,
                    maxLines: 3,
                    validator: (value) {
                      return checkNullEmptyValidation(value, 'description');
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Description*',
                      labelStyle: TextStyle(
                        color: greyColor,
                        fontSize: 14,
                      ),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 10),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: disabledColor)),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
