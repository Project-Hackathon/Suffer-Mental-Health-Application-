document.addEventListener('DOMContentLoaded', () => {
})
function submitcontactform(){
    let name = document.querySelector("#name");
    let email = document.querySelector("#email");
    let message = document.querySelector("#message");
    let subject = document.querySelector("#subject");
    let alertdiv = document.querySelector("#alerts");
    if(name.value.length === 0 || email.value.length === 0 || subject.value.length === 0 || message.value.length === 0)
    {
        alertdiv.innerHTML = "Pls fill the full Form";
        alertdiv.style.color = 'red'
    }
    else
    {
        fetch('/contactform', {
            method: 'POST',
            body: JSON.stringify({
                name: name.value,
                email: email.value,
                subject: subject.value,
                message: message.value
            })
        })
            .then(response=> response.json())
            .then(result => {
                alertdiv.innerHTML = `${result.message}`;
                alertdiv.style.color = 'Green';
                name.value = "";
                email.value = "";
                subject.value = "";
                message.value = "";
            })
    }
}

function addform(div, button){
    let blogfromdiv = div.querySelector("#addblogform");
    if(blogfromdiv.innerHTML === "") {
        button.className = "btn btn-danger";
        button.innerHTML = "Discard";
        blogfromdiv.innerHTML = `
            <div id="messages"></div>
            <div class="row" style="margin-top: 20px; margin-bottom: 10px;">
                <div class="col-md-6 form-group">
                    <input type="text" id="heading" placeholder="Heading" class="form-control">
                </div>
                <div class="col-md-6 form-group">
                    <input type="text" id="shortdesc" placeholder="Short Description" class="form-control">
                </div>
            </div>
            <div class="form-group" style="margin-bottom: 10px;">
                <textarea class="form-control" rows="10" id="blogdata" placeholder="Write your thoughts here..."></textarea
            </div>
            <br>
            <button class="btn btn-primary" onclick="publishblog(this)">Publish</button>
        `
    }
    else
    {
        button.className = "btn btn-success";
        button.innerHTML = "Write Blog";
        blogfromdiv.innerHTML = "";
    }
}

function publishblog(button){
    let blogfromdiv = document.querySelector("#addblogform");
    let heading = document.querySelector("#heading")
    let shortdesc = document.querySelector("#shortdesc")
    let blogdata = document.querySelector("#blogdata")
    if(heading.value.length === 0 || shortdesc.value.length === 0 || blogdata.value.length === 0)
    {
        let div = button.parentNode.querySelector("#messages");
        div.style.color = 'red';
        div.innerHTML = "Enter all the fields before submitting the form."
    }
    else
    {
        fetch('/getcurruser')
            .then(response => response.json())
            .then(result => {
                fetch('/blogapiurl', {
                    method: 'POST',
                    body: JSON.stringify({
                        owner: result.message,
                        header: heading.value,
                        shortdesc: shortdesc.value,
                        blogdata: blogdata.value
                    })
                })
                    .then(response=> response.json())
                    .then(result2 => {
                        blogfromdiv.innerHTML = ""
                        let button2 = document.querySelector('#writeblog');
                        button2.innerHTML = "Write Blog";
                        button2.className = "btn btn-success"
                        let msg = document.querySelector('#blogmessages');
                        msg.innerHTML = `${result2.message}`
                    })
            })

    }

}

function registerapitest(){
    fetch('/resigterapi', {
        method: 'post',
        body: JSON.stringify({
            email: "example@gmail.com",
            password: "example",
            name: "example"
        })
    })
        .then(response => response.json())
        .then(result => {
            console.log(result.message);
        })
}
function loginapitest(){
    fetch('/loginapi', {
        method: 'post',
        body: JSON.stringify({
            email: "example@gmail.com",
            password: "example"
        })
    })
        .then(response => response.json())
        .then(result => {
            console.log(result.message);
        })
}
