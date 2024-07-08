import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lca/api/api.dart';
import 'package:lca/model/login_model.dart';
import 'package:lca/screens/auth/login.dart';
import 'package:lca/screens/profile/edit_profile.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/config.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/image_constant.dart';
import '../../widgets/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../auth/signup.dart';

String? jsonString;
String? token;

class FrameThirtytwoPage extends StatefulWidget {
  FrameThirtytwoPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrameThirtytwoPage> createState() => _FrameThirtytwoPageState();
}

class _FrameThirtytwoPageState extends State<FrameThirtytwoPage> {
  Future<List<LoginModel>>? devices;
  void userdetail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jsonString = prefs.getString('user');
      image_path = "/" + prefs.getString('image').toString();
      token = prefs.getString("token");
    });

    print('stored data user:${jsonString}');
    print('stored data token:${token}');
  }

  Future<User> fetchUserData() async {
    final response = json.decode(jsonString.toString());

    return User.fromJson(response);
  }

  @override
  void initState() {
    super.initState();

    userdetail();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Sizer(builder: (context, orientation, deviceType) {
          return jsonString == null
              ? CircularProgressIndicator()
              : FutureBuilder<User>(
                  initialData: null,
                  future: fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data found'));
                    }
                    final userData = snapshot.data!;
                    final user = '${userData.firstName.toString()} ${userData.lastName}';
final send=userData;
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          width: double.maxFinite,
                          decoration: AppDecoration.fillWhiteA,
                          child: Column(
                            children: [
                              _buildUsernameSection(context),
                              SizedBox(height: 10.v),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: CustomElevatedButton(
                                      leftIcon: Icon(Icons.logout,color: Colors.white,),
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.clear();
                                        Get.offAll(() => FrameThirteenScreen());
                                      },
                                      width: 130.h,
                                      text: "Logout",
                                      buttonTextStyle: CustomTextStyles
                                          .labelLargeWhiteA70001,
                                      buttonStyle: CustomButtonStyles
                                          .fillOrangeATL15
                                          .copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          // If the button is pressed, return green, otherwise blue
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Colors.green;
                                          }
                                          return Colors.green;
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 40.h, right: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgSettings,
                                        height: 34.v,
                                        width: 38.h,
                                        color: Color.fromRGBO(48, 60, 122, 1),
                                        margin: EdgeInsets.only(bottom: 2.v),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 35.h,
                                          top: 6.v,
                                        ),
                                        child: Text(
                                          user.toString(),
                                          style: theme.textTheme.titleLarge!
                                              .copyWith(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 17.v),
                              Divider(
                                indent: 10.h,
                                endIndent: 10.h,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 1.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 45.h),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgMinimize,
                                        height: 34.v,
                                        width: 28.h,
                                        color: Color.fromRGBO(48, 60, 122, 1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 41.h,
                                          top: 4.v,
                                          bottom: 5.v,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10),
                                          child: Text(userData
                                                  .phoneNo
                                                  .toString()
                                              //  style: CustomTextStyles.titleLargeRoboto,
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                indent: 10.h,
                                endIndent: 10.h,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 43.h, right: 20),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgLock,
                                        height: 28.v,
                                        width: 29.h,
                                        color: Color.fromRGBO(48, 60, 122, 1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 42.h,
                                          right: 17.h,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 10),
                                          child: Text(
                                            userData.email
                                                .toString(),
                                            style: theme.textTheme.titleLarge!
                                                .copyWith(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                indent: 10.h,
                                endIndent: 10.h,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10.v),
                              _buildVuesaxlinearSection(
                                  context,
                                  userData!.address!.city.toString(),
                                  userData!.address!.pincode
                                      .toString()),
                              SizedBox(height: 10.v),
                              _buildVuesaxlinearSection(
                                  context,
                                  userData.address!.state
                                      .toString(),
                                  userData.address!.country
                                      .toString()),
                              SizedBox(height: 10.v),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 43.h),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.address,
                                          height: 34.v,
                                          width: 29.h,
                                          color: Color.fromRGBO(48, 60, 122, 1),
                                          margin: EdgeInsets.only(bottom: 1.v),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10.h,
                                            top: 2.v,
                                          ),
                                          child: Text(
                                            userData.address!
                                                .fullAddress
                                                .toString(),
                                            maxLines: 4,
                                            style: theme.textTheme.titleLarge!
                                                .copyWith(fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.v),
                              Divider(
                                indent: 10.h,
                                endIndent: 10.h,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 41.v),
                              CustomElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit(lat:send.address!.lat,long:send!.address!.long,
                                    firstName: send!.firstName,lastName:send.lastName,token:token.toString(),phoneNo: send.phoneNo,pincode: send.address!.pincode.toString(),state: send.address!.state,city: send.address!.city,country: send.address!.country,fullAddress: send.address!.fullAddress,email: send.email,)));
                                },
                                width: 186.h,
                                text: "Edit Profile",
                                buttonTextStyle:
                                    CustomTextStyles.labelLargeWhiteA70001,
                                buttonStyle:
                                    CustomButtonStyles.fillOrangeATL15.copyWith(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    // If the button is pressed, return green, otherwise blue
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.green;
                                    }
                                    return Colors.green;
                                  }),
                                ),
                              ),
                              SizedBox(height: 5.v)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        }),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  String? image_path;
  Future<void> _pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      String url = image_upload; // Replace with your API endpoint
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(url),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // The name field in form-data
          image.path,
        ),
      );
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var imagepath = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        print(imagepath['message']);
        print('Image uploaded successfully!');
        // Handle the response
        SharedPreferences preff = await SharedPreferences.getInstance();
        preff.setString('image', imagepath['message']);
        showToast('Profile Image Updated');
        setState(() {
          image_path = "/" + preff.getString('image').toString();
          print(image_path);
        });
      } else {
        showToast('Image upload failed with status: ${response.isRedirect}');
        // Handle the error
      }
    } else {
      showToast('No image selected.');
    }
  }

  /// Section Widget
  Widget _buildUsernameSection(BuildContext context) {
    return SizedBox(
      height: 340.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 89.h,
                vertical: 90.v,
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(100, 50),
                      bottomLeft: Radius.elliptical(100, 50))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 10.v),
                  SizedBox(
                    width: 380.h,
                    child: Text(
                      "User Name",
                      style: theme.textTheme.displayMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15.v),
          Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 150.v,
                    width: 120.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.h,
                      vertical: 7.v,
                    ),
                    decoration: AppDecoration.outlineBlack.copyWith(
                        //borderRadius: BorderRadiusStyle.roundedBorder52,
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: image_path.toString() != '/null'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(80.0),
                            child: Image.network(
                              '$url/image/user/profile' + image_path.toString(),
                              fit: BoxFit.fill,
                              height: 130.v,
                              width: 116.h,
                            ),
                          )
                        : CustomImageView(
                            imagePath: ImageConstant.username,
                            height: 74.v,
                            width: 68.h,
                            color: Colors.green,
                            alignment: Alignment.center,
                          ),
                    /* IconButton(
                      onPressed: () {
                        _pickAndUploadImage();
                        //.then((value) => image(token.toString()));
                        /*  _imagepath != null
                            ? image(token.toString())
                            : showToast("Please seelect Image");*/
                      },
                      icon: Icon(Icons.edit)),*/
                    /* child: CustomImageView(
                  imagePath: ImageConstant.username,
                  height: 74.v,
                  width: 68.h,
                  color: Colors.green,
                  alignment: Alignment.topCenter,
                ),*/
                  ),
                  IconButton(
                      onPressed: () {
                        _pickAndUploadImage();
                        //.then((value) => image(token.toString()));
                        /*  _imagepath != null
                            ? image(token.toString())
                            : showToast("Please seelect Image");*/
                      },
                      icon: Icon(Icons.edit)),
                ],
              ))
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildVuesaxlinearSection(
      BuildContext context, String city, String pincode) {
    return Container(
      width: 480.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 220.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 40.h,
                    right: 34.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.address,
                        height: 34.v,
                        width: 29.h,
                        color: Color.fromRGBO(48, 60, 122, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(city,
                              style: theme.textTheme.titleLarge!
                                  .copyWith(fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 10.h,
                  endIndent: 10.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Container(
            width: 210.h,
            child: Column(
              children: [
                Text(
                  pincode,
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 15),
                ),
                Divider(
                  indent: 10.h,
                  endIndent: 10.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
