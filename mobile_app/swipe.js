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

function stateChange() {
    switch (state) {
        case "slika1":
            document.getElementById("slika1").style.display = "None";
            state = "slika2";
            break;
        case "slika2":
            document.getElementById("slika2").style.display = "None";
            state = "slika3";
            break;
        case "slika3":
            document.getElementById("slika3").style.display = "None";
            state = "slika4";
            break;
        case "slika4":
            document.getElementById("slika4").style.display = "None";
            state = "slika5";
            break;
    }
}

function proceed() {
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
        stateChange();
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

