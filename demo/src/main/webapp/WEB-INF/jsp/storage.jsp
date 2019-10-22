<html>
<body>
    <input type="text" id="text" />
    <div id="log">
</body>
<script>
(function () {
    var text = localStorage.getItem("inputLog") || "",
        divLog = document.getElementById("log"),
        inputText = document.getElementById("text");
    if (text) {
        divLog.innerHTML = text;
    }
    inputText.addEventListener("change", function () {
        text += inputText.value + "";
        divLog.innerHTML = text;
        localStorage.setItem("inputLog", text);
        inputText.value = "";
    });
}());
</script>
</html>