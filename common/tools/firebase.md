
# Deleting Bulk Users in Firebase via Console
* There is no functionality to bulk delete authentication users in Firebase. So this script has been written to accomplish this task.
```
var elements = [];
$('.a12n-users-table').find('tr').each(function(r){
    $(this).find('td.table-row-actions').each(function(tds) {
        $(this).find('button').each(function(x){
            if($(this).attr('aria-label')=="Delete account"){
                elements.push($(this));
            }
        });
    });
});

var index = 0;
function deleteUser(){
    index++;
   elements[index].click();
   $('.fb-dialog-actions').find('.md-warn').click();
   setTimeout(deleteUser, 5000); 
}
deleteUser();

```
## How to
* Open Firebase user authentication page and open developer console in browser. Then run above code in the console.