function count_visits_SP() {
    if (localStorage.visit_count_SP) {
        localStorage.visit_count_SP = Number(localStorage.visit_count_SP) + 1;
    } else {
        localStorage.visit_count_SP = 1;
    }
}
function count_visits_MP() {
    if (localStorage.visit_count_MP) {
        localStorage.visit_count_MP = Number(localStorage.visit_count_MP) + 1;
    } else {
        localStorage.visit_count_MP = 1;
    }
}
function count_visits_Esp() {
    if (localStorage.visit_count_Esp) {
        localStorage.visit_count_Esp = Number(localStorage.visit_count_Esp) + 1;
    } else {
        localStorage.visit_count_Esp = 1;
    }
}

function count_hovers_SP() {
    if (sessionStorage.hover_count_SP) {
        sessionStorage.hover_count_SP = Number(sessionStorage.hover_count_SP) + 1;
    } else {
        sessionStorage.hover_count_SP = 1;
    }
}
function count_hovers_MP() {
    if (sessionStorage.hover_count_MP) {
        sessionStorage.hover_count_MP = Number(sessionStorage.hover_count_MP) + 1;
    } else {
        sessionStorage.hover_count_MP = 1;
    }
}
function count_hovers_Esp() {
    if (sessionStorage.hover_count_Esp) {
        sessionStorage.hover_count_Esp = Number(sessionStorage.hover_count_Esp) + 1;
    } else {
          sessionStorage.hover_count_Esp = 1;
    }
}

function light_mode(backgColor, textColor) {
    var background = document.getElementById('content').style.backgroundColor = backgColor;
    var text = document.getElementById('content').style.color = textColor;
}
function dark_mode(backgColor, textColor) {
    var background = document.getElementById('content').style.backgroundColor = backgColor;
    var text = document.getElementById('content').style.color = textColor;
}

function light_mode3(backgColor, textColor) {
    var background = document.getElementById('content3').style.backgroundColor = backgColor;
    var text = document.getElementById('content3').style.color = textColor;
}
function dark_mode3(backgColor, textColor) {
    var background = document.getElementById('content3').style.backgroundColor = backgColor;
    var text = document.getElementById('content3').style.color = textColor;
}

function javalink() {
    var a = document.createElement('a');
    var linkText = document.createTextNode("Some of the best JavaScript games");
    a.appendChild(linkText);
    a.href = "https://tutorialzine.com/2019/02/10-amazing-javascript-games";
    document.getElementById("content").appendChild(a);
    document.getElementById("javabtn").disabled = 'true';
}

$(document).ready(function () {
    $("#GSP").click(function () {
        event.preventDefault();
        $(".Esports").hide();
    });
    $("#GSP").click(function () {
        event.preventDefault();
        $(".MultiP").hide();
    });
    $("#GMP").click(function () {
        event.preventDefault();
        $(".SingleP").hide();
    });
    $("#GMP").click(function () {
        event.preventDefault();
        $(".Esports").hide();
    });
    $("#GEsp").click(function () {
        event.preventDefault();
        $(".MultiP").hide();
    });
    $("#GEsp").click(function () {
        event.preventDefault();
        $(".SingleP").hide();
    });
    $("#GEsp").click(function () {
        event.preventDefault();
        $(".Esports").show();
    });
    $("#GSP").click(function () {
        event.preventDefault();
        $(".SingleP").show();
    });
    $("#GMP").click(function () {
        event.preventDefault();
        $(".MultiP").show();
    });
    $("#G3").click(function () {
        event.preventDefault();
        $(".Esports").show();
    });
    $("#G3").click(function () {
        event.preventDefault();
        $(".SingleP").show();
    });
    $("#G3").click(function () {
        event.preventDefault();
        $(".MultiP").show();
    });
});

$(document).ready(function () {
    $(document).tooltip({
        position: {
            my: "center bottom-20",
            at: "center top",
            using: function (position, feedback) {
                $(this).css(position);
                $("<div>")
                    .addClass("arrow")
                    .addClass(feedback.vertical)
                    .addClass(feedback.horizontal)
                    .appendTo(this);
            }
        }
    });
});

$(document).ready(function () {
    var availableTags = [
        "Minecraft",
        "Fortnite",
        "PUBG",
        "Player Unknown's Battlegrounds",
        "Among Us",
        "Roblox",
        "Dota 2",
        "The Legend of Zelda: Breath of the Wild",
        "Tetris",
        "Team Fortress 2",
        "Fall Guys",
        "Halo",
        "Forza Horizon 4",
        "Portal",
        "Portal 2",
        "Candy Crush",
        "Half-Life 2",
        "Half-Life",
        "Half-Life 3",
        "Borderlands 2",
        "Borderlands 3",
        "Mario Kart"
    ];
    $("#tags").autocomplete({
        source:availableTags
    });
});