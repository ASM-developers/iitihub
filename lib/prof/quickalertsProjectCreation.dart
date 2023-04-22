//alert relate package
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';


Card buildButton({
  required onTap,
  required title,
  required text,
  required leadingImage,
}) { return Card(
  shape: const StadiumBorder(),
  margin: const EdgeInsets.symmetric(
    horizontal: 20,
  ),
  clipBehavior: Clip.antiAlias,
  elevation: 1,
  child: ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundImage: AssetImage(
        leadingImage,
      ),
    ),
    title: Text(title ?? ""),
    subtitle: Text(text ?? ""),
    trailing: const Icon(
      Icons.keyboard_arrow_right_rounded,
    ),
  ),
);  }

bool checkempty(String projname,String projdes,List<String> tags,String date1){

  if(projname.length == 0
      ||projdes.length ==0
      ||tags.length ==0
      ||date1.length == 0 ){
    return true;
  }
  return false ;
}

void qa_nameAlreadyExists(BuildContext context){
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    text: 'Project Name is already Taken',
    autoCloseDuration: const Duration(seconds: 5)
  );
}

void qa_successMsg(BuildContext context, String projname,String projdes,List<String> tags,String date1)
{
  QuickAlert.show(
    width: 5,

    context: context,
    type: QuickAlertType.success,
    text: '\nName: $projname \nDescp: $projdes \nTags: $tags \nDate: $date1 ',
    autoCloseDuration: const Duration(seconds: 20),
  );

}
