import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OptionWidget extends StatelessWidget {
  final String optionName;
  final IconData icon;
  final Function navigation;
  OptionWidget(this.optionName,this.icon,this.navigation);
  @override
  Widget build(BuildContext context) {
    return Material(
                        child: InkWell(
                          onTap: navigation,
                          splashColor: Colors.purple[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Row(
                                children: [
                                  Icon(icon,size: 26,),
                                  SizedBox(width: 14,),
                                  Text(
                                    '$optionName',
                                    style: GoogleFonts.autourOne(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
  }
}