function formatAll(time) {
    var value=new Date(parseInt(time));
    var year=value.getFullYear();
    var month=value.getMonth()+1>9?value.getMonth()+1:"0"+(value.getMonth()+1);
    var day=value.getDate()>9?value.getDate():"0"+value.getDate();
    var hour=value.getHours()>9?value.getHours():"0"+value.getHours();
    var minute=value.getMinutes()>9?value.getMinutes():"0"+value.getMinutes();
    var second=value.getSeconds()>9?value.getSeconds():"0"+value.getSeconds();
    return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
}
function formatYMDH(time) {
    var value=new Date(parseInt(time));
    var year=value.getFullYear();
    var month=value.getMonth()+1>9?value.getMonth()+1:"0"+(value.getMonth()+1);
    var day=value.getDate()>9?value.getDate():"0"+value.getDate();
    var hour=value.getHours()>9?value.getHours():"0"+value.getHours();
    return year+"-"+month+"-"+day+"("+hour+"时)";
}
function formatYMD(time) {
    var value=new Date(parseInt(time));
    var year=value.getFullYear();
    var month=value.getMonth()+1>9?value.getMonth()+1:"0"+(value.getMonth()+1);
    var day=value.getDate()>9?value.getDate():"0"+value.getDate();
    return year+"年"+month+"月"+day+"日";
}
function formatYM(time) {
    var value=new Date(parseInt(time));
    var year=value.getFullYear();
    var month=value.getMonth()+1>9?value.getMonth()+1:"0"+(value.getMonth()+1);
    var day=value.getDate()>9?value.getDate():"0"+value.getDate();
    return year+"-"+month;
}