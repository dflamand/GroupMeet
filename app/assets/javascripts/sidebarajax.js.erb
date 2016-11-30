

function load_group()
{
  $(document).ready(function(){
    var $users = $("#userbox");
    var $kickcand = $("#kicklist");
    $users.empty();
    $kickcand.empty();
    var groupid = $("#user_group_ids").val();
    console.log("GROUPIDFOUND", groupid);
    $(function(){
      $.ajax({
        type: 'GET',
        url: '/groups/'+groupid,
        dataType: "json",
        success: function(users){
          console.log('success', users);
          $.each(users, function(i, user){
            $users.append("<li class=\"user" + user.id + "\">Name:" + user.firstName + " " + user.lastName + " | Email:" + user.email + "</li>");
            $kickcand.append("<option class=\"user" + user.id + "\" value=" + String(user.id) + ">" + user.email + "</option>" );

            //$("#kickusers")
          });
        },
        error: function(data){
          console.log("fail", data);
        }

      });
    });
  });
}



$(document).ready(function(){
  $("#user_group_ids").change(function(){
    //Groupid is set to the value of the option in the dropdown. This should be the corresponding groupid
    load_group();
  });
});

/*$(document).ready(function(){
  $("#adduserbutton").click(function()
  {
    var $users = $("#userbox");
    var $kickcand = $("#kicklist");
    var addusers = [];
    var groupid = $("#user_group_ids").val();
    $("#selectaddusers > option").each(function(i){
      if(this.selected == true){
        addusers.push(this.value);
      }

    });
    $.ajax({
      type: "POST",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: "/adduser",
      dataType: "json",
      data: {addusers:addusers, groupid: groupid},
      success: function(users){
        $.each(users, function(i, user){
          $users.append("<li class=\"user" + user.id + "\">Name:" + user.firstName + " " + user.lastName + " | Email:" + user.email + "</li>")
          $kickcand.append("<option class=\"user" + user.id + "\" value=" + String(user.id) + ">" + user.email + "</option>" );
        });
        console.log("Success", users);
      },
      error: function(users){
        console.log("Error", users);
      }
    });
  });
});*/

$(document).ready(function(){
  $("#kickbutton").click(function()
  {
    var $users = $("#userbox");
    var $kickcand = $("#kicklist");
    var groupid = $("#user_group_ids").val();
    var userid = $("#kicklist").val();
    $.ajax({
      type: "DELETE",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: "/removeuser",
      dataType: "json",
      data: {userid: userid, groupid: groupid},
      success: function(user){
        $(".user"+String(user.id)).remove();
          //$kickcand.remove("#user"+String(userid));
        console.log("Success", user);
      },
      error: function(user){
        console.log("Error", user);
      }
    });
  });
});

$(document).ready(function(){
  $("#adduserbutton").click(function()
  {
    var groupid = $("#user_group_ids").val();
    var useremail = $("#adduserbox").val();
    $("#adduserbox").val("");
    $.ajax({
      type: "POST",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: "/invited",
      dataType: "json",
      data: {invite: {user_email: useremail, group_id: groupid}},
      success: function(resp){
        console.log("Success", resp);
      },
      error: function(resp){
        console.log("Error", resp);
      }
    });
  });
});

$(document).ready(function(){
  $(".invite-links").on("click", function(){
    var id = this.id;
    $("#ig_"+id).remove();
  });
});


function loadpages()
{
  $(document).ready(function(){
    $("#loginholder").load("/login").hide();
    $("#regholder").load("/signup").hide();
  });
}
