import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginScreen.dart';
import 'MainDrawer.dart';
class Contributions extends StatefulWidget {
  final data;
  Contributions(this.data);

  @override
  _ContributionsState createState() => _ContributionsState();
}

class _ContributionsState extends State<Contributions> {

  Function progress = (rankCode, rank) {
    
    for (int i = 0; i < rankCode.length; i++) {
      if (rank < rankCode[i]) return i;
    }
  };
  // var rank=progress(widget.data['contributionsCollection']['contributionsCalendar']['totalContributions']);
  var rank;
  var totalContributions;
  var rankCode;
  var repoCount;
  var commits;
  var totalYears;
  var pullRequests;
  var issueContribution;
  var repoContribution;
  @override
  void initState() {
    super.initState();
    issueContribution = widget.data['contributionsCollection']
        ['issueContributions']['totalCount'];
    repoContribution =
        widget.data['contributionsCollection']['totalRepositoryContributions'];
    rankCode = [200, 400, 600, 800, 1000, 1200,8000];
    pullRequests = widget.data['contributionsCollection']
        ['pullRequestContributions']['totalCount'];
    commits =
        widget.data['contributionsCollection']['totalCommitContributions'];
    totalContributions = widget.data['contributionsCollection']
        ['contributionCalendar']['totalContributions'];
    rank = totalContributions>1200?6:progress(rankCode, totalContributions);
    repoCount = widget.data["repositories"]["totalCount"];
    totalYears = widget.data['contributionsCollection']['contributionYears'];
    print(totalYears[0]);
  }
  
  Widget build(BuildContext context) {
    var heightSize =MediaQuery.of(context).size.height- AppBar().preferredSize.height;

    return Container(
      height: heightSize,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: heightSize* 0.40,
              width: MediaQuery.of(context).size.width,
              // color: Colors.blue,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                    Colors.deepPurple[900],
                    Colors.purple[100],
                  ],
                      stops: [
                    0.0,
                    1.0
                  ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      tileMode: TileMode.repeated)),
            ),
          ),
          Column(
            children: [
              
              
              
              Center(
                child: Container(
                  height: heightSize*0.95,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: heightSize* 0.3,
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.purple[50],
                              child: Column(
                                children: [
                                  Container(
                                    height:heightSize *
                                        0.25,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: ClipOval(

                                                    child: Image.network(
                                                      
                                                      widget.data["avatarUrl"],
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      fit: BoxFit.cover,
                                                      height: 100.0,
                                                      width: 100.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, top: 30),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  widget.data[
                                                                      'name'],
                                                                  style: GoogleFonts
                                                                      .carterOne(
                                                                          fontSize:
                                                                              20),
                                                                )),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: 
                                                              rank>1200?
                                                              Text(
                                                                  'Legend',
                                                                  style: GoogleFonts
                                                                      .carterOne(
                                                                          fontSize:
                                                                              12)):
                                                                Text(
                                                                  'Rookie',
                                                                  style: GoogleFonts
                                                                      .carterOne(
                                                                          fontSize:
                                                                              12))            

                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  'Total Contribution: $totalContributions',
                                                                  style: GoogleFonts
                                                                      .autourOne(
                                                                          fontSize:
                                                                              12),
                                                                )),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                'Total Repositories: $repoCount',
                                                                style: GoogleFonts
                                                                    .autourOne(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: SingleChildScrollView(
                                              child: Row(
                                                children: [
                                                  Text('Rating: ',
                                                      style: GoogleFonts
                                                          .autourOne(
                                                              fontSize: 18)),
                                                  ...star(rank),
                                                ],
                                              ),
                                            ),
                                          ),
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                  ProgressBar(
                                      totalContributions, rankCode[rank]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        '($totalContributions/${rankCode[rank]})',
                                        style: GoogleFonts.autourOne(
                                            fontSize: 14),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Years Contributed',
                              style: GoogleFonts.carterOne(fontSize: 20),
                            ),
                          ),
                        ),
                        //  SingleChildScrollView(child: YearsContributed(totalYears)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                                                  child: Row(
                            children: [
                              ...years(totalYears, context),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Contribution Weightage',
                              style: GoogleFonts.carterOne(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height:heightSize* 0.35,
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.purple[50],
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Commits',
                                        style: GoogleFonts.autourOne(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ProgressBar(commits, totalContributions),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          '($commits/$totalContributions)',
                                          style: GoogleFonts.autourOne(
                                              fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Pull Requests',
                                        style: GoogleFonts.autourOne(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ProgressBar(
                                          pullRequests, totalContributions),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          '($pullRequests/$totalContributions)',
                                          style: GoogleFonts.autourOne(
                                              fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Repo Contribution',
                                        style: GoogleFonts.autourOne(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ProgressBar(
                                          repoContribution, totalContributions),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          '($repoContribution/$totalContributions)',
                                          style: GoogleFonts.autourOne(
                                              fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Issues Contribution',
                                        style: GoogleFonts.autourOne(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ProgressBar(issueContribution,
                                          totalContributions),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          '($issueContribution/$totalContributions)',
                                          style: GoogleFonts.autourOne(
                                              fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final green;
  final grey;
  ProgressBar(this.green, this.grey);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.01,
            color: Colors.grey,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8 * (green / grey),
            height: MediaQuery.of(context).size.height * 0.01,
            color: Colors.green,
          ),
        )
      ],
    );
  }
}

List<Widget> star(num) {
  List starRating = new List<Widget>();
  for (var i = 0; i <= num; i++) {
    starRating.add(Icon(Icons.star, color: Colors.orange));
  }
  return starRating;
}

List<Widget> years(year, context) {
  List yearList = new List<Widget>();
  for (var i = 0; i < year.length; i++) {
    yearList.add(Padding(
      padding: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.1,
          color: Colors.lime[100],
          child: Center(
              child: Text(
            year[i].toString(),
            style: GoogleFonts.autourOne(fontSize: 18),
          )),
        ),
      ),
    ));
  }
  return yearList;
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
   Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 10, size.height, 
  size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
