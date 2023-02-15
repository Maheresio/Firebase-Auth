String replaceCharAt(String oldString, int index, String newChar) {
  if(newChar=='')
    {
      newChar='1';
    }
  return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
}