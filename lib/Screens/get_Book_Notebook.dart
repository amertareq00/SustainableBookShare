import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/models/book_model.dart';
import 'package:sbs_prototype/models/user_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GetBookNotebook extends StatefulWidget {
  const GetBookNotebook({Key? key}) : super(key: key);

  @override
  _GetBookNotebookState createState() => _GetBookNotebookState();
}

class _GetBookNotebookState extends State<GetBookNotebook> {
  late int id;
  late Future<List<dynamic>> _dataFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final bookId = args['bookId'];
    final bookEmail = args['bookEmail'];

    _dataFuture = Future.wait([
      BookModel.getBookById(bookId),
      UserModel.getUserByemail(bookEmail),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/homepage');
            //_auth.checkCurrentUser(context);
          },
          child: const Text(
            'SBS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Color(0xFF222831),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.of(context).pushReplacementNamed('/signin');
            //Navigator.of(context).pushReplacementNamed('/homepage');
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF222831),
      endDrawer: CustomEndDrawer(),

      /// from enddrawer class
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final BookModel book = snapshot.data![0];
            final UserModel user = snapshot.data![1];

            return SingleChildScrollView(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFEEEEEE),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (book.image != null && book.image!.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: book.image != null
                                          ? Image.network(book.image!)
                                          : Container(),
                                      // Show nothing if image is not selected
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFF222831),
                            child: ClipOval(
                              child: SizedBox(
                                width: 100, // Adjust width as needed
                                height: 100, // Adjust height as needed
                                child:
                                    book.image != null && book.image!.isNotEmpty
                                        ? Image.network(book.image!,
                                            fit: BoxFit.cover)
                                        : Icon(
                                            Icons.image,
                                            size: 55,
                                            color: Color(0xFF76ABAE),
                                          ), // Adjust icon size as needed
                              ),
                            ),
                          ),
                        ),

                        // image code
                        const SizedBox(width: 20.0),
                        Text(
                          book.bookName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222831),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        //color: Colors.yellow,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF76ABAE).withOpacity(0.9),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 20),

                        child: Text(
                          '${book.type} In a ${book.bookCondition} Condition',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222831),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${book.type} Owner: ${user.firstName} ' +
                            '${user.lastName}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222831),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Faculty: ${book.facultyName}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222831),
                          //decoration:
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    book.donate
                        ? Text(
                            'For Free (Donate)',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222831),
                            ),
                          )
                        : Text(
                            'Price: ${book.price} JD',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222831),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    //if (book.description.toString().isEmpty)
                    book.description.toString().isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.0),
                              Text(
                                'Description:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF222831),
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                width: 340,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF222831)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  book.description.toString(), // from db
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xFF31363F),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          )
                        : Container(),
                    Center(
                      child: CustomButton(
                        buttonText: null,
                        width: 300,
                        color: Colors.black,
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _launchTelePhoneNumber(user.phone);
                        },
                      ),
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          buttonText: null,
                          icon: Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          ),
                          width: 150,
                          color: Color(0xFF25d366),
                          onPressed: () {
                            _launchWhatsAppWithPhoneNumber(user.phone);
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomButton(
                          buttonText: null,
                          icon: SvgPicture.asset(
                            'assets/microsoftteams.svg',
                            width: 25,
                            height: 25,
                            color: Colors.white,
                          ),
                          width: 150,
                          color: Color(0xFF4E5FBF),
                          onPressed: () {
                            _launchTeamsWithEmail(book.email);
                          },
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('ss'),
              //BookCard(book: book),
            );
          }
        },
      ),
    );
    //);
  }

  _launchTeamsWithEmail(String email) async {
    try {
      await launchUrlString(
          'https://teams.microsoft.com/l/chat/0/0?users=$email');
    } catch (e) {
      CustomToastMessage(message: 'Error While Launching Teams');
    }
  }

  _launchWhatsAppWithPhoneNumber(String phoneNumber) async {
    phoneNumber = "962" + phoneNumber.substring(1);
    try {
      await launchUrlString(
          'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeFull("")}');
    } catch (e) {
      CustomToastMessage(message: 'Error While Launching WhatsApp');
    }
  }

  _launchTelePhoneNumber(String phoneNumber) async {
    try {
      await launchUrlString('tel:$phoneNumber');
    } catch (e) {
      CustomToastMessage(message: 'Error While Launching WhatsApp');
    }
  }
}
