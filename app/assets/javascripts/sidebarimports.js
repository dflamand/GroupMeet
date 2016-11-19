$(document).ready(function(){
  $("#user_group_ids").change(function(){
    alert(this.options[this.selectedIndex].val);
    var groupid = $("#user_group_ids").val();
    console.log("GROUPIDFOUND", groupid);
    $(function(){
      $.ajax({
        type: 'GET',
        url: '/groups/'+groupid,
        dataType: "json",
        success: function(data){
          console.log('success', data);
        },
        error: function(data){
          console.log("fail", data);
        }

      });
    });
  });
});

$("#new_group").submit(function()
{
  $("#Group-Modal").modal('toggle');
});

function loadpages()
{
  $(document).ready(function(){
    $("#loginholder").load("/login").hide();
    $("#regholder").load("/signup").hide();
  });
}



function togglelogin()
{
  $(document).ready(function(){
    var login = document.getElementById("loginbutton");
    if(login.value == "off")
    {
      login.textContent = "Minimize";
      $("#loginholder").slideDown();
      login.value = "on";
    }

    else if(login.value == "on")
    {
      login.textContent = "Login";
      $("#loginholder").slideUp();
      login.value = "off";
    }
  });

}

function togglereg()
{
  var reg = document.getElementById("regbutton");
  if(reg.value == "off")
  {
    $("#regholder").slideDown();
    reg.value = "on";
  }

  else if(reg.value == "on")
  {
    $("#regholder").slideUp();
    reg.value = "off";
  }
}
