$(document).ready(function(){
  highlightCurrentTab();  
});

function highlightCurrentTab()
{
  var location = window.location.pathname;
  var className = "current_page_item";
  $.each($("#menu ul li"), function(index, value){$(value).removeClass(className)});
  if(location === "/ideas/new")
    {
      $("#register_link").addClass(className)
      return;
    }
    if(location === "/ideas")
      {
        $("#ideas_link").addClass(className)
        return;
      }
      if(location === "/")
        {
          $("#main_link").addClass(className)
          return;
        }
}
