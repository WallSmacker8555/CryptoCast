function getRegData() {
    let hash = 0;
    var info = document.getElementById("reg_info");
    var id;
    for (let i = 0; i < info.length; i++) {
        if (i == 7) {
            id = info[i].value;
        }
        console.log(info[i]);
    }
    for (let j = 0; j < id.length; j++) {
        char = id.charCodeAt(j);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash;
    }
    console.log(hash)
}