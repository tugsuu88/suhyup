//달력 생성2
function Calendar( obj_date )
{
	var result = "false";
	result = window.showModalDialog('../js/calendar.html','달력','dialogWidth:190px;dialogHeight:235px; center:yes; help:no; status:no; scroll:no; resizable:no');
	if( result == null )
        return;

    if( result.length != 3 )
        return;
	obj_date.value = result[0] + result[1] + result[2];
}

function compareDt(startDt,endDt){
  sDt = startDt.replace(/-/g,"");
  eDt = endDt.replace(/-/g,"");

  if (sDt>eDt) {
    return false;
  } else {
    return true;
  }
}

function CheckSpecialChar(str, special_char)
{
	var flag = true;

	for(i = 0; i <= str.length;  i++)
	{
		ch = str.charAt(i);
		for(j = 0; j < special_char.length; j++)
		{
			if(ch == special_char.charAt(j))
			{  
				flag = false;
				break;
			}
		}
		if(flag == false)
			break;
	}
	return flag;
}
