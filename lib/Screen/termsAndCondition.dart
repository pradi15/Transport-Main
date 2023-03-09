

import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  // get give => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: prefer_const_literals_to_create_immutables
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  """Your contract starts from the day you enroll, not from the day you get your permit. Be sure to take your lessons within the specified amount of time. Do not let your contract expire. If you are unable to get your permit, call us before the expiration date so that we can give you an extensionthe lesson with another studentPlease be aware that if the student does not show up for the lesson, you will be responsible for the cancellation fee. You will need to contact our office to let us know which student will be taking your lesson.All questions must be directed to the office. Driver instructors will refer you back to the office unless the question is about the students lesson performance.For specific lesson performance questions, please make sure that you contact us as soon as possible after the lesson.
                    The student may be in the company car when purchasing gasoline from COSTCO. This will be part of the lesson and we will teach the students how to properly fuel the vehicle.
                    If we are late picking up the student, the student will get the full 2 hours driving from pick up time. The lesson may sometimes go over two hours depending on traffic and how far the next student pickup address is.
                    No one is allowed in our vehicles during driving lessons except for the students and instructors.
                    At the end of a driving lesson, we pick up the next student before we drop off the current student. This is the only time that another student will be in the vehicle during the lesson.
                    We teach students defensive driving. Their ability to learn within the six (6) hour period may vary depending on the student’s abilities. The DMV requires any minors taking the driving test to complete a minimum of 50 hours of driving before they can take the test. We urge parents to practice as much as possible with their children. See the DMV issued Parent-Teen Training Guide for reference.
                    Safety first, always! Therefore, freeway driving is not mandatory and is left to the instructor’s discretion.
                    Students/Parents/Guardians/Customers are responsible for any damage or graffiti caused by students, to our vehicles or property.
                    No refunds for any used lessons.
                    No refunds for the drive test package.
                    Requirements for obtaining a permit or driver license are subject to change. For the latest requirements in attaining a permit or license, please visit the DMV website at: www.DMV.CA.Gov
                    During our busier times, our first availability could be two weeks or more.
                    We reserve the right to refuse service to anyone.
                    For the safety and security of the students, instructors and others, there may or may not be video surveillance at the driving school and in company vehicles.
                    Two hours of continual driving is a long time for any new driver to be on the road. For this reason, we may take up to 10 minutes to allow the student and instructor to get some relief and clear their heads so that they can continue to learn to drive safely.
                    There is a minimum requirement to have at least 5 students to be enrolled in the In-Class Driver Education Course. If at least 5 students are not enrolled then the scheduled class can be cancelled and rescheduled for a later time.""",
                  textAlign: TextAlign.justify,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
