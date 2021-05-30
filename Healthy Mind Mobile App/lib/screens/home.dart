import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:healthy_mind/screens/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Healthy-Mind'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                })
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The Health Mind brings you the best platform where you not only find the best consultancy for all your problems by best-trained and renowned counselors but also a community to help and develop with all your mates.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'FAQ\'s',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Faq(
                question: 'What causes depression?',
                answer:
                    'There are lots of reasons why someone might feel depressed, but sometimes there isn’t any obvious reason. It can be caused by a difficult life event.'),
            Faq(
                question:
                    'How can I tell if someone has a mental health problem?',
                answer:
                    'If someone has bipolar disorder, they may show significant mood swings, or appear more withdrawn if they are dealing with self-harm or negative thoughts.'),
            Faq(
                question:
                    'How can I speak to and help someone with a mental health problem like depression or anxiety?',
                answer:
                    'Encourage them to seek help, Don’t be afraid to bring it up, Don’t blame them, Be patient and Look after yourself.'),
            Faq(
                question: 'What do I do if it is an emergency?',
                answer:
                    'It’s essential that services are able to respond when people reach out; from early treatment to help people manage their mental health problems as soon as possible.'),
            Faq(
                question: 'What is a personality disorder?',
                answer:
                    'The word ‘personality’ refers to the pattern of thoughts, feelings and behaviour that makes each of us the individuals that we are. These affect the way we think, feel and behave towards others and ourselves.'),
          ]),
        ));
  }
}

class Faq extends StatelessWidget {
  final String question;
  final String answer;

  const Faq({Key key, @required this.question, @required this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(question,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                collapsed: null,
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          answer,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
