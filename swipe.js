document.addEventListener('touchstart', handleTouchStart, false);
document.addEventListener('touchmove', handleTouchMove, false);


state = "slika1"

var xDown = null;
var yDown = null;

function getTouches(evt) {
    return evt.touches ||
        evt.originalEvent.touches;
}

function handleTouchStart(evt) {
    const firstTouch = getTouches(evt)[0];
    xDown = firstTouch.clientX;
    yDown = firstTouch.clientY;
};

function stateChange(side) {
    switch (state) {
        case "slika1":
            myLeft = $(document.getElementById("slika1")).css("left")
            $(document.getElementById("slika1")).animate({
                left: side
            }, 500, function () {
                document.getElementById("slika1").style.display = "None";
            });
            state = "slika2";
            break;
        case "slika2":
            myLeft = $(document.getElementById("slika2")).css("left")
            $(document.getElementById("slika2")).animate({
                left: side
            }, 500, function () {
                document.getElementById("slika2").style.display = "None";
            });
            // document.getElementById("slika2").style.display = "None";
            state = "slika3";
            break;
        case "slika3":
            myLeft = $(document.getElementById("slika3")).css("left")
            $(document.getElementById("slika3")).animate({
                left: side
            }, 500, function () {
                document.getElementById("slika3").style.display = "None";
            });
            // document.getElementById("slika3").style.display = "None";
            state = "slika4";
            break;
        case "slika4":
            myLeft = $(document.getElementById("slika4")).css("left")
            $(document.getElementById("slika4")).animate({
                left: side
            }, 500, function () {
                document.getElementById("slika4").style.display = "None";
            });
            // document.getElementById("slika4").style.display = "None";
            state = "slika5";
            break;
    }
}

function proceed(s) {
    stateChange();
}

function handleTouchMove(evt) {
    if (!xDown || !yDown) {
        return;
    }

    var xUp = evt.touches[0].clientX;
    var yUp = evt.touches[0].clientY;

    var xDiff = xDown - xUp;
    var yDiff = yDown - yUp;

    if (Math.abs(xDiff) > Math.abs(yDiff)) {
        if (xDiff > 0) {
            stateChange("-=100");
        } else {
            stateChange("+=100");
        }

    } else {
        if (yDiff > 0) {
            /* down swipe */
        } else {
            /* up swipe */
        }
    }
    /* reset values */
    xDown = null;
    yDown = null;
};

