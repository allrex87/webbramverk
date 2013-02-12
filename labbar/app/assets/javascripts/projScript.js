$(function(){

    //Om browsern st�djer localstorage.
    if (Modernizr.localstorage) {
        //N�r documentet �r f�rdigladdat.
        
        $(function () {

            //Everytime you blur away from form??
            //Varje g�ng man avmarkerar ett f�lt i formul�ret.
            $("#proj_user_button").click(function () {

				var data = $(".member").serializeArray();
                //S�tter en flagga som talar om att localstorage �r satt.
                localStorage.setItem("flag", "set")
            });

            //Om det finns n�got i localstorage, s� fylls v�rden i formul�ret, och anv�ndaren erh�ller meddelande.
            if (localStorage.getItem("flag") == "set")
            {
                $('.proj_users').append('Det h&auml;r formul&auml;ret har sparat data, det har fyllts i automatiskt. F&ouml;r att ta bort sparad data tryck p&aring; rensa formul&auml;r');

                var data = $("#crudForm").serializeArrasy();

                $.each(data, function (i, obj) {
                    //Vi ska fylla i v�rden f�r allt utom dropdown list.
                    if (obj.name != "Event.eventTypeID") {
                        $("[name='" + obj.name + "']").val(localStorage.getItem(obj.name));
                    }
                });
            }

            //Clear all the data from lacalstorageand reset prefilled values.
            //N�r anv�ndaren v�ljer att rena formul�ret s� resas meddelande f�rifyllda v�rden och localstorage.
            $("#clearCrudForm").click(function (e) {
                localStorage.clear();
                $(".info").text("");
                $("#crudForm").each(function () {
                    this.reset();
                });
            });
        });
    }
    else
    {
    	$('.proj_users').append('Du kan inte lägga till några medlemmar just nu, du behöver använda en annan browser');
    }

});
